<?php
if ( $banners = selectDataDB("`id`, `enTitle`, `arTitle`, `image`, `type`",'banners',"`status` LIKE '0'") ){
	$response["banners"] = $banners;
}else{
	$response["banners"] = array();
}
echo outputData($response);
?>