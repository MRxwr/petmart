<?php
if ( isset($_GET["code"]) && !empty($_GET["code"]) ){
	if ( $voucher = selectDataDB("`id`, `code`, `discount`, `discountType`,`is_all`",'vouchers',"`code` LIKE '".$_GET["code"]."' AND `status` LIKE '0'") ){
		if( $cart = selectDataDB("*, sum(quantity) as quan","cart","`customerId` = '{$_GET["customerId"]}' GROUP BY `ItemId`") ){

			if( $voucher[0]["is_all"] == 0 ){
				if( $cart[0]["vendorId"] != $voucher[0]["vendorId"]){
					$response["msg"] = "This voucher is not applicable for this store.";
					echo outputError($response);die();
				}else{
					$response["msg"] = "The voucher has been activated.";
					$voucherDiscount = $voucher[0]["discount"];
				}
			}else{
				if(  $cart[0]["is_boothat"] == 1 ){
					$response["msg"] = "The voucher has been activated.";
					$voucherDiscount = $voucher[0]["discount"];
				}else{
					$response["msg"] = "This voucher is not applicable for this store.";
					echo outputError($response);die();
				}
			}
			
			for($i=0; $i<sizeof($cart); $i++){
				$item = selectDB("items","`id` = '{$cart[$i]["itemId"]}'");
				if( $item[0]["is_variant"] == 0 ){
					$price = $item[0]["price"];
				}else{
					$variant = selectDB("item_variants","`id` = '{$cart[$i]["variantId"]}'");
					$price = $variant[0]["price"];
				}
				if( $item[0]["discount"] != 0 ){
					if ( $item[0]["discountType"] == 0 ){
						$price = ( (100-$item[0]["discount"])/100)*$price;
					}else{
						$price = $price - $item[0]["discount"];
					}
				}elseif( isset($voucherDiscount) ){
					if ( $voucher[0]["discountType"] == 0 ){
						$price = ( (100-$voucherDiscount)/100)*$price;
					}else{
						$price = $price - $voucherDiscount;
					}
				}
				$totalPrice[] = $price*$cart[$i]["quan"];
			}
			
			$response["totalPrice"] = array_sum($totalPrice);
			$response["totalPrice"] = (string)$response["totalPrice"];
		}else{
			$response["totalPrice"] = "0";
		}
		$response["voucher"] = $voucher[0];
		echo outputData($response);
	}else{
		$response["msg"] = "No voucher with this code";
		echo outputError($response);die();
	}
}else{
	$response["msg"] = "Please enter voucher code ";
	echo outputError($response);die();
}

?>