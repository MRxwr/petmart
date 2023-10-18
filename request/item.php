<?php
if ( /*`status` = '0' AND */ $items = selectDB('items',"`id` = '{$_GET["id"]}'") ){
	for( $i = 0 ; $i < sizeof($items) ; $i++ ){
		if( $items[$i]["ageType"] == 0 ){
			$ageType = "Day";
			$ageTypeAr = "يوم";
		}elseif( $items[$i]["ageType"] == 1 ){
			$ageType = "Week";
			$ageTypeAr = "إسبوع";
		}elseif( $items[$i]["ageType"] == 2 ){
			$ageType = "Month";
			$ageTypeAr = "شهر";
		}else{
			$ageType = "Year";
			$ageTypeAr = "سنة";
		}
		if( $items[$i]["gender"] == 0 ){
			$gender = "Couple";
			$genderAr = "زوج";
		}elseif( $items[$i]["gender"] == 1 ){
			$gender = "Male";
			$genderAr = "ذكر";
		}elseif( $items[$i]["gender"] == 2 ){
			$gender = "Female";
			$genderAr = "أنثى";
		}else{
			$gender = "Not Applicable";
			$genderAr = "غير معروف";
		}
		$response["items"][$i]["status"] = $items[$i]["status"];
		$response["items"][$i]["id"] = $items[$i]["id"];
		$response["items"][$i]["categoryId"] = $items[$i]["categoryId"];
		$response["items"][$i]["date"] = $items[$i]["date"];
		$response["items"][$i]["arTitle"] = $items[$i]["arTitle"];
		$response["items"][$i]["enTitle"] = $items[$i]["enTitle"];
		$response["items"][$i]["arDetails"] = $items[$i]["arDetails"];
		$response["items"][$i]["enDetails"] = $items[$i]["enDetails"];
		$response["items"][$i]["video"] = $items[$i]["video"];
		$response["items"][$i]["age"] = $items[$i]["age"];
		$response["items"][$i]["price"] = number_format($items[$i]["price"],3) . " KWD";
		$category = selectDB("categories","`id` = '{$items[$i]["categoryId"]}'");
		if( $category[0]["type"] != 1 ) {
		   $response["items"][$i]["price"] = "";
		} 
		$response["items"][$i]["gender"] = $gender;
		$response["items"][$i]["genderAr"] = $genderAr;
		$response["items"][$i]["ageType"] = $ageType;
		$response["items"][$i]["ageTypeAr"] = $ageTypeAr;
		$response["items"][$i]["shares"] = $items[$i]["shares"];
		$response["items"][$i]["views"] = $items[$i]["views"];
		$response["items"][$i]["mobile"] = $items[$i]["mobile"];
		$categoryId = $items[$i]["categoryId"];
		if ( $images = selectDB('images',"`status` = '0' AND `itemId` = '{$items[$i]["id"]}' ORDER BY `id`")  ){
			for( $y = 0 ; $y < sizeof($images) ; $y++ ){
				$response["items"][0]["image"][] = $images[$y]["imageurl"];
			}
		}else{
			$response["items"][0]["image"] = array();
		}
		
		if ( $similar = selectDB('items',"`status` = '0' AND `categoryId` = '{$items[$i]["categoryId"]}' AND `id` != '{$items[$i]["id"]}' ORDER BY RAND() LIMIT 2")  ){
			for( $y = 0 ; $y < sizeof($similar) ; $y++ ){
				$response["items"][$i]["similar"][$y] = array(
				"id" => $similar[$y]["id"],
				"enTitle" => $similar[$y]["enTitle"],
				"arTitle" => $similar[$y]["arTitle"],
				"date" => $similar[$y]["date"],
				"price" => number_format($similar[$y]["price"],3) . " KWD",
				);
				if ( $images = selectDB('images',"`status` = '0' AND `itemId` = '{$similar[$y]["id"]}' ORDER BY RAND() LIMIT 1")  ){
						$response["items"][0]["similar"][$y]["image"] = $images[0]["imageurl"];
						$response["items"][0]["similar"][$y]["images"] = sizeof($images);
				}else{
					$response["items"][0]["similar"][$y]["image"] = "";
					$response["items"][0]["similar"][$y]["images"] = 0;
				}
			}
		}else{
			$response["items"][$i]["similar"] = array();
		}		
		if( $user = selectDB("customers","`id`= '{$items[$i]["customerId"]}'") ){
		    $response["items"][$i]["customer"] = array(
		        "id" => $user[0]["id"],
		        "name" => $user[0]["name"],
		        "phone" => $user[0]["mobile"],
		        "logo" => $user[0]["logo"]
		        );
		}else{
		  $response["items"][$i]["customer"] = array();   
		}
	}
	echo outputData($response);
}else{
	$msg = array("msg"=>"No items avaible!");
	echo outputError($msg);
}
?>