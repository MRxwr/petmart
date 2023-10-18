<?php
if ( isset($_GET["type"]) && !empty($_GET["type"]) && $_GET["type"] == 2 ){
	$type = 0;
}else{
	$type = 1;
}

//echo $type;

if ( $filters = selectDB('filters',"`status` = '0'") ){
	for( $i = 0 ; $i < sizeof($filters) ; $i++ ){
		$response["filters"][$i]["id"] = $filters[$i]["id"];
		$response["filters"][$i]["arTitle"] = $filters[$i]["arTitle"];
		$response["filters"][$i]["enTitle"] = $filters[$i]["enTitle"];
	}
}else{
	$response["filters"] = array();
}

if ( isset($_GET["filter"]) && !empty($_GET["filter"]) ){
	if ( $vendors = selectDB('vendors_filters',"`filterId` = '{$_GET["filter"]}' AND `status` = '0'") ){
		for( $i = 0 ; $i < sizeof($vendors) ; $i++ ){
			if($vendorDetails = selectDB('vendors',"`id` = '{$vendors[$i]["vendorId"]}' AND `status` = '0' AND `is_boothat` = '{$type}'")){
				$response["vendors"][$i]["id"] = $vendorDetails[0]["id"];
				$response["vendors"][$i]["arTitle"] = $vendorDetails[0]["arShop"];
				$response["vendors"][$i]["enTitle"] = $vendorDetails[0]["enShop"];
				$response["vendors"][$i]["image"] = $vendorDetails[0]["header"];
				$response["vendors"][$i]["logo"] = $vendorDetails[0]["logo"];
			}else{
				$response["vendors"] = array();
			}
		}
	}else{
		if ( $filters = selectDB('filters',"`status` = '0'") ){
			for( $i = 0 ; $i < sizeof($filters) ; $i++ ){
				$msg["filters"][$i]["id"] = $filters[$i]["id"];
				$msg["filters"][$i]["arTitle"] = $filters[$i]["arTitle"];
				$msg["filters"][$i]["enTitle"] = $filters[$i]["enTitle"];
			}
		}else{
			$msg["filters"] = array();
		}
		$msg["msg"] = "No Influnces avaible!";
		echo outputError($msg);die();
	}
	echo outputData($response);
}elseif ( $vendors = selectDB('vendors',"`status` = '0' AND `is_boothat` = '{$type}'") ){
	for( $i = 0 ; $i < sizeof($vendors) ; $i++ ){
		$response["vendors"][$i]["id"] = $vendors[$i]["id"];
		$response["vendors"][$i]["arTitle"] = $vendors[$i]["arShop"];
		$response["vendors"][$i]["enTitle"] = $vendors[$i]["enShop"];
		$response["vendors"][$i]["image"] = $vendors[$i]["header"];
		$response["vendors"][$i]["logo"] = $vendors[$i]["logo"];
	}
	echo outputData($response);
}else{
	if ( $filters = selectDB('filters',"`status` = '0'") ){
		for( $i = 0 ; $i < sizeof($filters) ; $i++ ){
			$msg["filters"][$i]["id"] = $filters[$i]["id"];
			$msg["filters"][$i]["arTitle"] = $filters[$i]["arTitle"];
			$msg["filters"][$i]["enTitle"] = $filters[$i]["enTitle"];
		}
	}else{
		$msg["filters"] = array();
	}
	$msg["msg"] = "No Influnces avaible!";
	echo outputError($msg);
}
?>