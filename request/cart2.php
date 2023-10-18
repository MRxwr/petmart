<?php
if( isset($_POST["items"]) ){
	$data = $_POST;
	if ( $vouchers = selectDB('vouchers',"`id` LIKE '".$data["voucherId"]."'") ) {
		$data["voucherDiscount"] = $vouchers[0]["discount"];
		$voucher = $vouchers[0]["discount"];
	}else{
		$data["voucherDiscount"] = 0;
		$voucher = 0;
	}
	
	for( $i=0 ; $i < sizeof($data["items"]) ; $i++ ){
		$items = selectDB('items',"`id` LIKE '".$data["items"][$i]["id"]."'");
		if ( $items[0]["discount"] == 0 ){
			if ( $items[0]["price"] == 0 ){
				$item_variants = selectDB('item_variants',"`id` LIKE '".$data["items"][$i]["variantId"]."'");
				$price[$i] = ($item_variants[0]["price"] * ( (100 - $voucher) / 100 ))*$data["items"][$i]["quantity"];
			}else{
				$price[$i] = ($items[0]["price"] * ( (100 - $voucher) / 100 ))*$data["items"][$i]["quantity"];
			}
		}else{
			if ( $items[0]["price"] == 0 ){
				$item_variants = selectDB('item_variants',"`id` LIKE '".$data["items"][$i]["variantId"]."'");
				if ( $items[0]["discountType"] == 0 ){
					$price[$i] = $item_variants[0]["price"] * ( (100 - $items[0]["discount"]) / 100 )*$data["items"][$i]["quantity"];
				}else{
					$price[$i] = ($item_variants[0]["price"] - $items[0]["discount"])*$data["items"][$i]["quantity"];
				}
			}else{
				if ( $items[0]["discountType"] == 0 ){
					$price[$i] = $items[0]["price"] * ( (100 - $items[0]["discount"]) / 100 )*$data["items"][$i]["quantity"];
				}else{
					$price[$i] = ($items[0]["price"] - $items[0]["discount"])*$data["items"][$i]["quantity"];
				}
			}
		}
		$response["items"][$i] = $items[0];
		$response["items"][$i]["price"] = (string)$price[$i];
		$response["items"][$i]["quantity"] = (string)$data["items"][$i]["quantity"];
		if( $item_variants = selectDB('item_variants',"`id` LIKE '".$data["items"][$i]["variantId"]."'") ){
			$response["items"][$i]["variants"] = array(
				"enTitle" => $item_variants[0]["enTitle"],
				"arTitle" => $item_variants[0]["arTitle"] 
			);
		}else{
			$response["items"][$i]["variants"] = array();
		}
		
		if ( $images = selectDB('images',"`itemId` LIKE '".$items[0]["id"]."' AND `status` = '0'")){
				$response["items"][$i]["logo"] = $images[0]["imageurl"];
		}else{
			$response["items"][$i]["logo"] = "";
		}
		
		if( $vendor = selectDB('vendors',"`id` LIKE '".$data["items"][$i]["vendorId"]."'") ){
			$response["items"][$i]["vendor"] = array(
				"enTitle" => $vendor[0]["enShop"],
				"arTitle" => $vendor[0]["arShop"]
			);
		}else{
			$response["items"][$i]["vendor"] = array();
		}
	}
	if ( $voucher = selectDB('vouchers',"`id` LIKE '".$data["voucherId"]."'") ){
		$response["voucher"]["code"] = $voucher[0]["code"];
		if($voucher[0]["discountType"] == 0 ){
			$response["voucher"]["discount"] = $voucher[0]["discount"] . "%";
		}else{
			$response["voucher"]["discount"] = $voucher[0]["discount"] . "KD";
		}
	}else{
		$response["voucher"]["code"] = "";
		$response["voucher"]["discount"] = "";
	}
	
	$data["price"] = array_sum($price);
	$response["totalPrice"] = (string)$data["price"];
	echo outputData($response);
	//submitting order to database
	
}
?>