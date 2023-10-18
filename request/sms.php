<?php
if( isset($_GET["mobile"]) && !empty($_GET["mobile"]) ){
	$random = rand(000000,999999);
	$msg = "Verification+Code:+{$random}";
	$url = file_get_contents("https://api-server14.com/api/send.aspx?apikey=C1mypIHB22tGHEtoue2vqTHwg&language=1&sender=Pet+Mart&mobile={$_GET["mobile"]}&message={$msg}");
	/*$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL => '',
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 0,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'GET',
	));
	$response = curl_exec($curl);
	curl_close($curl);*/
	$msg = array("code"=>$random,"response"=>$url);
	echo outputData($msg);
	die();
}else{
	$msg = array("msg"=>"Invalid mobile number");
	echo outputError($msg);
	die();
}
?>