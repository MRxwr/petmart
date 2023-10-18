<?php
if ( $items = selectDB('items',"`status` LIKE '0' AND `brandId` LIKE '{$_GET["id"]}' AND `type` != '2'") ){
	for( $i = 0 ; $i < sizeof($items) ; $i++ ){
		$response["items"][$i]["id"] = $items[$i]["id"];
		$response["items"][$i]["arTitle"] = $items[$i]["arTitle"];
		$response["items"][$i]["enTitle"] = $items[$i]["enTitle"];
		
		if ( $brands =  selectDB('brands',"`id` LIKE '".$items[$i]["brandId"]."' AND `status` LIKE '0'") ){
			for( $z = 0 ; $z < 1 ; $z++ ){
				for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
					unset($brands[$y][$unsetData[$y]]);
					$response["items"][$i]["brandTitleEn"] = $brands[$z]["enTitle"];
					$response["items"][$i]["brandTitleAr"] = $brands[$z]["arTitle"];
				}
			}
		}else{
			$response["items"][$i]["brandTitleEn"] = "";
			$response["items"][$i]["brandTitleAr"] = "";
		}
		
		if( $items[$i]["price"] == "0" ){
			if ( $item_variants = selectDB('item_variants',"`itemId` LIKE '".$items[$i]["id"]."' AND `status` LIKE '0' ORDER BY `price` ASC LIMIT 1") ){
				for( $iv = 0 ; $iv < sizeof($item_variants) ; $iv++ ){
					for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
						unset($item_variants[$iv][$unsetData[$y]]);
					}
					$price = $item_variants[0]["price"];
					if ($items[$i]["discountType"] == 0 ){
						$finalPrice = $price * ((100-$items[$i]["discount"])/100);
					}else{
						$finalPrice = $price - $items[$i]["discount"];
					}
					$response["variants"][$i] = $item_variants[$i];
					$response["variants"][$i]["finalPrice"] = (string)$finalPrice;
				}
				$response["items"][$i]["price"] = $item_variants[0]["price"];
				$response["items"][$i]["finalPrice"] = (string)$finalPrice;
			}else{
				$response["items"][$i]["price"] = "0";
				$response["items"][$i]["finalPrice"] = "0";
				$response["variants"] = array();
			}
		}else{
			$price = $items[$i]["price"];
			if ($items[$i]["discountType"] == 0 ){
				$finalPrice = $price * ((100-$items[$i]["discount"])/100);
			}else{
				$finalPrice = $price - $items[$i]["discount"];
			}
			$response["items"][$i]["price"] = $items[$i]["price"];
			$response["items"][$i]["finalPrice"] = (string)$finalPrice;
		}
		unset($response["variants"]);
		$finalPrice = 0;
		
		if ( $images =  selectDB('images',"`itemId` LIKE '".$items[$i]["id"]."' AND `status` LIKE '0'") ){
			for( $z = 0 ; $z < 1 ; $z++ ){
				for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
					unset($images[$y][$unsetData[$y]]);
					$response["items"][$i]["images"] = $images[$z]["imageurl"];
				}
			}
		}else{
			$response["items"][$i]["images"] = "";
		}
	}
	echo outputData($response);
}else{
	$msg = array("msg"=>"No items avaible!");
	echo outputError($msg);
}
?>