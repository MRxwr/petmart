<?php
if ( isset($_GET["buy"]) && !empty($_GET["buy"]) ){
	if( !isset($_POST["packageId"]) || empty($_POST["packageId"]) ){
		$msg = array("msg"=>"Please send package Id!");
		echo outputError($msg); die();
	}else{
		if( $packages = selectDB('packages',"`id` = '{$_POST["packageId"]}' AND `status` = '0'") ){
			
		}else{
			$msg = array("msg"=>"Please enter a valid package Id!");
			echo outputError($msg); die();
		}
	}
	if( !isset($_POST["customerId"]) || empty($_POST["customerId"]) ){
		$msg = array("msg"=>"Please send customer Id!");
		echo outputError($msg); die();
	}else{
		if( $customer = selectDB('customers',"`id` = '{$_POST["customerId"]}' AND `status` = '0'") ){
		}else{
			$msg = array("msg"=>"Please enter a valid customer Id!");
			echo outputError($msg); die();
		}
	}
	if( !isset($_POST["paymentMethod"]) || empty($_POST["paymentMethod"]) ){
		$msg = array("msg"=>"Please send paymentMethod Id!");
		echo outputError($msg); die();
	}
	
// 	$paymentData = [
// 		'endpoint' => 'PaymentRequestExicute',
// 		'apikey' => 'CKW-1627824132-1075',
// 		'PaymentMethodId' => $_POST["paymentMethod"],
// 		'CustomerName' => $customer[0]["name"],
// 		'DisplayCurrencyIso' => 'KWD',
// 		'MobileCountryCode' => '+965',
// 		'CustomerMobile' => (string)substr($customer[0]["mobile"],0,11),
// 		'CustomerEmail' => $customer[0]["email"],
// 		'InvoiceValue' => $packages[0]["price"],
// 		'CallBackUrl' => 'https://createkwservers.com/petmart2/request/index.php?action=success',
// 		'ErrorUrl' => 'https://createkwservers.com/petmart2/request/index.php?action=failure', 
// 		'Language' => 'en',
// 		'SourceInfo' => '',
// 		];
		$PaymentAPIKey = 'CKW-1666037299-4586';
		$paymentMethod =  $_POST["paymentMethod"];
		$name = $customer[0]["name"];
		$phone1 = $customer[0]["mobile"];
		$settingsEmail =  $customer[0]["email"];
		$totalPrice = $packages[0]["price"];
		
		$paymentData = array(
            "endpoint"                 => "PaymentRequestExicuteForStore",
            "apikey"                 => "$PaymentAPIKey",
            "PaymentMethodId"         => "$paymentMethod",
            "CustomerName"            => "$name",
            "DisplayCurrencyIso"    => "KWD", 
            "MobileCountryCode"        => "+965", 
            "CustomerMobile"        => substr($phone1,0,11),
            "CustomerEmail"            => $settingsEmail,
            "invoiceValue"            => $totalPrice,
            "SourceInfo"            => '',
            "CallBackUrl"            =>'https://petmartkw.com/request/index.php?action=success',
            "ErrorUrl"                => 'https://petmartkw.com/request/index.php?action=failure', 
            );

	if( $order = payment($paymentData) ){
		$response = $order;
		//echo outputData($response); die();
	}else{
		$msg = array("msg"=>"something wrong happened, Please try again.");
		echo outputError($msg); die();
	}
	
	$data = array(
				"orderId" => $order["id"],
				"packageId" => $packages[0]["id"],
				"packageTitle" => $packages[0]["enShop"],
				"packagePoints" => $packages[0]["points"],
				"packageValidity" => $packages[0]["validity"],
				"packagePrice" => $packages[0]["price"],
				"customerId" => $customer[0]["id"],
				"customerName" => $customer[0]["name"],
				"cutomerNumber" => $customer[0]["mobile"],
			);
	if ( insertDB("order",$data) ){
		echo outputData($response);
	}else{
		$msg = array("msg"=>"something wrong happened, Please try again.");
		echo outputError($msg); die();
	}
}elseif( $packages = selectDB('packages',"`status` = '0'") ){
	for( $i = 0 ; $i < sizeof($packages) ; $i++ ){
		$response["package"][$i]["id"] = $packages[$i]["id"];
		$response["package"][$i]["arTitle"] = $packages[$i]["arShop"];
		$response["package"][$i]["enTitle"] = $packages[$i]["enShop"];
		$response["package"][$i]["arDetails"] = $packages[$i]["arDetails"];
		$response["package"][$i]["enDetails"] = $packages[$i]["enDetails"];
		$response["package"][$i]["points"] = $packages[$i]["points"];
		$response["package"][$i]["validity"] = $packages[$i]["validity"];
		$response["package"][$i]["price"] = $packages[$i]["price"];
		$response["package"][$i]["image"] = $packages[$i]["logo"];
	}
	echo outputData($response);
}else{
	$msg = array("msg"=>"No packages avaible!");
	echo outputError($msg);
}
?>