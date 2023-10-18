<?php
//add complain
if ( isset($_GET["userId"]) AND !empty($_GET["userId"]) ){
	$data = $_GET;
	unset($data["action"]);
	if( insertDB('complains',$data ) ){
		if ( $complains = selectDB('complains'," `id` LIKE (SELECT LAST_INSERT_ID()) ") ){
			for( $i = 0 ; $i < sizeof($complains) ; $i++ ){
				$response["msg"] = "Your complain has been issued, we will get in touch shortly.";
			}
			echo outputData($response);
		}else{
			$response["msg"] = "Complain has not been sent. please try again";
			echo outputError($response);die();
		}
	}else{
		$response["msg"] = "We had an issue submitting your complain, please try again later.";
		echo outputError($response);die();
	}
}else{
	$response["msg"] = "Please enter user Id";
	echo outputError($response);die();
}
?>