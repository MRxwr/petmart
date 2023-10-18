<?php
if( isset($_GET["search"]) && !empty($_GET["search"]) ){
	if( $items = selectDB('items'," `enTitle` LIKE '%{$_GET["search"]}%' OR `arTitle` LIKE '%{$_GET["search"]}%' AND `status` = '0'") ){
		for( $i = 0 ; $i < sizeof($items) ; $i++ ){
			$response["items"][$i]["id"] = $items[$i]["id"];
			$response["items"][$i]["arTitle"] = $items[$i]["arTitle"];
			$response["items"][$i]["enTitle"] = $items[$i]["enTitle"];
			$response["items"][$i]["price"] = number_format($items[$i]["price"],3)." KWD";
			$response["items"][$i]["date"] = $items[$i]["date"];
			
			if ( $images =  selectDB('images',"`itemId` LIKE '".$items[$i]["id"]."' AND `status` LIKE '0' ORDER BY `id` ASC") ){
				for( $z = 0 ; $z < 1 ; $z++ ){
					for( $y = 0 ; $y < sizeof($unsetData) ; $y++ ){
						unset($images[$y][$unsetData[$y]]);
						$response["items"][$i]["image"] = $images[$z]["imageurl"];
						$response["items"][$i]["images"] = sizeof($images);
					}
				}
			}else{
				$response["items"][$i]["image"] = "";
				$response["items"][$i]["images"] = 0;
			}
		}
		echo outputData($response);
	}else{
		$msg = "No result.";
		$error = array(
			"msg"	=>	$msg
		);
		echo outputError($msg);
	}
}else{
	$msg = "Please type something in search bar.";
	$error = array(
		"msg"	=>	$msg
	);
	echo outputError($msg);
}
?>