<?php
require ("../config.php");

$id = $_GET["id"];
$arTitle = $_POST["arTitle"];
$enTitle = $_POST["enTitle"];
$arDetails = $_POST["arDetails"];
$enDetails = $_POST["enDetails"];
$categoryId = $_POST["categoryId"];
$price = $_POST["price"];
$cost = $_POST["cost"];
$preorder = $_POST["preorder"];
$oneTime = $_POST["oneTime"];
$collection = $_POST["collection"];
$freeDeliv = $_POST["freeDeliv"];
$videoLink = "";
$storeQuantity = 0;
$onlineQuantity = $_POST["onlineQuantity"];
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

$i = 0;
while ( $i < sizeof($_FILES['logo']['tmp_name']) )
{
	if( is_uploaded_file($_FILES['logo']['tmp_name'][$i]) )
	{
		$directory = "../../../logos/";
		$originalfile = $directory . date("d-m-y") . time() .  rand(111111,999999) . ".png";
		move_uploaded_file($_FILES["logo"]["tmp_name"][$i], $originalfile);
		$filenewname = str_replace("../../../logos/",'',$originalfile);
		$sql = "INSERT INTO 
		`images`
		(`id`, `productId`, `imageurl`) 
		VALUES 
		(NULL,'$id','$filenewname')";
		$result = $dbconnect->query($sql);
	}
	$i++;
}

$sql = "UPDATE 
		`products` 
		SET 
		`categoryId`='$categoryId',
		`arTitle`='$arTitle',
		`enTitle`='$enTitle',
		`arDetails`='$arDetails',
		`enDetails`='$enDetails',
		`type`='{$_POST["type"]}',
		`oneTime`='{$oneTime}',
		`freeDeliv`='{$freeDeliv}',
		`collection`='{$collection}',
		`price`='$price',
		`cost`='$cost',
		`discount`='$discount',
		`onlineQuantity`='$onlineQuantity',
		`storeQuantity`='$storeQuantity',
		`weight`='$weight',
		`width`='$width',
		`height`='$height',
		`preorder`='{$preorder}',
		`preorderText`='{$preorderText}',
		`preorderTextAr`='{$preorderTextAr}',
		`depth`='$depth'
		WHERE 
		`id`= '$id'";
$result = $dbconnect->query($sql);

if ( $_POST["type"] == 1 ){
    $sql = "UPDATE 
    		`subproducts` 
    		SET 
    		`quantity`='{$_POST["quantity"]}',
    		`price`='{$_POST["price"]}',
    		`sku`='{$_POST["sku"]}',
    		`cost`='{$_POST["cost"]}',
			`size`= ''
    		WHERE 
    		`productId`= '{$id}'";
    $result = $dbconnect->query($sql);
}else{
    $sql = "UPDATE
    		`subproducts` 
    		SET 
    		`hidden`='1'
    		WHERE 
    		`productId`= '{$id}'";
    $result = $dbconnect->query($sql);
}
header("LOCATION: ../../product.php");

?>