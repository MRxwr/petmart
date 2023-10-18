<?php
if ( isset($_GET["getScreens"]) && !empty($_GET["getScreens"]) ){
	if( $localization = selectDB('localization', "`screen` NOT LIKE '' GROUP BY `screen`")){
		for( $i = 0 ; $i < sizeof($localization) ; $i++ ){
			for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
				unset($localization[$i][$unsetData[$y]]);
				unset($localization[$i]["date"]);
				unset($localization[$i]["enTitle"]);
				unset($localization[$i]["arTitle"]);
				unset($localization[$i]["id"]);
			}
		}
		echo outputData($localization);
	}
}else{
	if( isset($_GET["screen"]) && !empty($_GET["screen"]) ){
		if( $localization = selectDB('localization', "`screen` LIKE '%{$_GET["screen"]}%'")){
			for( $i = 0 ; $i < sizeof($localization) ; $i++ ){
				for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
					unset($localization[$i][$unsetData[$y]]);
					unset($localization[$i]["date"]);
					unset($localization[$i]["id"]);
				}
			}
			echo outputData($localization);
		}else{
			$error = array("msg"=>"No screen has been found");
			echo outputError($error);die();
		}
	}else{
		if( $localization = selectDB('localization',"`status` LIKE '0'")){
			for( $i = 0 ; $i < sizeof($localization) ; $i++ ){
				for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
					unset($localization[$i][$unsetData[$y]]);
					unset($localization[$i]["date"]);
					unset($localization[$i]["id"]);
				}
			}
			echo outputData($localization);
		}
	}
}
?>