<?php
if( isset($_GET["type"]) && !empty($_GET["type"]) ){
	if( $_GET["type"] == "list" ){
		if( isset($_GET["customerId"]) && !empty($_GET["customerId"]) ){
			if ( $order = selectDB('orders',"`customerId` LIKE '".$_GET["customerId"]."' AND `status` != '0'  GROUP BY `orderId` ORDER BY `orderId` DESC") ){
				for ( $i = 0 ; $i < sizeof($order) ; $i++ ){
					if ( $order[$i]["status"] == 1 ){
						$statusText = "Paid";
						$colorCode = "446fd5";
					}elseif( $order[$i]["status"] == 0 ){
						$statusText = "Un-Paid";
						$colorCode = "c51f30";
					}elseif( $order[$i]["status"] == 2 ){
						$statusText = "Preparing";
						$colorCode = "b1b1b1";
					}elseif( $order[$i]["status"] == 3 ){
						$statusText = "Out for delivery";
						$colorCode = "dfd760";
					}elseif( $order[$i]["status"] == 4 ){
						$statusText = "Delivered";
						$colorCode = "45a158";
					}elseif( $order[$i]["status"] == 5 ){
						$statusText = "Canceled";
						$colorCode = "c51f30";
					}elseif( $order[$i]["status"] == 6 ){
						$statusText = "Refunded";
						$colorCode = "eb8919";
					}elseif( $order[$i]["status"] == 7 ){
						$statusText = "Failed";
						$colorCode = "c51f30";
					}else{
						$statusText = "";
						$colorCode = "c51f30";
					}
					if ( isset($_GET["lang"]) && !empty($_GET["lang"]) && $_GET["lang"] == "ar" ){
						if ( $order[$i]["status"] == 1 ){
							$statusText = "مدفوع";
							$colorCode = "446fd5";
						}elseif( $order[$i]["status"] == 0 ){
							$statusText = "غير مدفوع";
							$colorCode = "c51f30";
						}elseif( $order[$i]["status"] == 2 ){
							$statusText = "جاري التخضير";
							$colorCode = "b1b1b1";
						}elseif( $order[$i]["status"] == 3 ){
							$statusText = "جاري التوصيل";
							$colorCode = "dfd760";
						}elseif( $order[$i]["status"] == 4 ){
							$statusText = "تم التوصيل";
							$colorCode = "45a158";
						}elseif( $order[$i]["status"] == 5 ){
							$statusText = "ملغي";
							$colorCode = "c51f30";
						}elseif( $order[$i]["status"] == 6 ){
							$statusText = "مسترجع";
							$colorCode = "eb8919";
						}elseif( $order[$i]["status"] == 7 ){
							$statusText = "فاشله";
							$colorCode = "c51f30";
						}else{
							$statusText = "";
							$colorCode = "c51f30";
						}
					}
					$response["orders"][$i]["id"] = $order[$i]["orderId"];
					$response["orders"][$i]["status"] = $statusText;
					$response["orders"][$i]["colorCode"] = $colorCode;
					$response["orders"][$i]["statusId"] = $order[$i]["status"];
				}
			}else{
				$response[$i]["order"] = array();
			}
			echo outputData($response);
		}else{
			$response["msg"] = "Please enter customer Id";
			echo outputError($response);die();
		}
	}elseif( $_GET["type"] == "submit" ){
		$paymentData = array();
		$data = $_POST;
		//unset($data["submit"]);
		$checkArray = ['customerId','addressId','voucherId','paymentMethod'];
		$keys = array_keys($data);
		for ( $i = 0 ; $i < sizeof($checkArray) ; $i++ ){
			if( !in_array($checkArray[$i],$keys) ){
				$response["msg"] = "Please enter order data correctly";
				echo outputError($response);die();
			}
		}
		
		if ( $vouchers = selectDB('vouchers',"`id` LIKE '".$data["voucherId"]."'") ) {
			$data["voucherDiscount"] = $vouchers[0]["discount"];
			$voucher = $vouchers[0]["discount"];
		}else{
			$data["voucherDiscount"] = 0;
			$voucher = 0;
		}
		
		$cart = selectDB('cart',"`customerId` LIKE '".$data["customerId"]."'");
		for($i=0 ; $i < sizeof($cart) ; $i++){
			$data["items"][$i]["quantity"] = $cart[$i]["quantity"];
			$data["items"][$i]["itemId"] = $cart[$i]["itemId"];
			$data["items"][$i]["preferred"] = $cart[$i]["preferred"];
			$data["items"][$i]["vendorId"] = $cart[$i]["vendorId"];
			$data["items"][$i]["variantId"] = $cart[$i]["variantId"];
		}

		echo outputData($data["items"]);die();
		
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
			$data["price"][$i] = $price[$i];
			$quantity[$i] = $data["items"][$i]["quantity"];
			$id[$i] = $data["items"][$i]["id"];
			$preferred[$i] = $data["items"][$i]["preferred"];
			$vendorId[$i] = $data["items"][$i]["vendorId"];
			$variantId[$i] = $data["items"][$i]["variantId"];
			$discount[$i] = $items[0]["discount"];
		}
		
		$address = selectDB('addresses',"`id` LIKE '".$data["addressId"]."'");
		$vendorDetails = selectDB('vendors',"`id` LIKE '".$_POST["vendorId"]."'");
		$supplierCode = $vendorDetails[0]["supplierCode"];
		$mobile = explode("-",$address[0]["mobile"]);
		$data["countryCode"] = $mobile[0];
		$data["mobile"] = $mobile[1];
		$address = selectDB('customers',"`id` LIKE '".$data["customerId"]."'");
		$email = $address[0]["email"];
		$name = $address[0]["name"];
		
		$settings = selectDB('settings',"");
		$data["delivery"] = $settings[0]["delivery"];
		$data["service"] = $settings[0]["services"];
		$data["price"] = array_sum($price)+$data["delivery"];

		if ( $data["paymentMethod"] == 3 ){
			$RealPaymentMethod = 3;
			$data["paymentMethod"] == '1';
		}
		
		$paymentData = [
			'endpoint' => 'PaymentRequestExicute',
			'apikey' => 'CKW-1635463045-3105',
			'PaymentMethodId' => $data["paymentMethod"],
			'CustomerName' => $name,
			'DisplayCurrencyIso' => 'KWD',
			'MobileCountryCode' => '+'.$data["countryCode"],
			'CustomerMobile' => (string)substr($data["mobile"],0,11),
			'CustomerEmail' => $email,
			'InvoiceValue' => $data["price"],
			'CallBackUrl' => 'https://createkwservers.com/boothat/request/index.php?page=success',
			'ErrorUrl' => 'https://createkwservers.com/boothat/request/index.php?page=failure', 
			'Language' => 'en',
			'SourceInfo' => '',
			'Suppliers[0][SupplierCode]' => "{$supplierCode}",
			'Suppliers[0][ProposedShare]' => 'null',
			'Suppliers[0][InvoiceShare]' => $data["price"]
			];
			/*
		for ( $i = 0 ; $i < sizeof($id) ; $i++ ){
			$paymentData["InvoiceItems"][$i]["ItemName"] = $id[$i];
			$paymentData["InvoiceItems"][$i]["Quantity"] = $quantity[$i];
			$paymentData["InvoiceItems"][$i]["UnitPrice"] = $price[$i];
		}
		*/
		$invoiceDetails = payment($paymentData);
		$data["orderId"] = $invoiceDetails["id"];
		$url = $invoiceDetails["url"];
		
		if ( isset($RealPaymentMethod) ){
			$data["paymentMethod"] == '3';
			$url = 'https://createkwservers.com/boothat/request/index.php?page=success?orderId='.$data["orderId"];
		}
		unset($data["items"]);
		//unset($data["action"]);
		//unset($data["type"]);
		unset($data["countryCode"]);
		//print_r($data = json_encode($data));
		
		$cart = selectDB('cart',"`customerId` LIKE '".$data["customerId"]."'");
		for($i=0 ; $i < sizeof($cart) ; $i++){
			$items = selectDB('items',"`id` LIKE '".$cart[$i]["itemId"]."'");
			if( $items[0]["is_variant"] == 0 ){
				$price = $items[0]["price"];
			}else{
				$variant = selectDB('cart',"`id` LIKE '".$cart[$i]["variantId"]."'");
				$price = $variant[0]["price"];
			}
			$data["quantity"] = $cart[$i]["quantity"];
			$data["itemId"] = $cart[$i]["itemId"];
			$data["itemDiscount"] = $items[0]["itemDiscount"];
			$data["itemPrice"] = $price;
			$data["preferred"] = $cart[$i]["preferred"];
			$data["vendorId"] = $cart[$i]["vendorId"];
			$data["variantId"] = $cart[$i]["variantId"];
			insertDB('orders',$data);
		}
		/*
		for($i=0 ; $i < sizeof($id) ; $i++){
			$data["quantity"] = $quantity[$i];
			$data["itemId"] = $id[$i];
			$data["itemDiscount"] = $discount[$i];
			$data["itemPrice"] = $price[$i];
			$data["preferred"] = $preferred[$i];
			$data["vendorId"] = $vendorId[$i];
			$data["variantId"] = $variantId[$i];
			insertDB('orders',$data);
		}
		*/
		echo outputData(array('orderId' => $data["orderId"] ,'url'=>$url));
		//submitting order to database
		
	}elseif( $_GET["type"] == "details" ){
		if( !isset($_GET["orderId"]) || empty($_GET["orderId"]) ){
			$error = array("msg"=>"Please enter a correct Order Id");
			echo outputError($error);die();
		}
		
		if ( $orders = selectDB('orders'," `orderId` LIKE '".$_GET["orderId"]."'") ){
			if ( $orders[0]["status"] == "0" ){
				updateDB('orders',array('status'=>"1")," `orderId` LIKE '".$_GET["orderId"]."'");
				for( $i = 0 ; $i < sizeof($orders) ; $i++ ){
					$data = array(
						"id" => $orders[$i]["itemId"],
						"quantity" => $orders[$i]["quantity"]
						);
					updateItemQuantity($data);
				}
				$customerId = $orders[0]["customerId"];
				$price = $orders[0]["price"];
				$customer = selectDB('customers'," `id` LIKE '".$customerId."'");
				$wallet = $customer[0]["wallet"];
				$newWallet = $wallet - $price;
				updateDB('customers',array('wallet'=>$newWallet)," `id` LIKE '".$customerId."'");
				outputData(array("orderId"=>$_GET["orderId"],"status"=>"success"));
			}else{
				$error = array("msg" => "order with this Id is already regitered in the system.");
				outputError($orders);
			}
		}
	
		if($order = selectDB('orders',"`orderId` LIKE '".$_GET["orderId"]."'")){
			if ( $order[0]["paymentMethod"] == 1 ){
				$paymentText = "K-net";
			}elseif( $order[0]["paymentMethod"] == 2 ){
				$paymentText = "Visa/Master";
			}elseif( $order[0]["paymentMethod"] == 3 ){
				$paymentText = "Cash";
			}else{
				$paymentText = "";
			}
			
			if ( $order[0]["status"] == 1 ){
				$statusText = "Paid";
				$colorCode = "446fd5";
			}elseif( $order[0]["status"] == 0 ){
				$statusText = "Un-Paid";
				$colorCode = "c51f30";
			}elseif( $order[0]["status"] == 2 ){
				$statusText = "Preparing";
				$colorCode = "b1b1b1";
			}elseif( $order[0]["status"] == 3 ){
				$statusText = "Out for delivery";
				$colorCode = "dfd760";
			}elseif( $order[0]["status"] == 4 ){
				$statusText = "Delivered";
				$colorCode = "45a158";
			}elseif( $order[0]["status"] == 5 ){
				$statusText = "Canceled";
				$colorCode = "c51f30";
			}elseif( $order[0]["status"] == 6 ){
				$statusText = "Refunded";
				$colorCode = "eb8919";
			}elseif( $order[0]["status"] == 7 ){
				$statusText = "Failed";
				$colorCode = "c51f30";
			}else{
				$statusText = "";
				$colorCode = "c51f30";
			}
			if ( isset($_GET["lang"]) && !empty($_GET["lang"]) && $_GET["lang"] == "ar" ){
				if ( $order[0]["status"] == 1 ){
					$statusText = "مدفوع";
					$colorCode = "446fd5";
				}elseif( $order[0]["status"] == 0 ){
					$statusText = "غير مدفوع";
					$colorCode = "c51f30";
				}elseif( $order[0]["status"] == 2 ){
					$statusText = "جاري التخضير";
					$colorCode = "b1b1b1";
				}elseif( $order[0]["status"] == 3 ){
					$statusText = "جاري التوصيل";
					$colorCode = "dfd760";
				}elseif( $order[0]["status"] == 4 ){
					$statusText = "تم التوصيل";
					$colorCode = "45a158";
				}elseif( $order[0]["status"] == 5 ){
					$statusText = "ملغي";
					$colorCode = "c51f30";
				}elseif( $order[0]["status"] == 6 ){
					$statusText = "مسترجع";
					$colorCode = "eb8919";
				}elseif( $order[0]["status"] == 7 ){
					$statusText = "فاشله";
					$colorCode = "c51f30";
				}else{
					$statusText = "";
					$colorCode = "c51f30";
				}
			}
			
			$response["orderId"] = $order[0]["orderId"];
			$response["date"] = $order[0]["date"];
			$response["payment"] = $paymentText;
			$response["delivery"] = $order[0]["delivery"];
			//$response["service"] = $order[0]["service"];
			$response["price"] = $order[0]["price"];
			$response["status"] = $statusText;
			$response["note"] = $order[0]["orderNote"];
			$response["colorCode"] = $colorCode;
			$response["statusId"] = $order[0]["status"];
			
			$customer = selectDB('customers',"`id` LIKE '".$order[0]["customerId"]."'");
			$response["customer"]["name"] = $customer[0]["name"];
			
			$address = selectDB('addresses',"`id` LIKE '".$order[0]["addressId"]."'");
			unset($address[0]["id"]);
			unset($address[0]["customerId"]);
			unset($address[0]["date"]);
			unset($address[0]["status"]);
			//unset($address[0]["name"]);
			$response["address"] = $address[0];
			
			if ( $voucher = selectDB('vouchers',"`id` LIKE '".$order[0]["voucherId"]."'") ){
				$response["voucher"]["code"] = $voucher[0]["code"];
				$response["voucher"]["discount"] = $order[0]["voucherDiscount"];
			}else{
				$response["voucher"]["code"] = "";
				$response["voucher"]["discount"] = "";
			}
			
	/*
			if ( $voucher = selectDB('vouchers',"`id` LIKE '".$order[0]["voucherId"]."'") ){
				$response["voucher"]["code"] = $voucher[0]["code"];
				$response["voucher"]["discount"] = $order[0]["voucherDiscount"];
			}else{
				$response["voucher"] = array();
			}
	*/	
			for( $i=0 ; $i < sizeof($order) ; $i++){
				$items = selectDB('items',"`id` LIKE '".$order[$i]["itemId"]."'");
				$response["items"][$i]["is_variant"] = $items[0]["is_variant"];
				$vendor = selectDB('vendors',"`id` LIKE '".$order[$i]["vendorId"]."'");
				$response["items"][$i]["vendor"]["enTitle"] = $vendor[0]["enShop"];
				$response["items"][$i]["vendor"]["arTitle"] = $vendor[0]["arShop"];
				if ( $items[0]["is_variant"] == 1 ){
					$variant = selectDB('item_variants',"`id` LIKE '".$order[$i]["variantId"]."'");
					$response["items"][$i]["variant"]["enTitle"] = $variant[0]["enTitle"];
					$response["items"][$i]["variant"]["arTitle"] = $variant[0]["arTitle"];
				}else{
					$response["items"][$i]["variant"]["enTitle"] = "";
					$response["items"][$i]["variant"]["arTitle"] = "";
				}
				$response["items"][$i]["arTitle"] = $items[0]["arTitle"];
				$response["items"][$i]["enTitle"] = $items[0]["enTitle"];
				$response["items"][$i]["quantity"] = $order[$i]["quantity"];
				$response["items"][$i]["discount"] = $order[$i]["itemDiscount"];
				$response["items"][$i]["price"] = $order[$i]["itemPrice"];
				$response["items"][$i]["note"] = $order[$i]["itemNote"];
				$response["items"][$i]["preferred"] = $order[$i]["preferred"];
				if ( $images = selectDB('images',"`itemId` LIKE '".$order[$i]["itemId"]."' AND `status` = '0'")){
					$response["items"][$i]["logo"] = $images[0]["imageurl"];
				}else{
					$response["items"][$i]["logo"] = "";
				}
			}
			echo outputData($response);
		}else{
			$response["msg"] = "Please enter order Id";
			echo outputError($response);die();
		}
	}
}else{
	$response["msg"] = "Please select type of order 'list','submit','details'";
	echo outputError($response);die();
}

?>