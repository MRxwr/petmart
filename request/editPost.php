<?php

if ( isset($_GET["edit"]) && $_GET["edit"] == "0" ){
	if ( $categories = selectDB('categories',"`status` = '0' AND `type` = '1' AND `parentId` = '0'") ){
		for( $i = 0 ; $i < sizeof($categories) ; $i++ ){
			$response["category"][$i]["id"] = $categories[$i]["id"];
			$response["category"][$i]["parentId"] = $categories[$i]["parentId"];
			$response["category"][$i]["arTitle"] = $categories[$i]["arTitle"];
			$response["category"][$i]["enTitle"] = $categories[$i]["enTitle"];
			if ( $subs = selectDB('categories',"`status` = '0' AND `type` = '1' AND `parentId` = '{$categories[$i]["id"]}'") ){
				for( $y = 0 ; $y < sizeof($subs) ; $y++ ){
					$response["category"][$i]["sub"][$y]["id"] = $subs[$y]["id"];
					$response["category"][$i]["sub"][$y]["parentId"] = $subs[$y]["parentId"];
					$response["category"][$i]["sub"][$y]["arTitle"] = $subs[$y]["arTitle"];
					$response["category"][$i]["sub"][$y]["enTitle"] = $subs[$y]["enTitle"];
				}
			}else{
				$response["category"][$i]["sub"] = array();
			}
		}
	}else{
		$response["category"] = array();
	}
	if ( $categories = selectDB('categories',"`status` = '0' AND `type` = '2' AND `parentId` = '0'") ){
		for( $i = 0 ; $i < sizeof($categories) ; $i++ ){
			$response["lost"][$i]["id"] = $categories[$i]["id"];
			$response["lost"][$i]["parentId"] = $categories[$i]["parentId"];
			$response["lost"][$i]["arTitle"] = $categories[$i]["arTitle"];
			$response["lost"][$i]["enTitle"] = $categories[$i]["enTitle"];
			if ( $subs = selectDB('categories',"`status` = '0' AND `type` = '2' AND `parentId` = '{$categories[$i]["id"]}'") ){
				for( $y = 0 ; $y < sizeof($subs) ; $y++ ){
					$response["lost"][$i]["sub"][$y]["id"] = $subs[$y]["id"];
					$response["lost"][$i]["sub"][$y]["parentId"] = $subs[$y]["parentId"];
					$response["lost"][$i]["sub"][$y]["arTitle"] = $subs[$y]["arTitle"];
					$response["lost"][$i]["sub"][$y]["enTitle"] = $subs[$y]["enTitle"];
				}
			}else{
				$response["lost"][$i]["sub"] = array();
			}
		}
	}else{
		$response["lost"] = array();
	}
	if ( $categories = selectDB('categories',"`status` = '0' AND `type` = '3' AND `parentId` = '0'") ){
		for( $i = 0 ; $i < sizeof($categories) ; $i++ ){
			$response["adoption"][$i]["id"] = $categories[$i]["id"];
			$response["adoption"][$i]["parentId"] = $categories[$i]["parentId"];
			$response["adoption"][$i]["arTitle"] = $categories[$i]["arTitle"];
			$response["adoption"][$i]["enTitle"] = $categories[$i]["enTitle"];
			if ( $subs = selectDB('categories',"`status` = '0' AND `type` = '3' AND `parentId` = '{$categories[$i]["id"]}'") ){
				for( $y = 0 ; $y < sizeof($subs) ; $y++ ){
					$response["adoption"][$i]["sub"][$y]["id"] = $subs[$y]["id"];
					$response["adoption"][$i]["sub"][$y]["parentId"] = $subs[$y]["parentId"];
					$response["adoption"][$i]["sub"][$y]["arTitle"] = $subs[$y]["arTitle"];
					$response["adoption"][$i]["sub"][$y]["enTitle"] = $subs[$y]["enTitle"];
				}
			}else{
				$response["adoption"][$i]["sub"] = array();
			}
		}
	}else{
		$response["adoption"] = array();
	}
	
	$response["gender"] = array(
		'arabic' => array(
			0 => 'زوج',
			1 => 'ذكر',
			2 => 'انثى',
			3 => 'غير معروف'
		),
		'English' => array(
			0 => 'Couple',
			1 => 'Male',
			2 => 'Female',
			3 => 'Not Applicable'
		)
	);
	
	$response["ageType"] = array(
		'arabic' => array(
			0 => 'يوم',
			1 => 'إسبوع',
			2 => 'شهر',
			3 => 'سنة'
		),
		'English' => array(
			0 => 'Day',
			1 => 'Week',
			2 => 'Month',
			3 => 'Year'
		)
	);
	
	if ( $item = selectDB('items',"`id` = '{$_GET["id"]}'") ){
		$response["post"][0]["categoryId"] = $item[0]["categoryId"];
		$response["post"][0]["customerId"] = $item[0]["customerId"];
		$response["post"][0]["enTitle"] = $item[0]["enTitle"];
		$response["post"][0]["arTitle"] = $item[0]["arTitle"];
		$response["post"][0]["enDetails"] = $item[0]["enDetails"];
		$response["post"][0]["arDetails"] = $item[0]["arDetails"];
		$response["post"][0]["price"] = $item[0]["price"];
		$response["post"][0]["date"] = $item[0]["date"];
		$response["post"][0]["age"] = $item[0]["age"];
		$response["post"][0]["ageType"] = $item[0]["ageType"];
		$response["post"][0]["gender"] = $item[0]["gender"];
		$response["post"][0]["video"] = $item[0]["video"];
		if ( $images = selectDB('images',"`status` = '0' AND `itemId` = '{$_GET["id"]}'") ){
			for( $y = 0 ; $y < sizeof($images) ; $y++ ){
				$response["post"][0]["image"][$y] = $images[$y]["imageurl"];
				$response["post"][0]["imageId"][$y] = $images[$y]["id"];
			}
		}else{
			$response["post"][0]["image"] = array();
			$response["post"][0]["imageId"] = array();
		}
	}else{ 
		$response["post"] = array();
	}
	
	echo outputData($response);
}elseif ( isset($_GET["edit"]) && $_GET["edit"] == "1" ){
	if ( !isset($_POST["customerId"]) || empty($_POST["customerId"]) ){
		$error = array("msg"=>"Please enter customer Id");
		echo outputError($error);die();
	}
	if ( !isset($_POST["categoryId"]) || empty($_POST["categoryId"]) ){
		$error = array("msg"=>"Please enter Category Id");
		echo outputError($error);die();
	}
	if ( !isset($_POST["arTitle"]) || empty($_POST["arTitle"]) ){
		$error = array("msg"=>"Please enter Arabic Title");
		echo outputError($error);die();
	}
	if ( !isset($_POST["enTitle"]) || empty($_POST["enTitle"]) ){
		$error = array("msg"=>"Please enter English Title");
		echo outputError($error);die();
	}
	if ( !isset($_POST["arDetails"]) || empty($_POST["arDetails"]) ){
		$error = array("msg"=>"Please enter Arabic Details");
		echo outputError($error);die();
	}
	if ( !isset($_POST["enDetails"]) || empty($_POST["enDetails"]) ){
		$error = array("msg"=>"Please enter English Details");
		echo outputError($error);die();
	}
	if ( !isset($_POST["age"]) ){
		$error = array("msg"=>"Please enter Age");
		echo outputError($error);die();
	}
	if ( !isset($_POST["ageType"]) ){
		$error = array("msg"=>"Please enter Age Type");
		echo outputError($error);die();
	}
	if ( !isset($_POST["gender"]) ){
		$error = array("msg"=>"Please enter Gender");
		echo outputError($error);die();
	}
	if ( !isset($_POST["price"]) || empty($_POST["price"]) ){
		$error = array("msg"=>"Please enter Price");
		echo outputError($error);die();
	} 
	$user = selectDB('customers',"`id` LIKE '{$_POST["customerId"]}'");
	$_POST["mobile"] = $user[0]["mobile"];
	$data = $_POST;
	if( updateDB('items',$data,"`id` = {$_GET["id"]}") ){
		$imageData["itemId"] = $_GET["id"];
		for( $i = 0; $i < sizeof($_FILES['image']['tmp_name']) ; $i++ ){
			if( isset($_FILES['image']['tmp_name'][$i]) AND is_uploaded_file($_FILES['image']['tmp_name'][$i]) ){
				$ext = end((explode(".", $_FILES['image']['name'][$i])));
				$directory = "../admin/logos/";
				$originalfile = $directory . md5(date("d-m-y").time().rand(111111,999999))."." . $ext;
				move_uploaded_file($_FILES['image']["tmp_name"][$i], $originalfile);
				$imageData["imageurl"] = str_replace("../admin/logos/",'',$originalfile);
				insertDB('images',$imageData);
			}
		}
		$response = array(
			'msg'=>"Updated successfully"
		);
		echo outputData($response);
	}else{
		$error = array("msg"=>"Please enter post data correctly.");
		echo outputError($error);die();
	}
}else{
	$error = array("msg"=>"Please enter add type");
	echo outputError($error);die();
}

?>