<?php
if ( $categories = selectDB('categories',"`status` = '0' AND `parentId` = '{$_GET["id"]}' AND `type` = '1'") ){
	for( $i = 0 ; $i < sizeof($categories) ; $i++ ){
		$response["categories"][$i]["id"] = $categories[$i]["id"];
		$response["categories"][$i]["arTitle"] = $categories[$i]["arTitle"];
		$response["categories"][$i]["enTitle"] = $categories[$i]["enTitle"];
		$response["categories"][$i]["image"] = $categories[$i]["logo"];
	}
	echo outputData($response);
}else{
	$msg = array("msg"=>"No categories avaible!", "categories"=>array());
	echo outputError($msg);
}
?>