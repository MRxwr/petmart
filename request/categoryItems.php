<?php
if ( !isset($_GET["id"]) || empty($_GET["id"]) ){
	$id = "";
}else{
	$id = " AND `categoryId` = '{$_GET["id"]}'";
}

if ( isset($_GET["id"]) && !empty($_GET["id"]) ){
	if ( $items = selectDB('items',"`status` = '0' {$id} ORDER BY `id` DESC") ){
		for( $i = 0 ; $i < sizeof($items) ; $i++ ){
			$items[$i]["date"] = date('Y-m-d H:i:s', strtotime($items[$i]["date"]) + (3 * 3600));
			$response["items"][$i]["id"] = $items[$i]["id"];
			$response["items"][$i]["arTitle"] = $items[$i]["arTitle"];
			$response["items"][$i]["enTitle"] = $items[$i]["enTitle"];
			$response["items"][$i]["price"] = number_format($items[$i]["price"],3)." KWD";
			$response["items"][$i]["date"] = substr($items[$i]["date"],0,10);
			if ( $images = selectDB('images',"`status` = '0' AND `itemId` = '{$items[$i]["id"]}' ORDER BY `id` ASC")  ){
				$response["items"][$i]["image"] = $images[0]["imageurl"];
				$response["items"][$i]["images"] = sizeof($images);
			}else{
				$response["items"][$i]["image"] = "";
				$response["items"][$i]["images"] = 0;
			}
		}
		echo outputData($response);
	}else{
		$msg = array("items"=>array(),"msg"=>"No items avaible!");
		echo outputError($msg);die();
	}
}else{
	if ( $category = selectDataDB("`id`","categories","`parentId` = '{$_GET["parentId"]}'") ){
		$counter = 0;
		for ( $y = 0 ; $y < sizeof($category) ; $y++ ){
			if ( $items = selectDB('items',"`status` = '0' AND `categoryId` = '{$category[$y]["id"]}' ORDER BY `id` DESC") ){
				for( $i = 0 ; $i < sizeof($items) ; $i++ ){
					$items[$i]["date"] = date('Y-m-d H:i:s', strtotime($items[$i]["date"]) + (3 * 3600));
					$response["items"][$counter]["id"] = $items[$i]["id"];
					$response["items"][$counter]["arTitle"] = $items[$i]["arTitle"];
					$response["items"][$counter]["enTitle"] = $items[$i]["enTitle"];
					$response["items"][$counter]["price"] = number_format($items[$i]["price"],3)." KWD";
					$response["items"][$counter]["date"] = substr($items[$i]["date"],0,10);
					if ( $images = selectDB('images',"`status` = '0' AND `itemId` = '{$items[$i]["id"]}' ORDER BY `id` ASC")  ){
						$response["items"][$counter]["image"] = $images[0]["imageurl"];
						$response["items"][$counter]["images"] = sizeof($images);
					}else{
						$response["items"][$counter]["image"] = "";
						$response["items"][$counter]["images"] = 0;
					}
					$counter++;
				}
			}
		}
		if( sizeof($response["items"]) < 1 ){
			$msg = array("items"=>array(),"msg"=>"No items avaible!");
			echo outputError($msg);die();
		}
	}else{
		$msg = array("items"=>array(),"msg"=>"No items avaible!");
		echo outputError($msg);die();
	}
	echo outputData($response);
}
?>