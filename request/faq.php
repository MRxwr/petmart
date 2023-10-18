<?php
if ( $faqs = selectDB('faq',"`status` LIKE '0'") ){
	for( $i = 0 ; $i < sizeof($faqs) ; $i++ ){
		$response["faq"][$i]["question"] = $faqs[$i]["question"];
		$response["faq"][$i]["answer"] = $faqs[$i]["answer"];
	}
	echo outputData($response);
}else{
	$msg = array("msg"=>"No faq avaible!");
	echo outputError($msg);
}
?>