<?php
if ( isset($_GET["id"]) && !empty($_GET["id"]) ){
	if ( $vendors = selectDB('vendors',"`id` = '".$_GET["id"]."'") ){
	}else{
		goto jump;
	}

	$response["vendor"] = array(
		"id" => $vendors[0]["id"],
		"boothat" => $vendors[0]["is_boothat"],
		"arTitle" => $vendors[0]["arShop"],
		"enTitle" => $vendors[0]["enShop"],
		"logo" => $vendors[0]["logo"],
		"image" => $vendors[0]["header"]
	);
	
	if( $_GET["sort"] == 1 ){
		$ordering = "AND i.type = '1'";
	}elseif($_GET["sort"] == 2 ){
		$ordering = "AND i.type = '2'";
	}elseif($_GET["sort"] == 3 ){
		$ordering = "ORDER BY i.enTitle ASC";
		if ( $_GET["lang"] == "ar" ){
			$ordering = "ORDER BY i.arTitle ASC";
		}
	}elseif($_GET["sort"] == 4 ){
		$ordering = "ORDER BY i.enTitle DESC";
		if ( $_GET["lang"] == "ar" ){
			$ordering = "ORDER BY i.arTitle DESC";
		}
	}elseif($_GET["sort"] == 5 ){
		$ordering = "ORDER BY i.price ASC";
	}elseif($_GET["sort"] == 6 ){
		$ordering = "ORDER BY i.price DESC";
	}else{
		$ordering = "ORDER BY i.id DESC";
	}
	
	if ( $favorites = selectDB('favorites',"`userId` LIKE '{$_GET["userId"]}' AND `vendorId` = '{$_GET["id"]}' AND `status` = '0'") ){
		$response["is_fav"] = "1";
		$response["favoId"] = $favorites[0]["id"];
	}else{
		$response["is_fav"] = "0";
		$response["favoId"] = "0";
	}
	
	if ( isset($_GET["categoryId"]) && !empty($_GET["categoryId"]) ){
		$category = "AND i.categoryId = '{$_GET["categoryId"]}'";
	}else{
		$category = "";
	}
	
	$sql = "SELECT i.id as realId
			FROM `items_vendors` as iv
			JOIN `items` as i
			ON iv.itemId = i.id
			WHERE
			iv.vendorId = '{$_GET["id"]}'
			{$category} 
			AND
			i.status = '0'
			AND 
			iv.status = '0'
			{$ordering}";
	$result = $dbconnect->query($sql);
	while( $row = $result->fetch_assoc() ){
		$ids[] = $row["realId"];
	}
	
	
	if ( $result->num_rows > 0 ){
		$serviceCounter = 0;
		$digitalCounter = 0;
		$productCounter = 0;
		for( $i = 0 ; $i < sizeof($ids) ; $i++ ){
			$items = selectDB('items',"`status` = '0' AND `id` = '{$ids[$i]}'");
			$brands = selectDB('brands',"`id` = '{$items[0]["brandId"]}'");
			$image = selectDB('images',"`itemId` = '{$items[0]["id"]}' AND `status` = '0'");
			
			if($items[0]["type"] == 0 ){
				$type = "product";
				$counter = $productCounter;
				$productCounter++;
			}elseif($items[0]["type"] == 1){
				$type = "digital";
				$counter = $digitalCounter;
				$digitalCounter++;
			}else{
				$type = "service";
			}
			
			if ( $type == "service" ){
				$response["items"][$type][$serviceCounter] = array(
					"id" => $items[0]["id"],
					"arTitle" => $items[0]["arTitle"],
					"enTitle" => $items[0]["enTitle"],
					"arDetails" => $items[0]["arDetails"],
					"enDetails" => $items[0]["enDetails"],
				);
				$serviceCounter++;
			}else{
				$price = $items[0]["price"];
				
				if( $items[0]["price"] == 0 ){
					$variant = selectDB('item_variants',"`status` = '0' AND `itemId` = '{$items[0]["id"]}' ORDER BY `price` ASC");
					$price = $variant[0]["price"];
				}
				
				if ($items[0]["discountType"] == 0 ){
					$finalPrice = $price * ((100-$items[0]["discount"])/100);
				}else{
					$finalPrice = $price - $items[0]["discount"];
				}
				
				$response["items"][$type][$counter] = array(
					"id" => $items[0]["id"],
					"arTitle" => $items[0]["arTitle"],
					"enTitle" => $items[0]["enTitle"],
					"brand" => array(
						"arTitle" => $brands[0]["arTitle"],
						"enTitle" => $brands[0]["enTitle"],
						),
					"price" => $price,
					"finalPrice" => (string)$finalPrice,
					"image" => $image[0]["imageurl"],
					"discountType" => $items[0]["discountType"],
					"discount" => $items[0]["discount"]
				);
			}
			$finalPrice = 0;
			$price = 0;
		}
		if( empty($response["items"]["product"]) ){
			$response["items"]["product"] = array();
		}
		if( empty($response["items"]["digital"]) ){
			$response["items"]["digital"] = array();
		}
		if( empty($response["items"]["service"]) ){
			$response["items"]["service"] = array();
		}
	}else{
		$response["items"]["product"] = array();
		$response["items"]["digital"] = array();
		$response["items"]["service"] = array();
	}
	
	
	if ( $gallery = selectDB('gallery',"`vendorId` = '".$_GET["id"]."' AND `=` LIKE '0'") ){
		for ( $i = 0 ; $i < sizeof($gallery) ; $i++ ){
			$response["gallery"][$i] = array(
				"type" => $gallery[$i]["type"],
				"url" => $gallery[$i]["url"]
			);
		}
	}else{
		$response["gallery"] = array();
	}
	
	if ( $categories = selectDB('categories',"`vendorId` = '".$_GET["id"]."' AND `status` = '0'") ){
		for ( $i = 0 ; $i < sizeof($categories) ; $i++ ){
			$response["categories"][$i] = array(
				"id" => $categories[$i]["id"],
				"enTitle" => $categories[$i]["enTitle"],
				"arTitle" => $categories[$i]["arTitle"]
			);
		}
	}else{
		$response["categories"] = array();
	}
	
	echo outputData($response);
}else{
	jump:
	$error = array("msg"=>"No Vendor with this id");
	echo outputError($error);
}

?>