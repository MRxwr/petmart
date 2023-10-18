<?php
//var_dump( $_GET["type"]);exit;
if( $_GET["type"] == "send" ){
	if( !isset($_POST["auctionId"]) || empty($_POST["auctionId"]) ){
		$msg = array("msg" => "Please submit auction id");
		echo outputError($msg);die();
	}
	if( !isset($_POST["userId"]) || empty($_POST["userId"]) ){
		$msg = array("msg" => "Please submit user id");
		echo outputError($msg);die();
	}
	if( !isset($_POST["rate"]) || empty($_POST["rate"]) ){
		$msg = array("msg" => "Please submit rating.");
		echo outputError($msg);die();
	}
	
	if( $auction = selectDB("auctions","`id` = '{$_POST["auctionId"]}'") ){
		if( $_POST["userId"] == $auction[0]["winnerId"] ){
			$data = array("rateOwner"=>$_POST["rate"], "winnerRated"=>1);
			updateDB("auctions",$data,"`id` = '{$auction[0]["id"]}'");
		}elseif( $_POST["userId"] == $auction[0]["customerId"] ){
			$data = array("rateWinner"=>$_POST["rate"], "ownerRated"=>1);
			updateDB("auctions",$data,"`id` = '{$auction[0]["id"]}'");
		}else{
			$msg = array("msg" => "this user id is wrong");
			echo outputError($msg);die();
		}
		$response = array("msg"=>"rate has been submitted.");
		echo outputData($response);die();
	}else{
		$msg = array("msg" => "No auction with this id");
		echo outputError($msg);die();
	}
	
}else if( $_GET["type"] == "get" ){
    
	if( $auction = selectDB("auctions","`id` = '{$_POST["auctionId"]}'") ){
		$owner = selectDB("customers","`id` = '{$auction[0]["customerId"]}'");
		if( $images = selectDB("auction_images","`auctionId` = '{$auction[0]["id"]}' AND `status` = '0' ORDER BY `id` ASC ") ) {
			$image = $images[0]["imageurl"];
		}else{
			$image = "";
		}
		$bidder = selectDB("customers","`id` = '{$auction[0]["winnerId"]}'");
		$ownerRating = selectDataDB("AVG(rateOwner) as oRate","auctions","`customerId` = '{$auction[0]["customerId"]}' AND `rateOwner` != '0'");
		$bidderRating = selectDataDB("AVG(rateWinner) as wRate","auctions","`winnerId` = '{$auction[0]["winnerId"]}' AND `rateWinner` != '0'");
		if( empty($ownerRating[0]["oRate"]) ){
			$ownerRating[0]["oRate"] = "0";
		}
		if( empty($bidderRating[0]["wRate"]) ){
			$bidderRating[0]["wRate"] = "0";
		}
		$data = array(
			"id" => $auction[0]["id"],
			"enTitle" => $auction[0]["enTitle"],
			"arTitle" => $auction[0]["arTitle"],
			"reach" => $auction[0]["reach"],
			"enDetails" => $auction[0]["enDetails"],
			"arDetails" => $auction[0]["arDetails"],
			"startDate" => $auction[0]["date"],
			"endDate" => $auction[0]["endDate"],
			"winnerRated" => $auction[0]["winnerRated"],
			"ownerRated" => $auction[0]["ownerRated"],
			"image" => $image,
			"owner" => array(
						"id" => $owner[0]["id"],
						"email" => $owner[0]["email"],
						"mobile" => $owner[0]["mobile"],
						"name" => $owner[0]["name"],
						"logo" => $owner[0]["logo"],
						"oRate" => substr($ownerRating[0]["oRate"],0,4),
						),
			"winner" => array(
						"id" => $bidder[0]["id"],
						"email" => $bidder[0]["email"],
						"mobile" => $bidder[0]["mobile"],
						"name" => $bidder[0]["name"],
						"logo" => $bidder[0]["logo"],
						"oRate" => substr($bidderRating[0]["wRate"],0,4),
						),
		);
		echo outputData($data);die();
	}else{
		$msg = array("msg" => "No auction with this id or bidder is there");
		echo outputError($msg);die();
	}
}else{
	$msg = array("msg" => "Please select a correct Type.");
	echo outputError($msg);die();
}

?>