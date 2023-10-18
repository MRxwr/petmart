<?php
//get banners
if ( $banners = selectDataDB("`id`, `enTitle`, `arTitle`, `image`, `url`, `type`",'banners',"`status` LIKE '0' LIMIT 5") ){
	$response["banners"] = $banners;
}else{
	$response["banners"] = array();
}
//get categories
if ( $categories = selectDataDB("`id`, `enTitle`, `arTitle`, `logo`",'categories',"`status` = '0' AND `parentId` = '0' AND `type` = '1'") ){
	$response["categories"] = $categories;
}else{
	$response["categories"] = array();
}
// get total notifications
$response["totalNotifications"] = 0;
if ( isset($_GET["id"]) ){
	if( $notification = selectDB('notification', "`userId` LIKE '{$_GET["id"]}' AND `seen` = '0'") ){ 
		$response["totalNotifications"] = sizeof($notification) ;
	}
	if( $order = selectDB("order","`customerId` = '{$_GET["id"]}' AND `status` = '1' ORDER BY `date` DESC LIMIT 1") ){
		$original_date = $order[0]["date"];
		$modified_date = date('Y-m-d H:i:s', strtotime($original_date . " +{$order[0]["packageValidity"]} day"));
		if ( strtotime(date('Y-m-d H:i:s')) > strtotime($modified_date)  ) {
			updateDB("customers",array("points" => 0, "validity" => 0),"`id` = '{$_GET["id"]}'");
		}
	}
}

echo outputData($response);
?>