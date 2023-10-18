<?php
if ( $shops = selectDB('shops',"`status` = '0'") ){
	for( $i = 0 ; $i < sizeof($shops) ; $i++ ){
		$response["shop"][$i]["id"] = $shops[$i]["id"];
		$response["shop"][$i]["arTitle"] = $shops[$i]["arShop"];
		$response["shop"][$i]["enTitle"] = $shops[$i]["enShop"];
		$response["shop"][$i]["arDetails"] = $shops[$i]["arDetails"];
		$response["shop"][$i]["enDetails"] = $shops[$i]["enDetails"];
		$response["shop"][$i]["shares"] = $shops[$i]["shares"];
		$response["shop"][$i]["views"] = $shops[$i]["views"];
		$response["shop"][$i]["mobile"] = $shops[$i]["mobile"];
		$response["shop"][$i]["logo"] = $shops[$i]["logo"];
	}
	echo outputData($response);
}else{
	$msg = array("shop"=>array(),"msg"=>"No shops avaible!"); 
	echo outputError($msg);
}
?>