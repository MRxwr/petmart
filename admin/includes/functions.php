<?php
function direction($valEn,$valAr){
	GLOBAL $directionHTML;
	if ( $directionHTML == "rtl" ){
		$response = $valAr;
	}else{
		$response = $valEn;
	}
	return $response;
}

function selectDB($table, $where){
   // date_default_timezone_set('Kuwait/Riyadh');
	GLOBAL $dbconnect;
	GLOBAL $date;
	$check = [';','"'];
	$where = str_replace($check,"",$where);
	$sql = "SELECT * FROM `".$table."`";
	if ( !empty($where) ){
		$sql .= " WHERE " . $where;
	}
	if($result = $dbconnect->query($sql)){
		while($row = $result->fetch_assoc() ){
			$array[] = $row;
		}
		if ( isset($array) AND is_array($array) ){
			return $array;
		}else{
			return 0;
		}
	}else{
		$error = array("msg"=>"select table error");
		return outputError($error);
	}
}

function selectDataDB($select, $table, $where){
    //date_default_timezone_set('Kuwait/Riyadh');
	GLOBAL $dbconnect;
	GLOBAL $date;
	$check = [';','"'];
	$where = str_replace($check,"",$where);
	$sql = "SELECT {$select} FROM `{$table}`";
	if ( !empty($where) ){
		$sql .= " WHERE " . $where;
	}
	if($result = $dbconnect->query($sql)){
		while($row = $result->fetch_assoc() ){
			$array[] = $row;
		}
		if ( isset($array) AND is_array($array) ){
			return $array;
		}else{
			return 0;
		}
	}else{
		$error = array("msg"=>"select table error");
		return outputError($error);
	}
}

function deleteDB($table, $where){
    //date_default_timezone_set('Kuwait/Riyadh');
	GLOBAL $dbconnect;
	GLOBAL $date;
	$check = [';','"'];
	$where = str_replace($check,"",$where);
	$sql = "DELETE FROM `".$table."`";
	if ( !empty($where) ){
		$sql .= " WHERE " . $where;
	}
	if($result = $dbconnect->query($sql)){
		return 1;
	}else{
		$error = array("msg"=>"delete table error");
		return outputError($error);
	}
}

function insertDB($table, $data){
    //date_default_timezone_set('Kuwait/Riyadh');
	GLOBAL $dbconnect;
	GLOBAL $date;
	$check = [';','"'];
	$data = str_replace($check,"",$data);
	$keys = array_keys($data);
	$sql = "INSERT INTO `".$table."`(";
	for($i = 0 ; $i < sizeof($keys) ; $i++ ){
		$sql .= "`".$keys[$i]."`";
		if ( isset($keys[$i+1]) ){
			$sql .= ", ";
		}
	}
	$sql .= ")VALUES(";
	for($i = 0 ; $i < sizeof($data) ; $i++ ){
		$sql .= "'".$data[$keys[$i]]."'";
		if ( isset($keys[$i+1]) ){
			$sql .= ", ";
		}
	}		
	$sql .= ")";
	if($dbconnect->query($sql)){
		return 1;
	}else{
		$error = array("msg"=>"insert table error");
		return outputError($error);
	}
}

function updateDB($table ,$data, $where){
    //date_default_timezone_set('Kuwait/Riyadh');
	GLOBAL $dbconnect;
	GLOBAL $date;
	$check = [';','"'];
	$data = str_replace($check,"",$data);
	$where = str_replace($check,"",$where);
	$keys = array_keys($data);
	$sql = "UPDATE `".$table."` SET ";
	for($i = 0 ; $i < sizeof($data) ; $i++ ){
		$sql .= "`".$keys[$i]."` = '".$data[$keys[$i]]."'";
		if ( isset($keys[$i+1]) ){
			$sql .= ", ";
		}
	}		
	$sql .= " WHERE " . $where;
	if($dbconnect->query($sql)){
		return 1;
	}else{
		$error = array("msg"=>"update table error");
		return outputError($error);
	}
}

function updateItemQuantity($data){
    //date_default_timezone_set('Kuwait/Riyadh');
	GLOBAL $dbconnect;
	GLOBAL $date;
	$check = [';','"',"'"];
	$data = str_replace($check,"",$data);
	$sql = "UPDATE `items`
			SET 
			`quantity` = `quantity`-".$data["quantity"]."
			WHERE
			`id` LIKE '".$data["id"]."'
			";
	if($dbconnect->query($sql)){
		return 1;
	}else{
		$error = array("msg"=>"update quantity error");
		return outputError($error);
	}
}

function outputData($data){
	$response["ok"] = true;
	$response["error"] = "0";
	$response["status"] = "successful";
	$response["data"] = $data;
	return json_encode($response);
}

function outputError($data){
	$response["ok"] = false;
	$response["error"] = "1";
	$response["status"] = "Error";
	$response["data"] = $data;
	return json_encode($response);
}

function payment($data){
	$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL => 'https://createapi.link/api/v2/index.php',
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 0,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POSTFIELDS => json_encode($data),
	));
	$response = curl_exec($curl);
	curl_close($curl);
	$response = json_decode($response,true);
	$array = [
		"url" => $response["data"]["PaymentURL"],
		"id" => $response["data"]["InvoiceId"]
	];
	return $array;
}

function checkPayment($data){
	$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL => 'https://createapi.link/api/v2/index.php',
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 0,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POSTFIELDS => json_encode($data),
	));
	$response = curl_exec($curl);
	curl_close($curl);
	$response = json_decode($response,true);
	if ( !isset($response["data"]["Data"]["InvoiceStatus"]) ){
		$status = "Failed";
	}else{
		$status = $response["data"]["Data"]["InvoiceStatus"];
	}
	if ( !isset($response["data"]["Data"]["InvoiceId"]) ){
		$id = $data["Key"];
	}else{
		$id = $response["data"]["Data"]["InvoiceId"];
	}
	$array = [
		"status" => $status,
		"id" => $id
	];
	return $array;
}

function array_sort($array, $on, $order){
    $new_array = array();
    $sortable_array = array();
    if(count($array) > 0){
        foreach ($array as $k => $v) {
            if (is_array($v)) {
                foreach ($v as $k2 => $v2) {
                    if ($k2 == $on) {
                        $sortable_array[$k] = $v2;
                    }
                }
            }else{
                $sortable_array[$k] = $v;
            }
        }
        switch($order){
            case SORT_ASC: asort($sortable_array);
            break;
            case SORT_DESC: arsort($sortable_array);
            break;
        }
        foreach ($sortable_array as $k => $v) {
            $new_array[$k] = $array[$k];
        }
    }
    return $new_array;
}

function notificationToUser($data){
	$body = $data["body"];
	$title = $data["title"];
	$customerId = $data["customerId"];
	$server_key = 'AAAAVw4Yilw:APA91bGxbiOtYaGU4ZyqwVxmp8Z3zalKx4eDQrXxlqtNBOAZOVi3yqP7556gM2cGoTj0_vqx4oqrL84-VVigwXSM6taL-1cNQ2379GnLRTbaqSuirgzF_jxoStNwrGwAtDBQWUKAEoPW'; 
	$url = 'https://fcm.googleapis.com/fcm/send';
	$headers = array(
		'Content-Type:application/json',
		'Authorization:key='.$server_key
	);
	$firebase = selectDataDB("`firebase`","customers","`id` = '{$customerId}'");
	$to = $firebase[0]["firebase"];
	$json_data = array(
		"to" => "{$to}",
		"notification" => array(
			"body" => "{$body}",
			"text" => "{$body}",
			"title" => "{$title}",
			"sound" => "default",
			"content_available" => "true",
			"priority" => "high",
			"badge" => "1"
		),
		"data" => array(
			"body" => "{$body}",
			"title" => "{$title}",
			"text" => "{$body}",
			"sound" => "default",
			"content_available" => "true",
			"priority" => "high",
			"badge" => "1"
		)
	);
	$data = json_encode($json_data);
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_POST, true);
	curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
	$response = curl_exec($ch);
	curl_close($ch);
}

function notificationToUsers($data){
	$body = $data["body"];
	$title = $data["title"];
	$dbData = $data["dbData"];
	$server_key = 'AAAAVw4Yilw:APA91bGxbiOtYaGU4ZyqwVxmp8Z3zalKx4eDQrXxlqtNBOAZOVi3yqP7556gM2cGoTj0_vqx4oqrL84-VVigwXSM6taL-1cNQ2379GnLRTbaqSuirgzF_jxoStNwrGwAtDBQWUKAEoPW'; 
	$url = 'https://fcm.googleapis.com/fcm/send';
	$headers = array(
		'Content-Type:application/json',
		'Authorization:key='.$server_key
	);
	$json_data = array(
		"notification" => array(
			"body" => "{$body}",
			"text" => "{$body}",
			"title" => "{$title}",
			"sound" => "default",
			"content_available" => "true",
			"priority" => "high",
			"badge" => "1"
		),
		"data" => array(
			"body" => "{$body}",
			"title" => "{$title}",
			"text" => "{$body}",
			"sound" => "default",
			"content_available" => "true",
			"priority" => "high",
			"badge" => "1"
		)
	);
	for( $i = 0; $i < sizeof($dbData); $i++ ){
		$firebase = selectDB("customers","`id` = '{$dbData[$i]["customerId"]}'");
		$to = $firebase[$i]["firebase"];
		$json_data["to"] = $to;
		$data = json_encode($json_data);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		$response = curl_exec($ch);
		curl_close($ch);
		if( !isset($dbData[$i]["id"]) || empty($dbData[$i]["id"]) ){
			$dbData[$i]["id"] = 0;
			$dbData[$i]["auctionType"] = 2;
		}else{
			if( $auctionTitle = selectDB("auctions","`id` = '{$dbData[$i]["id"]}'") ){
				$title = $auctionTitle[0]["enTitle"];
			}
			$dbData[$i]["auctionType"] = 1;
		}
		$insertData = array(
			"userId" => $dbData[$i]["customerId"],
			"notification" => "{$title} -> {$body}",
			"auctionId" => $dbData[$i]["id"],
			"auctionType" => $dbData[$i]["auctionType"]
		);
		insertDB("notification",$insertData);
		updateDB('auctions',array("is_notify"=>'yes')," id='{$dbData[$i]["id"]}'");
		updateDB('auctions',array("status"=>'1')," id='{$dbData[$i]["id"]}'");
	}
	
}

function updateOrderStatusNotification($orderId, $status){
	$server_key = 'AAAAVw4Yilw:APA91bGxbiOtYaGU4ZyqwVxmp8Z3zalKx4eDQrXxlqtNBOAZOVi3yqP7556gM2cGoTj0_vqx4oqrL84-VVigwXSM6taL-1cNQ2379GnLRTbaqSuirgzF_jxoStNwrGwAtDBQWUKAEoPW'; 
	$url = 'https://fcm.googleapis.com/fcm/send';
	$headers = array(
		'Content-Type:application/json',
		'Authorization:key='.$server_key
	);
	$order = selectDB("orders","`orderId` = '{$orderId}'");
	$customers = selectDB("customers","`customerId` = '{$order[0]["customerId"]}'");
		$to = $customers[0]["firebase"];
		$title = "Boothaat Order status";
		if( $status == 2 ){
			$body = "You order #{$orderId} is being prepared.";
		}elseif( $status == 3 ){
			$body = "You order #{$orderId} is our for delivery.";
		}elseif( $status == 4 ){
			$body = "You order #{$orderId} is delivered.";
		}elseif( $status == 5 ){
			$body = "You order #{$orderId} is cancelled.";
		}elseif( $status == 6 ){
			$body = "You order #{$orderId} is refunded.";
		}else{
			$body = "You order #{$orderId} status being updated.";
		}
		$json_data = array(
			"to" => "{$to}",
			"notification" => array(
				"body" => "{$body}",
				"text" => "{$body}",
				"title" => "{$title}",
				"sound" => "default",
				"content_available" => "true",
				"priority" => "high",
				"badge" => "1"
			),
			"data" => array(
				"body" => "{$body}",
				"title" => "{$title}",
				"text" => "{$body}",
				"sound" => "default",
				"content_available" => "true",
				"priority" => "high",
				"badge" => "1"
			)
		);
		$data = json_encode($json_data);
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $url);
		curl_setopt($ch, CURLOPT_POST, true);
		curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
		curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
		$response = curl_exec($ch);
		curl_close($ch);
}
?>