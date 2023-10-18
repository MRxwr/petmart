<?php
if( isset($_GET["orderId"]) && !empty($_GET["orderId"]) ){
	$orderId = $_GET["orderId"];
	if ( $orders = selectDB('order'," `orderId` LIKE '".$orderId."'") ){
		if ( $orders[0]["status"] == "0" ){
			updateDB('order',array('status'=>"1")," `orderId` LIKE '".$orderId."'");
			$customerId = $orders[0]["customerId"];
			$price = $orders[0]["price"];
			$customer = selectDB('customers'," `id` LIKE '".$customerId."'");
			$points = $customer[0]["points"] + $orders[0]["packagePoints"]; 
			$validity = $customer[0]["validity"] + $orders[0]["packageValidity"]; 
			updateDB('customers',array('points'=> $points, 'validity' => $validity)," `id` = '{$customerId}'");
			echo outputData(array("orderId"=>$_GET["orderId"],"status"=>"success"));
		}else{
			$error = array("msg" => "order with this Id is already regitered in the system.");
			echo outputError($orders);
		}
	}else{
		$error = array("msg" => "Something went wrong, orderId");
		echo outputError($error);
	}
}else{
	$error = array("msg" => "Something wrong happned please contact administration");
	echo outputError($error);
}
?>