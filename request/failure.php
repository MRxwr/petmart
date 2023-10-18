<?php
if( isset($_GET["PaymentID"]) && !empty($_GET["PaymentID"]) ){
	$data = array(
		'endpoint' => 'PaymentStatusCheck',
		'apikey' => 'CKW-1627824132-1075',
		'Key' => $_GET["PaymentID"],
		'KeyType' => 'PaymentID'
		);
	$response1 = outputData(checkPayment($data));
	$response = json_decode($response1,true);
	if( $response["data"]["id"] == $data["Key"] ){
		$error = array("msg" => "Payment failed, Please send payment id correctly");
		outputError($error);die();
	}else{
		$response;
	}
	$orderId = $response["data"]["id"];
	if ( $response["data"]["status"] != "Paid" ){
		$orders = selectDB('orders'," `orderId` LIKE '".$orderId."'");
		$orders[0]["quantity"];
		if ( $orders[0]["status"] == "0" ){
			updateDB('orders',array('status'=>"7")," `orderId` LIKE '".$orderId."'");
			outputError(array("msg"=>"failed payment"));
		}
	}else{
		$error = array("msg" => "Something went wrong, please try again later");
		outputError($error);
	}
}else{
	$error = array("msg" => "Something wrong happned please contact administration");
	outputError($error);
}
?>