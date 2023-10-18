<?php
session_start();
header('Content-type: application/json');
require("admin/includes/config.php");
require("admin/includes/translate.php");
require("includes/checksouthead.php");

ini_set( 'precision', 4 );
ini_set( 'serialize_precision', -1 );
date_default_timezone_set('Asia/Riyadh');

if ( isset($userID) AND !empty($userID) ){
	$sql = "SELECT `userDiscount` FROM `s_media` WHERE `id` = '4' ";
	$result = $dbconnect->query($sql);
	$row = $result->fetch_assoc();
	$userDiscount = $row["userDiscount"];
	$userId = $userID;
}else{
	$userDiscount = 0;
	$userId = 0;
}

if ( isset($_POST["paymentMethod"]) ){
	if ( $_POST["paymentMethod"] == 2 ){
		$VisaCard =  $_POST["creditTax"];
	}else{
		$VisaCard = 0 ;
	}
    $paymentMethod = $_POST["paymentMethod"];
}else{
    $paymentMethod = str_replace($check, "", $_SESSION["createKW"]["pMethod"]);
}

$check = ["'",'"',")","(",";","?",">","<","~","!","#","$","%","^","&","*","-","_","=","+","/","|",":"];
$totalPrice = $_POST["totalPrice"];
$_SESSION["createKW"]["totalPrice"] = $totalPrice;

$place    = str_replace($check, "", $_SESSION["createKW"]["place"]);
$name     = str_replace($check, "", $_SESSION["createKW"]["name"]);
$phone    = str_replace($check, "", $_SESSION["createKW"]["phone"]);
$email 	  = $_SESSION["createKW"]["email"];
$delivery = str_replace($check, "", $_SESSION["createKW"]["delivery"]);
$country  = str_replace($check, "", $_SESSION["createKW"]["country"]);
$postalCode = str_replace($check, "", $_SESSION["createKW"]["postalCode"]);

if ( $place == 1 ){
    $area = str_replace($check, "", $_SESSION["createKW"]["area"]);
    $block = str_replace($check, "", $_SESSION["createKW"]["block"]);
    $street = str_replace($check, "", $_SESSION["createKW"]["street"]);
    $house = str_replace($check, "", $_SESSION["createKW"]["house"]);
    $avenue = str_replace($check, "", $_SESSION["createKW"]["avenue"]);
    $notes = str_replace($check, "", $_SESSION["createKW"]["notes"]);
    $areaA = "";
    $building = "";
    $floor = "";
    $apartment = "";
    $blockA = "";
    $streetA = "";
    $avenueA = "";
    $notesA = "";
}elseif( $place == 3 ){
	$area = str_replace($check, "", $_SESSION["createKW"]["area"]);
    $block = str_replace($check, "", $_SESSION["createKW"]["block"]);
    $street = str_replace($check, "", $_SESSION["createKW"]["street"]);
    $house = str_replace($check, "", $_SESSION["createKW"]["house"]);
    $avenue = str_replace($check, "", $_SESSION["createKW"]["avenue"]);
    $notes = str_replace($check, "", $_SESSION["createKW"]["notes"]);
    $areaA = "";
    $building = "";
    $floor = "";
    $apartment = "";
    $blockA = "";
    $streetA = "";
    $avenueA = "";
    $notesA = "";
}else{
    $building = str_replace($check, "", $_SESSION["createKW"]["building"]);
    $floor = str_replace($check, "", $_SESSION["createKW"]["floor"]);
    $apartment = str_replace($check, "", $_SESSION["createKW"]["apartment"]);
    $areaA = str_replace($check, "", $_SESSION["createKW"]["areaA"]);
    $blockA = str_replace($check, "", $_SESSION["createKW"]["blockA"]);
    $streetA = str_replace($check, "", $_SESSION["createKW"]["streetA"]);
    $avenueA = str_replace($check, "", $_SESSION["createKW"]["avenueA"]);
    $notesA = str_replace($check, "", $_SESSION["createKW"]["notesA"]);
    $area = "";
    $block = "";
    $street= "";
    $house = "";
    $avenue = "";
    $notes = "";
}

if ( isset($_POST["orderVoucher"]) AND !empty($_POST["orderVoucher"]) ){
    $orderVoucher = $_POST["orderVoucher"];
}else{
    $orderVoucher = "0";
}

$sql = "SELECT `percentage`,`voucher`
        FROM `vouchers`
        WHERE `id` = '".$orderVoucher."'
        ";
$result = $dbconnect->query($sql);
$row = $result->fetch_assoc();
if ( isset($row["percentage"]) ){
	@$discount = $row["percentage"];
	$_SESSION["createKW"]["discount"] = $discount;
}else{
	@$discount = 0;
}

if ( isset($row["voucher"]) ){
	@$voucherTitle = $row["voucher"];
	@$_SESSION["createKW"]["voucher"] = $row["voucher"];
}else{
	@$voucherTitle = '';
	@$_SESSION["createKW"]["voucher"] = '';
}

for ( $i = 0; $i < sizeof($_SESSION["cart"]["id"]); $i++ ){
	$sql = "SELECT
			`enTitle`, `discount`, sp.price AS subPrice, sp.id as RealId
			FROM 
			`products` AS p
			JOIN `subproducts` AS sp
			ON p.id = sp.productId
			WHERE 
			p.id LIKE '".$_SESSION["cart"]["id"][$i]."'
			AND
			sp.id = '".$_SESSION["cart"]["subId"][$i]."'
			AND
			sp.hidden = '0'
			";
	$result = $dbconnect->query($sql);
	$row = $result->fetch_assoc();
	$RealId[] = $row["RealId"];
	$RealTitle[] = $row["enTitle"];
	$productDiscounts[] = $row["discount"];
	if ( $discount > 0 ){
		$row["subPrice"] = $row["subPrice"] - ( $row["subPrice"] * $discount / 100 );
	}elseif ( $row["discount"] > 0 ){
		$row["subPrice"] = $row["subPrice"] - ( $row["subPrice"] * $row["discount"] / 100 );
	}
	$productPrice[] = $row["subPrice"]*$_SESSION["cart"]["qorder"][$i];
}

require_once ('api/paymentBody.php');
//print_r($postMethodLines);print_r($resultMY);die();

$date = date("Y-m-d H:i:s");
$i = 0;
while ( $i < sizeof ($_SESSION["cart"]["id"]) ){
	$id = $_SESSION["cart"]["id"][$i];
	$quantity = $_SESSION["cart"]["qorder"][$i];
	$size = str_replace("_", " ", $_SESSION["cart"]["size"][$i]);
	$sku = str_replace("_", " ", $_SESSION["cart"]["sku"][$i]);
	$productNote = str_replace("_", " ", $_SESSION["cart"]["productNotes"][$i]);
	$collection = $_SESSION["cart"]["collection"][$i];
	$subId = $_SESSION["cart"]["subId"][$i];
	$sql = "INSERT INTO `orders`
			(`date`,`userId`, `orderId`, `email`, `fullName`, `mobile`, `productId`, `quantity`, `discount`, `totalPrice`, `voucher`, `place`, `area`, `block`, `street`, `avenue`, `house`, `notes`, `areaA`, `blockA`, `streetA`, `avenueA`, `building`, `floor`, `apartment`, `notesA`, `country`, `status`, `pMethod`, `d_s_charges`, `size`, `userDiscount`, `creditTax`,`postalCode`, `productDiscount`, `productPrice`,`sku`, `cardFrom`, `cardTo`, `cardMsg`, `subId`, `civilId`, `productNote`, `collection`) 
			VALUES
			('".$date."', '".$userId."', '".$orderId."', '".$email."', '".$name."', '".$phone."', '".$id."', '".$quantity."', '".$discount."', '".round($totalPrice,2)."', '".$orderVoucher."', '".$place."', '".$area."', '".$block."', '".$street."', '".$avenue."', '".$house."', '".$notes."', '".$areaA."', '".$blockA."', '".$streetA."', '".$avenueA."', '".$building."', '".$floor."', '".$apartment."', '".$notesA."', '".$country."', '0', '".$paymentMethod."', '".$delivery."', '".$size."', '".$userDiscount."', '".round($VisaCard,2)."','".$postalCode."', '".$productDiscounts[$i]."', '".$productPrice[$i]."', '{$sku}', '{$_POST["cardFrom"]}', '{$_POST["cardTo"]}', '{$_POST["cardMsg"]}', '{$subId}', '{$_POST["civilId"]}', '{$productNote}', '{$collection}')
			";
	$result = $dbconnect->query($sql);
	$i++;
}
if ( $_POST["paymentMethod"] == 3 ){
	$_SESSION["createKW"]["pMethod"] = $_POST["paymentMethod"];
	$_SESSION["createKW"]["orderId"] = $resultMY["data"]["InvoiceId"];
	header("Location: details.php?c=".$resultMY["data"]["InvoiceId"]);
}
elseif ( $_POST["paymentMethod"] == 1 ){
	$_SESSION["createKW"]["pMethod"] = $_POST["paymentMethod"];
	$_SESSION["createKW"]["orderId"] = $resultMY["data"]["InvoiceId"];
	header("Location: " . $resultMY["data"]["PaymentURL"]);
}
elseif ( $_POST["paymentMethod"] == 2 ){
	$_SESSION["createKW"]["pMethod"] = $_POST["paymentMethod"];
	$_SESSION["createKW"]["orderId"] = $resultMY["data"]["InvoiceId"];
	header("Location: " . $resultMY["data"]["PaymentURL"]);
}
?>