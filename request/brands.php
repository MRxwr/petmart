<?php
if ( $brands = selectDB('brands',"`status` LIKE '0' ORDER BY `enTitle` ASC") ){
	for( $i = 0 ; $i < sizeof($brands) ; $i++ ){
		$response["brands"][$i]["id"] = $brands[$i]["id"];
		$response["brands"][$i]["arTitle"] = $brands[$i]["arTitle"];
		$response["brands"][$i]["enTitle"] = $brands[$i]["enTitle"];
		$response["brands"][$i]["image"] = $brands[$i]["logo"];
	}
	echo outputData($response);
}else{
	$response["brands"] = array();
	$msg = array("msg"=>"No brands avaible!");
	echo outputError($msg);
}
?>