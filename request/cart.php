<?php 
if ( isset($_GET["type"]) && !empty($_GET["type"]) ){
	if( $_GET["type"] == "deleteItem" ){
		$data = $_POST;
		$cart = selectDB("cart","`id` = '{$data["deleteId"]}'");
		$olderVendor = selectDB("cart","`customerId` = '{$cart[0]["customerId"]}'");
		if( deleteDB("cart","`itemId` = '{$cart[0]["itemId"]}' AND `customerId` = '{$cart[0]["customerId"]}'") ){
			$response["msg"] = "Item has been removed successfully.";
			$response["totalItems"] = sizeof($olderVendor)-1;
			echo outputData($response);die();
		}else{
			$response["msg"] = "Something wrong happned, Please try again.";
			echo outputError($response);die();
		}
	}elseif( $_GET["type"] == "clearCart" ){
		$data = $_POST;
		$cart = selectDB("cart","`customerId` = '{$data["customerId"]}'");
		if( deleteDB("cart","`customerId` = '{$data["customerId"]}'") ){
			$response["msg"] = "Cart has been cleared successfully.";
			$response["totalItems"] = 0;
			echo outputData($response);die();
		}else{
			$response["msg"] = "Something wrong happned, Please try again.";
			echo outputError($response);die();
		}
	}elseif( $_GET["type"] == "addToCart" ){
		$data = $_POST;
		unset($data["deleteId"]);
		$vendor = selectDB("vendors","`id` = '{$data["vendorId"]}'");
		$data["is_boothat"] = $vendor[0]["is_boothat"];
		$oldVendor = selectDB("cart","`customerId` = '{$data["customerId"]}'");
		
		//get quantity
		if( $item = selectDataDB("`quantity`, `is_variant`","items","`id` = '{$data["itemId"]}'") ){
			if ( $variant[0]["is_variant"] == 0 ){
				$quantity = $item[0]["quantity"];
			}else{
				if($variant = selectDataDB("`quantity`","item_variants","`id` = '{$data["variantId"]}'") ){
					$quantity = $variant[0]["quantity"];
				}else{
					$response["msg"] = "Enter `variant id` correctly";
					echo outputError($response);die();
				}
			}
		}else{
			$response["msg"] = "Enter `item id` correctly";
			echo outputError($response);die();
		}
		
		// check quantity
		if ( $checkQuantity = selectDataDB("SUM(quantity) as quan","cart","`itemId` = '{$data["itemId"]}'") ){
			if ( ($checkQuantity[0]["quan"]+$data["quantity"]) >= $quantity ){
				$response["msg"] = "Please choose a number below " . ((int)$quantity - (int)$checkQuantity[0]["quan"]);
				$response["totalItems"] = sizeof($oldVendor);
				echo outputError($response);die();
			}
		}
		
		// add to cart
		if ( isset($oldVendor) && $oldVendor == 0 ){
			if(insertDB("cart",$data)){
				$response["msg"] = "Item has been added successfully";
				$response["totalItems"] = sizeof($oldVendor);
				echo outputData($response);die();
			}else{
				$response["msg"] = "Something wrong happned, Please try again.";
				echo outputError($response);die();
			}
		}else{
			if ( $data["is_boothat"] == 0 ){
				if ( $data["vendorId"] == $oldVendor[0]["vendorId"] ){
					if(insertDB("cart",$data)){
						$response["msg"] = "Item has been added successfully";
						$response["totalItems"] = sizeof($oldVendor);
						echo outputData($response);die();
					}else{
						$response["msg"] = "Something went Wrong";
						echo outputError($response);die();
					}
				}else{
					$response["msg"] = "You need to clear your cart first";
					$response["totalItems"] = sizeof($oldVendor);
					echo outputError($response);die();
				}
			}else{
				if ( $data["is_boothat"] == $oldVendor[0]["is_boothat"] ){
					if(insertDB("cart",$data)){
						$response["msg"] = "Item has been added successfully";
						$response["totalItems"] = sizeof($oldVendor);
						echo outputData($response);die();
					}else{
						$response["msg"] = "Something went Wrong";
						echo outputError($response);die();
					}
				}else{
					$response["msg"] = "You need to clear your cart first";
					echo outputError($response);die();
				}
			}
		}
	}elseif( $_GET["type"] == "getCart" ){
		$data = $_POST;
		if( $cart = selectDataDB("*, sum(quantity) as quan","cart","`customerId` = '{$data["customerId"]}' GROUP BY `ItemId`") ){
			for($i=0; $i<sizeof($cart); $i++){
				$item = selectDB("items","`id` = '{$cart[$i]["itemId"]}'");
				if( $item[0]["is_variant"] == 0 ){
					$price = $item[0]["price"];
					$variant = "0";
				}else{
					$variant = selectDB("item_variants","`id` = '{$cart[$i]["variantId"]}'");
					$price = $variant[0]["price"];
					$variant = $variant[0]["enTitle"];
				}
				$vendor = selectDB("vendors","`id` = '{$cart[$i]["vendorId"]}'");
				$brand = selectDB("brands","`id` = '{$item[0]["brandId"]}'");
				$image = selectDB("images","`itemId` = '{$item[0]["id"]}' AND `status` = '0'");
				if( $item[0]["discount"] != 0 ){
					if ( $item[0]["discountType"] == 0 ){
						$price = ( (100-$item[0]["discount"])/100)*$price;
					}else{
						$price = $price - $item[0]["discount"];
					}
				}
				$response["items"][] = array(
					"id"=>$cart[$i]["id"],
					"item"=>$item[0]["enTitle"],
					"variant"=>$variant,
					"image"=>$image[0]["imageurl"],
					"brand"=>$brand[0]["enTitle"],
					"vendor"=>$vendor[0]["enShop"],
					"quantity"=>$cart[$i]["quan"],
					"price"=>(string)($price*$cart[$i]["quan"])
				);
				$totalPrice[] = $price*$cart[$i]["quan"];
				$response["totalItems"] = sizeof($cart);
			}
			$response["totalItems"] = sizeof($cart);
			$response["totalPrice"] = (string)array_sum($totalPrice);
			echo outputData($response);die();
		}else{
			$response["msg"] = "Cart is empty";
			$response["totalItems"] = 0;
			$response["totalPrice"] = "0";
			echo outputError($response);die();
		}
	}else{
		$response["msg"] = "Please enter a correct type of operation.[getCart, deleteItem, addToCart]";
		echo outputError($response);die();
	}
}else{
	$response["msg"] = "Please enter type of operation.[getCart, deleteItem, addToCart]";
	echo outputError($response);die();
}
?>