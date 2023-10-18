<?php 
if ( isset($_GET["type"]) AND !empty($_GET["type"]) ){
	if( $_GET["type"] == "submit" ){
		unset($_GET["action"]);
		unset($_GET["type"]);
		insertDB('favorites',$_GET);
		if ( $favo = selectDB('favorites',"`userId` LIKE '{$_GET["userId"]}' AND `vendorId` LIKE '{$_GET["vendorId"]}' AND `itemId` LIKE '{$_GET["itemId"]}'") ){
			$favoId = $favo[0]["id"];
		}else{
			$favoId = "0";
		}
		$msg = array(
			"favoId" => $favoId,
			"msg"=>"Added to favorite successfully."
		);
		echo outputData($msg);
	}elseif( $_GET["type"] == "list" ){
		if ( $favo = selectDB('favorites',"`userId` LIKE '{$_GET["userId"]}' AND `status` LIKE '0' AND `vendorId` != '0'") ){
			for( $f = 0 ; $f < sizeof($favo) ; $f++ ){
				if ( $vendors = selectDB("vendors"," `id` LIKE '{$favo[$f]["vendorId"]}' AND `status` = '0'") ){
					$response["vendors"][$f]["favoId"] = $favo[$f]["id"];
					$response["vendors"][$f]["id"] = $vendors[0]["id"];
					$response["vendors"][$f]["arTitle"] = $vendors[0]["arShop"];
					$response["vendors"][$f]["enTitle"] = $vendors[0]["enShop"];
					$response["vendors"][$f]["image"] = $vendors[0]["logo"];
				}
			}
		}else{
			$response["vendors"] = array();
		}
		if ( $favo = selectDB('favorites',"`userId` LIKE '{$_GET["userId"]}' AND `status` LIKE '0' AND `itemId` != '0'") ){
			for( $f = 0 ; $f < sizeof($favo) ; $f++ ){
				if ( $items = selectDB('items',"`id` LIKE '{$favo[$f]["itemId"]}' AND `type` != '2'") ){
					for( $i = 0 ; $i < sizeof($items) ; $i++ ){
						$response["items"][$f]["favoId"] = $favo[$f]["id"];
						$response["items"][$f]["id"] = $items[$i]["id"];
						$response["items"][$f]["arTitle"] = $items[$i]["arTitle"];
						$response["items"][$f]["enTitle"] = $items[$i]["enTitle"];
						
						if ( $brands =  selectDB('brands',"`id` LIKE '".$items[$i]["brandId"]."' AND `status` LIKE '0'") ){
							for( $z = 0 ; $z < 1 ; $z++ ){
								for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
									unset($brands[$y][$unsetData[$y]]);
									$response["items"][$f]["brandTitleEn"] = $brands[$z]["enTitle"];
									$response["items"][$f]["brandTitleAr"] = $brands[$z]["arTitle"];
								}
							}
						}else{
							$response["items"][$f]["brandTitleEn"] = "";
							$response["items"][$f]["brandTitleAr"] = "";
						}
						
						if( $items[$i]["price"] == "0" ){
							if( $item_variants = selectDB('item_variants',"`itemId` LIKE '".$items[$i]["id"]."' AND `status` LIKE '0' ORDER BY `price` ASC LIMIT 1") ){
								for( $iv = 0 ; $iv < sizeof($item_variants) ; $iv++ ){
									for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
										unset($item_variants[$iv][$unsetData[$y]]);
									}
									$price = $item_variants[0]["price"];
									if ($items[0]["discountType"] == 0 ){
										$finalPrice = $price * ((100-$items[$i]["discount"])/100);
									}else{
										$finalPrice = $price - $items[$i]["discount"];
									}
									$response["variants"][$f] = $item_variants[$i];
									$response["variants"][$f]["finalPrice"] = (string)$finalPrice;
								}
								$response["items"][$f]["price"] = $item_variants[0]["price"];
								$response["items"][$f]["finalPrice"] = (string)$finalPrice;
							}else{
								$response["variants"] = array();
							}
						}else{
							$price = $items[$i]["price"];
							if ($items[0]["discountType"] == 0 ){
								$finalPrice = $price * ((100-$items[$i]["discount"])/100);
							}else{
								$finalPrice = $price - $items[$i]["discount"];
							}
							$response["items"][$f]["price"] = $price;
							$response["items"][$f]["finalPrice"] = (string)$finalPrice;
						}
						unset($response["variants"]);
						$finalPrice = 0;
						
						if ( $images =  selectDB('images',"`itemId` LIKE '".$items[$i]["id"]."' AND `status` LIKE '0'") ){
							for( $z = 0 ; $z < 1 ; $z++ ){
								for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
									unset($images[$y][$unsetData[$y]]);
									$response["items"][$f]["images"] = $images[$z]["imageurl"];
								}
							}
						}else{
							$response["items"][$f]["images"] = "";
						}
					}
				}
			}
		}else{
			$response["items"] = array();
		}
		echo outputData($response);
	}elseif( $_GET["type"] == "delete" ){
		unset($_GET["action"]);
		unset($_GET["type"]);
		$where = " `id` LIKE '{$_GET["id"]}'";
		$body = array("status" => '1');
		updateDB('favorites',$body,$where);
		$msg = array("msg"=>"Removed from favorite successfully.");
		echo outputData($msg);
	}else{
		$msg = array("msg"=>"Wrong type, please set a correct type");
		echo outputError($msg);
	}
}else{
	$msg = array("msg"=>"Please set Type");
	echo outputError($msg);
}
?>