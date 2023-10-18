<?php
if ( /*`status` = '0' and */ $items = selectDB('items',"`customerId` = '{$_GET["id"]}' ORDER BY `id` DESC") ){
    $response["items"]["all"] = array();
	if ( $categories = selectDB('categories',"`parentId` != '0'") ){
		for( $i = 0 ; $i < sizeof($categories) ; $i++ ){
			if ( $items = selectDB('items',"`customerId` = '{$_GET['id']}' AND `categoryId` = '{$categories[$i]["id"]}' AND `status` = '0' ORDER BY `id` DESC") ){
				for( $y = 0 ; $y < sizeof($items) ; $y++ ){
					$items[$y]["date"] = date('Y-m-d H:i:s', strtotime($items[$y]["date"]) + (3 * 3600));
					if ( $images = selectDB('images',"`status` = '0' AND `itemId` = '{$items[$y]["id"]}' ORDER BY `id` ASC")  ){
						$image = $images[0]["imageurl"];
						$images = sizeof($images);
					}else{
						$image = "";
						$images = 0;
					}
					$response["items"]["all"][] = array(
						"id" => $items[$y]["id"],
						"arTitle" => $items[$y]["arTitle"],
						"enTitle" => $items[$y]["enTitle"],
						"price" => $items[$y]["price"],
						"date" => $items[$y]["date"],
						"image" => $image,
						"images" => $images
					);
				}
			}
		}
	}
    
    $response["items"]["sale"] = array();
	if ( $categories = selectDB('categories',"`type` = '1' AND `parentId` != '0'") ){
		for( $i = 0 ; $i < sizeof($categories) ; $i++ ){
			if ( $items = selectDB('items',"`customerId` = '{$_GET['id']}' AND `categoryId` = '{$categories[$i]["id"]}' AND `status` = '0' ORDER BY `id` DESC") ){
				for( $y = 0 ; $y < sizeof($items) ; $y++ ){
					$items[$y]["date"] = date('Y-m-d H:i:s', strtotime($items[$y]["date"]) + (3 * 3600));
					if ( $images = selectDB('images',"`status` = '0' AND `itemId` = '{$items[$y]["id"]}' ORDER BY `id` ASC")  ){
						$image = $images[0]["imageurl"];
						$images = sizeof($images);
					}else{
						$image = "";
						$images = 0;
					}
					$response["items"]["sale"][] = array(
						"id" => $items[$y]["id"],
						"arTitle" => $items[$y]["arTitle"],
						"enTitle" => $items[$y]["enTitle"],
						"price" => $items[$y]["price"],
						"date" => $items[$y]["date"],
						"image" => $image,
						"images" => $images
					);
				}
			}
		}
	}
	
	$response["items"]["lost"] = array();
	if ( $categories = selectDB('categories',"`type` = '2' AND `parentId` != '0'") ){
		for( $i = 0 ; $i < sizeof($categories) ; $i++ ){
			if ( $items = selectDB('items',"`customerId` = '{$_GET['id']}' AND `categoryId` = '{$categories[$i]["id"]}' AND `status` = '0' ORDER BY `id` DESC") ){
				for( $y = 0 ; $y < sizeof($items) ; $y++ ){
					$items[$y]["date"] = date('Y-m-d H:i:s', strtotime($items[$y]["date"]) + (3 * 3600));
					if ( $images = selectDB('images',"`status` = '0' AND `itemId` = '{$items[$y]["id"]}' ORDER BY `id` ASC")  ){
						$image = $images[0]["imageurl"];
						$images = sizeof($images);
					}else{
						$image = "";
						$images = 0;
					}
					$response["items"]["lost"][] = array(
						"id" => $items[$y]["id"],
						"arTitle" => $items[$y]["arTitle"],
						"enTitle" => $items[$y]["enTitle"],
						"price" => $items[$y]["price"],
						"date" => $items[$y]["date"],
						"image" => $image,
						"images" => $images
					);
				}
			}
		}
	}
	
	$response["items"]["adoption"] = array();
	if ( $categories = selectDB('categories',"`type` = '3' AND `parentId` != '0'") ){
		for( $i = 0 ; $i < sizeof($categories) ; $i++ ){
			if ( $items = selectDB('items',"`customerId` = '{$_GET['id']}' AND `categoryId` = '{$categories[$i]["id"]}' AND `status` = '0' ORDER BY `id` DESC") ){
				for( $y = 0 ; $y < sizeof($items) ; $y++ ){
					$items[$y]["date"] = date('Y-m-d H:i:s', strtotime($items[$y]["date"]) + (3 * 3600));
					if ( $images = selectDB('images',"`status` = '0' AND `itemId` = '{$items[$y]["id"]}' ORDER BY `id` ASC")  ){
						$image = $images[0]["imageurl"];
						$images = sizeof($images);
					}else{
						$image = "";
						$images = 0;
					}
					$response["items"]["adoption"][] = array(
						"id" => $items[$y]["id"],
						"arTitle" => $items[$y]["arTitle"],
						"enTitle" => $items[$y]["enTitle"],
						"price" => $items[$y]["price"],
						"date" => $items[$y]["date"],
						"image" => $image,
						"images" => $images
					);
				}
			}
		}
	}
	
	echo outputData($response);
}else{
	$msg = array("items"=>array("sale"=>array(),"lost"=>array(),"adoption"=>array()),"msg"=>"No items avaible!");
	echo outputError($msg);
}
?>