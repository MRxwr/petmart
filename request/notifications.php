<?php
if( $notifications = selectDB('notification', "`userId` LIKE '{$_GET["id"]}' ORDER BY `id` DESC")){
    foreach($notifications as $usr){
	    //var_dump($user); exit;
	    $auction = selectDB('auctions', "`id` LIKE '{$usr["auctionId"]}' ORDER BY `id` DESC");
	    if(!empty( $auction)){
	        if($auction['0']["winnerId"]==0){
	            //var_dump($auction); exit;
	            $data2nd = array(
            		"notification" => 'no one bid on your auction,لا يوجد مزايده علي إعلانك في المزاد',
            		"auctionType" => '0'
            	);
	            updateDB('notification',$data2nd,"`id` LIKE '{$usr["id"]}'");
	        }
	    }
	    
	}
	$user = selectDB('notification', "`userId` LIKE '{$_GET["id"]}' ORDER BY `id` DESC");
	$data = array(
		"seen" => '1'
	);
	updateDB('notification',$data,"`userId` LIKE '{$_GET["id"]}'");
	if ( $total = selectDB('notification', "`userId` LIKE '{$_GET["id"]}' AND `seen` LIKE '0'") ){
		$totalSeen = sizeof($total);
	}else{
		$totalSeen = "0";
	}
	$output = array(
		"total" => $totalSeen,
		"notification" => $user
	);
	echo outputData($output);
}else{
	$msg = array(
		"msg" => "user Id does not exist"
	);
	echo outputError($msg);
}
?>