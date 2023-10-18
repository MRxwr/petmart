<?php
if ( $services = selectDB('service',"`status` = '0'") ){
	for( $i = 0 ; $i < sizeof($services) ; $i++ ){
		$response["services"][$i]["id"] = $services[$i]["id"];
		$response["services"][$i]["arTitle"] = $services[$i]["arShop"];
		$response["services"][$i]["enTitle"] = $services[$i]["enShop"];
		$response["services"][$i]["arDetails"] = $services[$i]["arDetails"];
		$response["services"][$i]["enDetails"] = $services[$i]["enDetails"];
		$response["services"][$i]["shares"] = $services[$i]["shares"];
		$response["services"][$i]["views"] = $services[$i]["views"];
		$response["services"][$i]["mobile"] = $services[$i]["mobile"];
		$response["services"][$i]["logo"] = $services[$i]["logo"];
	}
	echo outputData($response);
}else{
	$msg = array("services"=>array(),"msg"=>"No services avaible!"); 
	echo outputError($msg);
}
?>