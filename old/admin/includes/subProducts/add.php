<?php

require ("../config.php");

$productId = $_POST["productId"];
for($i=0; $i< sizeof($_POST["quantity"]); $i++){
	$color = $_POST["colorsAr"][$i];
	$colorEn = $_POST["colorsEn"][$i];
	$size = $_POST["sizesEn"][$i];
	$sizeAr = $_POST["sizesAr"][$i];
	$quantity = $_POST["quantity"][$i];
	$price = $_POST["price"][$i];
	$cost = $_POST["cost"][$i];
	$sku = $_POST["sku"][$i];
	//$code = $_POST["code"];

	$sql = "INSERT INTO 
			`subproducts` 
			(`productId`, `color`, `colorEn`, `size`, `sizeAr`, `quantity`,`price`,`cost`,`sku`) 
			VALUES 
			('{$productId}', '{$color}' ,'{$colorEn}' ,'{$size}' ,'{$sizeAr}', '{$quantity}', '{$price}', '{$cost}', '{$sku}'); 
			";
	var_Dump($result = $dbconnect->query($sql));
}

header("LOCATION: ../../add-sub-products.php?id=" . $_POST["productId"]);

//ALTER TABLE phrases AUTO_INCREMENT = 1

?>