<?php
//date_default_timezone_set('Kuwait/Riyadh');
if( isset($_GET["type"]) && !empty($_GET["type"]) ){
	$sql = "SELECT NOW() + INTERVAL 3 HOUR AS nowTime";
	$result = $dbconnect->query($sql);
	$row = $result->fetch_assoc();
	$timenow = $row["nowTime"];
	//$timenow = date("Y-m-d H:i:s");
	/*
	auctions status
	0 => live
	1 => finished
	2 => stopped
	*/
	if( $_GET["type"] == "list" ){
		if( !isset($_POST["customerId"]) || empty($_POST["customerId"]) ){
			$customerId = "";
		}else{
			$customerId = "AND `customerId` != '{$_POST["customerId"]}'";
		}
		
		if( !isset($_POST["filterId"]) || empty($_POST["filterId"]) ){
			$filterId = "";
		}else{
			$filterId = "AND `categoryId` = '{$_POST["filterId"]}'";
		}
		//update on hit
		
		if($doneAuctions = selectDataDB("`id`,`customerId`,`is_notify`",'auctions'," `date` < DATE_SUB(NOW(), INTERVAL 1 DAY) AND `status` = '0' AND `is_notify` != 'yes'")){
		    //var_dump($doneAuctions);exit;
			$notificationData = array(
				"title" => "Auction Ended - إنتهى المزاد",
				"body" => "Your auction has ended, you can check the winner now. مزادك إنتهى ، تستطيع ان تعرف الفائز الآن.",
				"dbData" => $doneAuctions
			);
			    notificationToUsers($notificationData);
			    updateDB('auctions',array("status"=>'1')," `date` < DATE_SUB(NOW(), INTERVAL 24 HOUR) AND status='0'");
		
		}
		//$dbconnect->query("UPDATE `auctions` SET `endDate` = DATE_ADD(`date`,INTERVAL 1 DAY) WHERE `status` = '0'");
		 
    // 		updateDB('auctions',array("status"=>'1')," TIME_TO_SEC(TIMEDIFF($timenow,`date`))>86400 AND status='0'");
    
		
		if( $auctions = selectDB("auctions", "`status` = '0' {$customerId} {$filterId} ORDER BY `id` DESC") ){
			for( $i = 0; $i < sizeof($auctions); $i++ ){
			    
			    //if (($timenow >= $auctions[$i]["date"]) && ($timenow >= $auctions[$i]["endDate"])){
    				$data[$i] = array(
    					"id" => $auctions[$i]["id"],
    					"date" =>    $timenow,
    					"endDate" => $auctions[$i]["endDate"],
    					"enTitle" => $auctions[$i]["enTitle"],
    					"arTitle" => $auctions[$i]["arTitle"]
    				);
    				if( $images = selectDB("auction_images", "`auctionId` = '{$auctions[$i]["id"]}' AND `status` = '0' ORDER BY `id` DESC") ){
    					$data[$i]["image"] = $images[0]["imageurl"];
    					$data[$i]["images"] = sizeof($images);
    				}else{
    					$data[$i]["image"] = "";
    					$data[$i]["images"] = 0;
    				}
			     //}
			  }
			if(!empty($data)){
			    echo outputData($data);
			}else{
			    $msg = array("msg"=>"No auctions has been found");
			echo outputError($msg);
			}
			//echo outputData($data);
		}else{
			$msg = array("msg"=>"No auctions has been found");
			echo outputError($msg);
		}
	}elseif( $_GET["type"] == "my" ){
		if ( !isset($_POST["customerId"]) || empty($_POST["customerId"]) ){
			$msg = array("msg"=>"Please set customer id");
			echo outputError($msg); die();
		}
		if($doneAuctions = selectDataDB("`id`,`customerId`,`is_notify`",'auctions'," `date` < DATE_SUB(NOW(), INTERVAL 24 HOUR) AND status='0' AND is_notify!='yes'")){
		    //var_dump($doneAuctions);exit;
			$notificationData = array(
				"title" => "Auction Ended - إنتهى المزاد",
				"body" => "Your auction has ended, you can check the winner now. مزادك إنتهى ، تستطيع ان تعرف الفائز الآن.",
				"dbData" => $doneAuctions
			);
			notificationToUsers($notificationData);
			updateDB('auctions',array("status"=>'1')," `date` < DATE_SUB(NOW(), INTERVAL 24 HOUR) AND status='0'");
		}
	
		if( $auctions = selectDB("auctions", "`customerId` = '{$_POST["customerId"]}'") ){
			for( $i = 0; $i < sizeof($auctions); $i++ ){
				if( $auctions[$i]["status"] == 0 ){
					$type = "live";
				}elseif( $auctions[$i]["status"] == 1 ){
					$type = "done";
				}else{
					$type = "cancel";
				}
				if( $images = selectDB("auction_images", "`auctionId` = '{$auctions[$i]["id"]}' AND `status` = '0' ORDER BY `id` DESC") ){
					$imageURL = $images[0]["imageurl"];
					$imageSize = sizeof($images);
				}else{
					$imageURL = "";
					$imageSize = 0;
				}
				$data[$type][] = array(
					"id" => $auctions[$i]["id"],
					"date" =>    $timenow,
					"endDate" => $auctions[$i]["endDate"],
					"enTitle" => $auctions[$i]["enTitle"],
					"arTitle" => $auctions[$i]["arTitle"],
					"image" => $imageURL,
					"images" => $imageSize,
				);
				
			}
			echo outputData($data);
		}else{
			$msg = array("msg"=>"No auctions has been found");
			echo outputError($msg);
		}
	}elseif( $_GET["type"] == "details" ){
		if ( !isset($_POST["auctionId"]) || empty($_POST["auctionId"]) ){
			$msg = array("msg"=>"Please set auction id");
			echo outputError($msg); die();
		}
		if( $auctions = selectDB("auctions", "`id` = '{$_POST["auctionId"]}'") ){
			for( $i = 0; $i < sizeof($auctions); $i++ ){
				
				$data[$i] = array(
					"id" => $auctions[$i]["id"],
					"date" => $timenow,
					"endDate" => $auctions[$i]["endDate"],
					"enTitle" => $auctions[$i]["enTitle"],
					"arTitle" => $auctions[$i]["arTitle"],
					"arTitle" => $auctions[$i]["enDetails"],
					"arTitle" => $auctions[$i]["arDetails"],
					"price"   => $auctions[$i]["price"],
					"reach"   => $auctions[$i]["reach"],
					"video" => $auctions[$i]["video"],
					"status" => $auctions[$i]["status"],
					"accept" => $auctions[$i]["accept"],
				);
				
				if( $range = selectDB("auctions_bid_options", "`priceFrom` <= '{$auctions[$i]["reach"]}' AND `priceTo` >= '{$auctions[$i]["reach"]}' AND `status` = '0'") ){
						$data[$i]["bids"] = array(
							0 => $range[0]["bid1"],
							1 => $range[0]["bid2"],
							2 => $range[0]["bid3"]
						);
				}else{
					$range = selectDB("auctions_bid_options", "`status` = '0' ORDER BY `priceTo` DESC LIMIT 1");
					$data[$i]["bids"] = array(
							0 => $range[0]["bid1"],
							1 => $range[0]["bid2"],
							2 => $range[0]["bid3"]
						);
				}
				
				if( $images = selectDB("auction_images", "`auctionId` = '{$auctions[$i]["id"]}' AND `status` = '0' ORDER BY `id` DESC") ){
					for( $y = 0; $y < sizeof($images); $y++ ){
						$data[$i]["image"][$y] = $images[$y]["imageurl"];
					}
				}else{
					$data[$i]["image"] = array();
				}
				
				if( $customer = selectDB("customers", "`id` = '{$auctions[$i]["customerId"]}'") ){
					$rating = selectDataDB("AVG(rateOwner) as oRate","auctions", "`customerId` = '{$auctions[$i]["customerId"]}'");
						$data[$i]["customer"] = array(
							"name" => $customer[0]["name"],
							"mobile" => $customer[0]["mobile"],
							"email" => $customer[0]["email"],
							"logo" => $customer[0]["logo"],
							"rating" => $rating[0]["oRate"],
						);
				}else{
					$data[$i]["customer"] = array();
				}
				
				if( $bidders = selectDB("auctions_bidders", "`auctionId` = '{$auctions[$i]["id"]}' ORDER BY `id` DESC") ){
					for( $y = 0; $y < sizeof($bidders); $y++ ){
						$customer = selectDB("customers", "`id` = '{$bidders[$y]["bidderId"]}'");
						$data[$i]["bidders"][$y] = array(
							"name" => $customer[0]["name"],
							"logo" => $customer[0]["logo"],
							"bid" => $bidders[$y]["bid"],
							"date" => $bidders[$y]["date"],
						);
					}
				}else{
					$data[$i]["bidders"] = array();
				}
				
			}
			echo outputData($data);
		}else{
			$msg = array("msg"=>"No auction with this Id");
			echo outputError($msg);
		}
	}elseif( $_GET["type"] == "stop" ){
		if ( !isset($_POST["auctionId"]) || empty($_POST["auctionId"]) ){
			$msg = array("msg"=>"Please set auction id");
			echo outputError($msg); die();
		}
		if ( selectDB("auctions","`id` = '{$_POST["auctionId"]}'") ){
			updateDB("auctions",array("status"=>2),"`id` = '{$_POST["auctionId"]}'");
			$msg = array("msg"=>"Auction has been stopped successfully.");
			echo outputData($msg); die();
		}else{
			$msg = array("msg"=>"there is no auction with this id");
			echo outputError($msg); die();
		}
	}elseif( $_GET["type"] == "add" ){
		if ( !isset($_POST["endDate"]) || empty($_POST["endDate"]) ){
			$msg = array("msg"=>"Please set end date");
			echo outputError($msg); die();
		}
		if ( !isset($_POST["customerId"]) || empty($_POST["customerId"]) ){
			$msg = array("msg"=>"Please set customer Id");
			echo outputError($msg); die();
		}
		if ( !isset($_POST["title"]) || empty($_POST["title"]) ){
			$msg = array("msg"=>"Please set title");
			echo outputError($msg); die();
		}
		if ( !isset($_POST["details"]) || empty($_POST["details"]) ){
			$msg = array("msg"=>"Please set details");
			echo outputError($msg); die();
		}
		if ( !isset($_POST["price"]) || empty($_POST["price"]) ){
			$msg = array("msg"=>"Please set price");
			echo outputError($msg); die();
		}
		$_POST["enTitle"] = $_POST["title"];
		$_POST["arTitle"] = $_POST["title"];
		$_POST["enDetails"] = $_POST["details"];
		$_POST["arDetails"] = $_POST["details"];
		
		$data = array(
		    "date" => $timenow,
			"endDate" => $_POST["endDate"],
			"customerId" => $_POST["customerId"],
			"categoryId" => $_POST["categoryId"],
			"enTitle" => $_POST["enTitle"],
			"arTitle" => $_POST["arTitle"],
			"enDetails" => $_POST["enDetails"],
			"arDetails" => $_POST["arDetails"],
			"price" => $_POST["price"],
			"reach" => $_POST["price"],
			"video" => $_POST["video"],
		);
		if( insertDB("auctions",$data)){
			$auction = selectDB("auctions", "`customerId` = '{$_POST["customerId"]}' AND `status` = '0' ORDER BY `id` DESC LIMIT 1");
			$customer = selectDB("customers","`id` = '{$_POST["customerId"]}'");
			$points = $customer[0]["points"] - 1;
			if( $points < 0 ){
				$error = array("msg"=>"Please add points to continue.");
				echo outputError($error);die();
			}
			$updateData = array("points"=>$points);
			updateDB("customers",$updateData,"`id` = '{$_POST["customerId"]}'");
			$imageData["auctionId"] = $auction[0]["id"];
			for( $i = 0; $i < sizeof($_FILES['image']['tmp_name']) ; $i++ ){
				if( isset($_FILES['image']['tmp_name'][$i]) AND is_uploaded_file($_FILES['image']['tmp_name'][$i]) ){
					@$ext = end((explode(".", $_FILES['image']['name'][$i])));
					$directory = "../admin/logos/";
					$originalfile = $directory . md5(date("d-m-y").time().rand(111111,999999))."." . $ext;
					move_uploaded_file($_FILES['image']["tmp_name"][$i], $originalfile);
					$imageData["imageurl"] = str_replace("../admin/logos/",'',$originalfile);
					insertDB('auction_images',$imageData);
				}
			}
			$customers = selectDataDB("`customerId`","interest","`categoryId` = '{$auction[0]["categoryId"]}'");
			$sendNotification = array(
				"title" => "New Auction - مزاد جديد",
				"body" => "New auction may interest You. تم إضافة مزاد يهمك",
				"dbData" => $customers
			);
			@notificationToUsers($sendNotification);
			$msg = array("id"=>$auction[0]["id"],"msg"=>"Posted successfully.");
			echo outputData($msg); die();
		}else{
			$msg = array("msg"=>"something wrong happened, Please try again.");
			echo outputError($msg); die();
		}
	}elseif( $_GET["type"] == "submitBid" ){
		if ( !isset($_POST["bid"]) || empty($_POST["bid"]) ){
			$msg = array("msg"=>"Please set bid amount");
			echo outputError($msg); die();
		}
		if ( !isset($_POST["bidderId"]) || empty($_POST["bidderId"]) ){
			$msg = array("msg"=>"Please set bidder Id");
			echo outputError($msg); die();
		}
		if ( !isset($_POST["auctionId"]) || empty($_POST["auctionId"]) ){
			$msg = array("msg"=>"Please set auction Id");
			echo outputError($msg); die();
		}
		if ( $lastBid = selectDB("auctions_bidders","`auctionId` = '{$_POST["auctionId"]}' ORDER BY `bid` DESC LIMIT 1") ){
			if( $lastBid[0]["bid"] >= $_POST["bid"]){
				$msg = array("msg"=>"Please update your bid.");
				echo outputError($msg); die();
			}
		}
		$data = array(
			"auctionId" => $_POST["auctionId"],
			"bidderId" => $_POST["bidderId"],
			"bid" => $_POST["bid"],
		);
		if ( insertDB("auctions_bidders",$data) ){
			$reach = $_POST["bid"];
			updateDB('auctions',array('reach'=>$reach, "winnerId"=>$_POST["bidderId"]),"`id` = {$_POST["auctionId"]}");
			$msg = array("msg"=>"bid has been added successfully.");
			echo outputData($msg); die();
		}else{
			$msg = array("msg"=>"Please check entered data.");
			echo outputError($msg); die();
		}
	}else{
		$msg = array("msg"=>"Please set a correct Type, list, my, add, stop, edit");
		echo outputError($msg);
	}
}else{
	$msg = array("msg"=>"Please set a Type.");
	echo outputError($msg);
}
?>