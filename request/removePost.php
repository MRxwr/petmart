<?php
if ( isset($_GET["remove"]) && $_GET["remove"] == "1" ){
	if ( !isset($_GET["id"]) || empty($_GET["id"]) ){
		$error = array("msg"=>"Please enter post Id");
		echo outputError($error);die();
	}
	$data = array("status"=>'1');
	if( updateDB('items',$data,"`id` = {$_GET["id"]}") ){
		$response = array(
			'msg'=>"Removed successfully"
		);
		echo outputData($response);
	}else{
		$error = array("msg"=>"Please enter post data correctly.");
		echo outputError($error);die();
	}
}else{
	$error = array("msg"=>"Please enter remove type");
	echo outputError($error);die();
}

?>