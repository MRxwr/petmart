<?php
//add complain
if ( isset($_GET["userId"]) AND !empty($_GET["userId"]) ){
	$data = $_GET;
	unset($data["action"]);
	unset($data["lang"]);
	if( insertDB('services',$data ) ){
		if ( $services = selectDB('services'," `id` LIKE (SELECT LAST_INSERT_ID()) ") ){
			for( $i = 0 ; $i < sizeof($services) ; $i++ ){
				$response["msg"] = "Your request has been sent Successfully, We will get in touch soon.";
				if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
					$response["msg"] = "تم إرسال طلبك بتجاح، سيتم التواصل معك قريبا";
				}
			}
			echo outputData($response);
		}else{
			$response["msg"] = "Service request has not been sent. please try again";
			if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
				$response["msg"] = "لم يتم إرسال الطلب بالشكل الصحيح ، الرجاء المحاولة مرة أخرى";
			}
			echo outputError($response);die();
		}
	}else{
		$response["msg"] = "We had an issue submitting your service request, please try again later.";
		if ( isset($_GET["lang"]) && $_GET["lang"] == "ar" ){
			$response["msg"] = "حدثت مشكلة أثناء ارسال الطلب ، الرجاء المحاولة مرة أخرى";
		}
		echo outputError($response);die();
	}
}else{
	$response["msg"] = "Please enter user Id";
	echo outputError($response);die();
}
?>