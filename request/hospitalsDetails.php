<?php
if ( $hospitals = selectDB('hospitals',"`status` = '0' AND `id` = '{$_GET["id"]}'") ){
	for( $i = 0 ; $i < sizeof($hospitals) ; $i++ ){
		$response["hospital"][$i]["id"] = $hospitals[$i]["id"];
		$response["hospital"][$i]["arTitle"] = $hospitals[$i]["arShop"];
		$response["hospital"][$i]["enTitle"] = $hospitals[$i]["enShop"];
		$response["hospital"][$i]["arDetails"] = $hospitals[$i]["arDetails"];
		$response["hospital"][$i]["enDetails"] = $hospitals[$i]["enDetails"];
		$response["hospital"][$i]["shares"] = $hospitals[$i]["shares"];
		$response["hospital"][$i]["views"] = $hospitals[$i]["views"];
		$response["hospital"][$i]["mobile"] = $hospitals[$i]["mobile"];
		$response["hospital"][$i]["logo"] = $hospitals[$i]["logo"];
	}
	echo outputData($response);
}else{
	$msg = array("msg"=>"No hospital with this Id!");
	echo outputError($msg);
}
?>