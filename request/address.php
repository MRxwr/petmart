<?php
//get address
if ( isset($_GET["type"]) ){
	if ( $_GET["type"] == "list" ){
		if ( isset($_GET["customerId"]) AND !empty($_GET["customerId"]) ){
			if( $address = selectDB('addresses',"`customerId` LIKE '".$_GET["customerId"]."' AND `status` LIKE '0'") ){
				for( $i = 0 ; $i < sizeof($address) ; $i++ ){
					for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
						unset($address[$i][$unsetData[$y]]);
					}
				}
				$response["address"] = $address;
				echo outputData($response);
			}else{
				$response["msg"] = "Wrong cusomter Id";
				echo outputError($response);die();
			}
		}else{
			$response["msg"] = "Please enter customer Id";
			echo outputError($response);die();
		}
	}elseif( $_GET["type"] == "add" ){
		if ( isset($_GET["customerId"]) AND !empty($_GET["customerId"]) ){
			$data = $_GET;
			unset($data["action"]);
			unset($data["type"]);
			if( $query = insertDB('addresses',$data ) ){
				if ( $address = selectDB('addresses'," `id` LIKE (SELECT LAST_INSERT_ID()) ") ){
					for( $i = 0 ; $i < sizeof($address) ; $i++ ){
						$response["address"]["id"] = $address[0]["id"];
						$response["address"]["firstName"] = $address[0]["firstName"];
						$response["address"]["lastName"] = $address[0]["lastName"];
						$response["address"]["mobile"] = $address[0]["mobile"];
						$response["address"]["email"] = $address[0]["email"];
						$response["address"]["country"] = $address[0]["country"];
						$response["address"]["goveronate"] = $address[0]["goveronate"];
						$response["address"]["area"] = $address[0]["area"];
						$response["address"]["addressLine1"] = $address[0]["address1"];
						$response["address"]["addressLine2"] = $address[0]["address2"];
					}
					echo outputData($response);
				}else{
					$response["msg"] = "Address has not been added. please try again";
					echo outputError($response);die();
				}
			}else{
				$response["msg"] = "Wrong cusomter Id";
				echo outputError($response);die();
			}
		}else{
			$response["msg"] = "Please enter customer Id";
			echo outputError($response);die();
		}
	}elseif( $_GET["type"] == "edit" ){
		if ( isset($_GET["addressId"]) AND !empty($_GET["addressId"]) ){
			$data = $_GET;
			unset($data["action"]);
			unset($data["type"]);
			unset($data["addressId"]);
			if( $query = updateDB('addresses',$data,"`id` LIKE '".$_GET["addressId"]."'" ) ){
				if ( $address = selectDB('addresses'," `id` LIKE '".$_GET["addressId"]."' ") ){
					for( $i = 0 ; $i < sizeof($address) ; $i++ ){
						$response["address"]["id"] = $address[0]["id"];
						$response["address"]["firstName"] = $address[0]["firstName"];
						$response["address"]["lastName"] = $address[0]["lastName"];
						$response["address"]["mobile"] = $address[0]["mobile"];
						$response["address"]["email"] = $address[0]["email"];
						$response["address"]["country"] = $address[0]["country"];
						$response["address"]["goveronate"] = $address[0]["goveronate"];
						$response["address"]["area"] = $address[0]["area"];
						$response["address"]["addressLine1"] = $address[0]["address1"];
						$response["address"]["addressLine2"] = $address[0]["address2"];
					}
					echo outputData($response);
				}else{
					$response["msg"] = "Address has not been updated. please try again";
					echo outputError($response);die();
				}
			}else{
				$response["msg"] = "Wrong address Id";
				echo outputError($response);die();
			}
		}else{
			$response["msg"] = "Please enter address Id";
			echo outputError($response);die();
		}
	}else{
		$response["msg"] = "Wrong type, 'list' or 'add' or 'edit'";
		echo outputError($response);die();
	}
}else{
	$response["msg"] = "Please enter type of operation.";
	echo outputError($response);die();
}
?>