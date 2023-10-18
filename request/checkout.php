<?php
if ( isset($_GET["addressId"]) && !empty($_GET["addressId"]) ){
	$settings = selectDB('settings',"`id` LIKE '1'");
	$response = [
		"delivery" => $settings[0]["delivery"]
	];
	echo outputData($response);
}else{
	$response["msg"] = "Please enter customer Id";
	echo outputError($response);die();
}

?>