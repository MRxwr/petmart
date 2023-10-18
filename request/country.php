<?php
if( isset($_GET["state"]) && !empty($_GET["state"]) ){
	if( $states = selectDB('areas', "`enGoverment` LIKE '%{$_GET["state"]}%' OR `arGoverment` LIKE '%{$_GET["state"]}%'")){
		for( $i = 0 ; $i < sizeof($states) ; $i++ ){
			for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
				unset($states[$i][$unsetData[$y]]);
				unset($states[$i]["charges"]);
				unset($states[$i]["arGoverment"]);
				unset($states[$i]["enGoverment"]);
				unset($states[$i]["id"]);
			}
		}
		echo outputData($states);
	}else{
		$error = array("msg"=>"No cities has been found for this state");
		echo outputError($error);die();
	}
}else{
	if( $states = selectDB('areas', "`enGoverment` NOT LIKE '' GROUP BY `enGoverment`")){
		for( $i = 0 ; $i < sizeof($states) ; $i++ ){
			for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
				unset($states[$i][$unsetData[$y]]);
				unset($states[$i]["charges"]);
				unset($states[$i]["enTitle"]);
				unset($states[$i]["arTitle"]);
				unset($states[$i]["id"]);
			}
		}
		echo outputData($states);
	}
}
?>