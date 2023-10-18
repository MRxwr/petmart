<?php

if( !isset($_REQUEST["auctionId"]) || empty($_REQUEST["auctionId"]) ){
	$msg = array("msg"=>"Please set auction Id");
	echo outputError($msg);die();
}

if( !isset($_REQUEST["accept"]) || empty($_REQUEST["accept"]) ){
	$msg = array("msg"=>"Please set accept value");
	echo outputError($msg);die();
}

if( $auction = selectDB("auctions","`id` = '{$_REQUEST["auctionId"]}'") ){
	if( $_REQUEST["accept"] == 1 ){
		$dataNoti = array(
			"customerId"	=> $auction[0]["winnerId"],
			"body"	=> "Congrats, You won the auction. مبروك، انت الرابح في المزاد",
			"title"	=> "Auction Winner - رابح المزاد"
		);
		$dataInsert = array(
			"userId"	=> $auction[0]["winnerId"],
			"notification"	=> "Congrats, You won the auction. مبروك، انت الرابح في المزاد",
			"auctionId"	=> $auction[0]["id"],
			"auctionType"	=> 2
		);
		notificationToUser($dataNoti);
		insertDB("notification",$dataInsert);
		updateDB("auctions",array("accept"=>1),"`id` = '{$auction[0]["id"]}'");
		updateDB("notification",array("auctionType"=>2),"`auctionId` = '{$auction[0]["id"]}'");
		$msg = array("msg"=>"Auction accepted.");
		echo outputData($msg);die();
	}elseif( $_REQUEST["accept"] == 2 ){
		$dataNoti = array(
			"customerId"	=> $auction[0]["winnerId"],
			"body"	=> "Opps, auction has been cancelled by Owner - تم إلغاء المزاد من قبل المالك",
			"title"	=> "Auction Stopped - تم إيقاف المزاد"
		);
		$dataInsert = array(
			"userId"	=> $auction[0]["winnerId"],
			"notification"	=> "Opps, auction has been cancelled by Owner - تم إلغاء المزاد من قبل المالك",
			"auctionId"	=> 0,
			"auctionType"	=> 0
		);
		notificationToUser($dataNoti);
		insertDB("notification",$dataInsert);
		updateDB("auctions",array("accept"=>2),"`id` = '{$auction[0]["id"]}'");
		$msg = array("msg"=>"Auction declined.");
		echo outputData($msg);die();
	}else{
		$msg = array("msg"=>"Please set a correct accept value");
		echo outputError($msg);die();
	}
}else{
	$msg = array("msg"=>"Please set a correct auction id");
	echo outputError($msg);die();
}
?>