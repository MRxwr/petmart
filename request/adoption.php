<?php
if ( $categories = selectDB('categories',"`status` = '0' AND `type` = '3' AND `parentId` != '0'") ){
	for( $i = 0 ; $i < sizeof($categories) ; $i++ ){
		$response["categories"][$i]["id"] = $categories[$i]["id"];
		$response["categories"][$i]["arTitle"] = $categories[$i]["arTitle"];
		$response["categories"][$i]["enTitle"] = $categories[$i]["enTitle"];
	}
	$response["items"] = array();
	if( !isset($_GET["id"]) || empty($_GET["id"]) ){
		for ( $y = 0 ; $y < sizeof($categories) ; $y++ ){
			if( $items = selectDB('items',"`status` = '0' and `categoryId` = '{$categories[$y]["id"]}' ORDER BY `id` DESC") ){
				for( $i = 0 ; $i < sizeof($items) ; $i++ ){
					$items[$i]["date"] = date('Y-m-d H:i:s', strtotime($items[$i]["date"]) + (3 * 3600));
					if ( $images = selectDB('images',"`status` = '0' AND `itemId` = '{$items[$i]["id"]}' ORDER BY `id`")  ){
						$image = $images[0]["imageurl"];
						$images = sizeof($images);
					}else{
						$response["items"][$i]["image"] = "";
						$response["items"][$i]["images"] = 0;
					}
					$response["items"][] = array(
						"id" => $items[$i]["id"],
						"arTitle" => $items[$i]["arTitle"],
						"enTitle" => $items[$i]["enTitle"],
						"date" => $items[$i]["date"],
						"price" => $items[$i]["price"],
						"image" => $image,
						"images" => sizeof($images),
					);
				}
			}
		}
	}elseif( $items = selectDB('items',"`status` = '0' and `categoryId` = '{$_GET["id"]}' ORDER BY `id` DESC") ){
		for( $i = 0 ; $i < sizeof($items) ; $i++ ){
			$items[$i]["date"] = date('Y-m-d H:i:s', strtotime($items[$i]["date"]) + (3 * 3600));
			if ( $images = selectDB('images',"`status` = '0' AND `itemId` = '{$items[$i]["id"]}' ORDER BY `id`")  ){
				$image = $images[0]["imageurl"];
				$images = sizeof($images);
			}else{
				$response["items"][$i]["image"] = "";
				$response["items"][$i]["images"] = 0;
			}
			$response["items"][] = array(
				"id" => $items[$i]["id"],
				"arTitle" => $items[$i]["arTitle"],
				"enTitle" => $items[$i]["enTitle"],
				"date" => $items[$i]["date"],
				"price" => $items[$i]["price"],
				"image" => $image,
				"images" => sizeof($images),
			);
		}
	}
	echo outputData($response);
}else{
	$msg = array("items"=>array(),"msg"=>"No new post avaible!", "categories"=>array());
	echo outputError($msg);
}
?>