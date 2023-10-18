<?php
require ("../config.php");
if ( isset($_POST["type"]) ){
    $type = $_POST["type"];
}else{
    $type = "0";
}
$artitle = $_POST["arTitle"];
$entitle = $_POST["enTitle"];
$arDetails = $_POST["arDetails"];
$enDetails = $_POST["enDetails"];
$categoryId = $_POST["categoryId"];
$price = $_POST["price"];
$cost = $_POST["cost"];
$preorder = $_POST["preorder"];
$oneTime = $_POST["oneTime"];
$freeDeliv = $_POST["freeDeliv"];
$collection = $_POST["collection"];
$videoLink = "";
$storeQuantity = 0;
$onlineQuantity = 0;
$discount = $_POST["discount"];
$preorderText = $_POST["preorderText"];
$preorderTextAr = $_POST["preorderTextAr"];
if ( isset($_POST["weight"]) ){
    $weight = $_POST["weight"];
    $width = $_POST["width"];
    $height = $_POST["height"];
    $depth = $_POST["depth"]; 
}else{
    $weight = 0;
    $width = 0;
    $height = 0;
    $depth = 0; 
}

$sql = "INSERT INTO 
		`products`
		(`categoryId`, `arTitle`, `enTitle`, `arDetails`, `enDetails`, `price`, `cost`, `video`, `storeQuantity`, `onlineQuantity`,`discount`, `weight`, `width`, `height`,`depth`, `preorder`, `preorderText`, `preorderTextAr`, `type`, `oneTime`, `collection`, `freeDeliv`) 
		VALUES
		('{$categoryId}','{$artitle}','{$entitle}','{$arDetails}','{$enDetails}', '{$price}', '{$cost}','{$videoLink}','{$storeQuantity}','{$onlineQuantity}', '{$discount}','{$weight}','{$width}','{$height}', '{$depth}', '{$preorder}', '{$preorderText}', '{$preorderTextAr}', '{$type}', '{$oneTime}', '{$collection}', '{$freeDeliv}')";
$result = $dbconnect->query($sql);

$sql = "SELECT * FROM `products` WHERE `enTitle` LIKE '{$entitle}' AND `arTitle` LIKE '{$artitle}'";
$result = $dbconnect->query($sql);
$row = $result->fetch_assoc();
$productID = $row["id"];

if ( $type == 1){
	$productId = $productID;
	$color = "";
	$colorEn = "";
	$size = "";
	$quantity = $_POST["quantity"];
	$code = "";
	$sku = $_POST["sku"];

	$sql = "INSERT INTO 
			`subproducts` 
			(`productId`, `color`, `colorEn`, `size`, `quantity`,`price`,`cost`,`sku`) 
			VALUES 
			('{$productId}', '{$color}' , '{$colorEn}', '{$size}', '{$quantity}','{$price}','{$cost}', '{$sku}'); 
			";
	$result = $dbconnect->query($sql);
}

$i = 0;
while ( $i < sizeof($_FILES['logo']['tmp_name']) )
{
	if( is_uploaded_file($_FILES['logo']['tmp_name'][$i]) )
	{
		$directory = "../../../logos/";
		$originalfile = $directory . date("d-m-y") . time() . rand(111111,999999) . ".png";
		move_uploaded_file($_FILES["logo"]["tmp_name"][$i], $originalfile);
		$filenewname = str_replace("../../../logos/",'',$originalfile);
		$sql = "INSERT INTO `images`(`id`, `productId`, `imageurl`) VALUES (NULL,'{$productID}','{$filenewname}')";
		$result = $dbconnect->query($sql);
	}
	$i++;
}
header("LOCATION: ../../product.php");

//ALTER TABLE phrases AUTO_INCREMENT = 1

?>