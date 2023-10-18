<?php

if( isset($_GET["type"]) && !empty($_GET["type"]) ){
	if( $_GET["type"] == "get" ){
		if( $categories = selectDB("categories","`status` = '0' AND `parentId` = '0' ORDER BY `id` ASC")){
			for( $i = 0 ; $i < sizeof($categories); $i++ ){
			    if( $getInterest = selectDB('interest',"`customerId` = '{$_POST["customerId"]}' AND `categoryId` = '{$categories[$i]["id"]}'") ){
					$category[] = array(
					    "id" => $categories[$i]["id"],
					    "enTitle" => $categories[$i]["enTitle"],
					    "arTitle" => $categories[$i]["arTitle"],
					    "interest" => 1
					    );
				}else{
				    $category[] = array(
					    "id" => $categories[$i]["id"],
					    "enTitle" => $categories[$i]["enTitle"],
					    "arTitle" => $categories[$i]["arTitle"],
					    "interest" => 0
					    );
				}
			}
			echo outputData($category);
		}else{
			$msg = "Something wrong happened, please check again later.";
			echo outputError($msg);
		}
	}elseif( $_GET["type"] == "add" ){
		if( !isset($_POST["customerId"]) || empty($_POST["customerId"]) ){
			$msg = "Please add customer Id...";
			echo outputError($msg);
		}
		if( !isset($_POST["category"][0]) || empty($_POST["category"][0]) ){
			$msg = "Please add at least on category id...";
			echo outputError($msg);
		}
		
		if( deleteDB('interest',"`customerId` = '{$_POST["customerId"]}'") ){
			for( $i = 0; $i < sizeof($_POST["category"]) ; $i++ ){
				$data = array(
					"customerId" => $_POST["customerId"],
					"categoryId" => $_POST["category"][$i]
				);
				if( insertDB("interest", $data) ){
					
				}
			}
			$msg = "Added successfully";
			echo outputData($msg);
		}else{
			$msg = "Could not remove old customer data..";
			echo outputError($msg);
		}
	}
}else{
	$msg = "Please set type...";
	echo outputError($msg);
}

?>