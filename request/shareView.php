<?php

if( isset($_GET["update"]) && $_GET["update"] == "share" ){
	if( isset($_GET["type"]) && $_GET["type"] == "item" ){
		$table = "items";
	}elseif( isset($_GET["type"]) && $_GET["type"] == "hospital" ){
		$table = "hospitals";
	}elseif( isset($_GET["type"]) && $_GET["type"] == "shop" ){
		$table = "shops";
	}elseif( isset($_GET["type"]) && $_GET["type"] == "shopItem" ){
		$table = "shopItems";
	}elseif( isset($_GET["type"]) && $_GET["type"] == "service" ){
		$table = "service";
	}else{
		$error = array("msg"=>"Please set type as item or hospital or shop or service");
		echo outputError($error);die();
	}
	if( isset($_GET["id"]) && !empty($_GET["id"]) ){
		if( $item = selectDB($table,"`id` = '{$_GET["id"]}'") ){
			$shares = $item[0]["shares"]+1;
			updateDB($table,array('shares'=>$shares),"`id` = '{$_GET["id"]}'");
			$msg = array("msg"=>"Post has been updated successfully");
			echo outputData($msg);
		}else{
			$error = array("msg"=>"An error happened, Please try again later.");
			echo outputError($error);die();
		}
	}else{
		$error = array("msg"=>"Please set id correctly");
		echo outputError($error);die();
	}
}elseif( isset($_GET["update"]) && $_GET["update"] == "view" ){
	if( isset($_GET["type"]) && $_GET["type"] == "item" ){
		$table = "items";
	}elseif( isset($_GET["type"]) && $_GET["type"] == "hospital" ){
		$table = "hospitals";
	}elseif( isset($_GET["type"]) && $_GET["type"] == "shop" ){
		$table = "shopItems";
	}elseif( isset($_GET["type"]) && $_GET["type"] == "service" ){
		$table = "service";
	}else{
		$error = array("msg"=>"Please set type as item or hospital or shop or service");
		echo outputError($error);die();
	}
	if( isset($_GET["id"]) && !empty($_GET["id"]) ){
		if( $item = selectDB($table,"`id` = '{$_GET["id"]}'") ){
			$views = $item[0]["views"]+1;
			updateDB($table,array('views'=>$views),"`id` = '{$_GET["id"]}'");
			$msg = array("msg"=>"Post has been updated successfully");
			echo outputData($msg);
		}else{
			$error = array("msg"=>"An error happened, Please try again later.");
			echo outputError($error);die();
		}
	}else{
		$error = array("msg"=>"Please set id correctly");
		echo outputError($error);die();
	}
}else{
	$error = array("msg"=>"Please set update as share or view");
	echo outputError($error);die();
}
?>