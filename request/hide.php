<?php
if( $settings = selectDB('settings',"`id` = '1'") ){
	$response["hide"] = $settings[0]["hideSocial"];
}
echo outputData($response);die();
?>