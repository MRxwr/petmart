<?php
if( $items = selectDB('shopItems',"`status` = '0' AND `id` = '{$_GET["id"]}'" ) ){
	$shops = selectDB('shops',"`status` = '0' AND `id` = '{$items[0]["shopId"]}'");
	for( $i = 0 ; $i < sizeof($items) ; $i++ ){
		$response["items"][$i]["id"] = $items[$i]["id"];
		$response["items"][$i]["arTitle"] = $items[$i]["arTitle"];
		$response["items"][$i]["enTitle"] = $items[$i]["enTitle"];
		$response["items"][$i]["arDetails"] = $items[$i]["arDetails"];
		$response["items"][$i]["enDetails"] = $items[$i]["enDetails"];
		$response["items"][$i]["price"] = number_format($items[$i]["price"],3) . " KWD";
		$response["items"][$i]["video"] = $items[$i]["video"];
		$response["items"][$i]["shares"] = $items[$i]["shares"];
		$response["items"][$i]["views"] = $items[$i]["views"];
		$response["items"][$i]["mobile"] = $shops[0]["mobile"];
		if ( $images = selectDB('shopGallery',"`status` = '0' AND `itemId` = '{$items[$i]["id"]}' ORDER BY `id` ASC LIMIT 1")  ){
			for( $y = 0 ; $y < sizeof($images) ; $y++ ){
				$response["items"][$i]["image"][] = $images[$y]["url"];
			}
		}else{
			$response["items"][$i]["image"][] = array();
		}
	}
	echo outputData($response);
}else{
	$msg = array("msg"=>"No item with this Id!");
	echo outputError($msg);
}
?>