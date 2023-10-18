<?php
if ( $settigns = selectDB('settings'," `id` LIKE '1'") ){
		$response["version"] = $settigns[0]["version"];
		$response["enTerms"] = $settigns[0]["enTerms"];
		$response["arTerms"] = $settigns[0]["arTerms"];
		$response["enPolicy"] = $settigns[0]["enPolicy"];
		$response["arPolicy"] = $settigns[0]["arPolicy"];
		$response["email"] = $settigns[0]["email"];
		$response["call"] = $settigns[0]["call"];
		$response["whatsapp"] = $settigns[0]["whatsapp"];
		echo outputData($response);
}else{
	$error = array("msg" => "Please enter type, 'list', 'profile', 'password'");
	echo outputError($error);die();
}
?>