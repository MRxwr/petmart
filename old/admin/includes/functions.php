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
//Notification through Create Pay
function sendNotification($data){
	$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL => 'https://createpay.link/api/CreateInvoice.php',
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 0,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POSTFIELDS => array(
		'name' => $data["name"],
		'email' => $data["email"],
		'mobile' => $data["mobile"],
		'price' => $data["price"],
		'details' => $data["details"],
		'refference' => $data["refference"],
		'noti' => $data["noti"]
		),
	  CURLOPT_HTTPHEADER => array(
		'APPKEY: API123'
	  ),
	));

	$response = curl_exec($curl);

	curl_close($curl);
	//echo $response;
}

// user
function getLoginStatus(){
	GLOBAL $dbconnect,$userID,$logoutText,$ProfileText,$orderText,$loginText;
	$output = "";
	 if ( isset($userID) && !empty($userID) ){
	 $output .= "<a href='logout.php'><button class='btn join-btn' style='background: #5291cb;
    color: #fff;
    padding: 0.4rem 1.2rem;
    border-radius: 6px;
    font-family: 'Tajawal';'>{$logoutText}</button></a>
		<button class='btn join-btn' data-toggle='modal' data-target='#editProfile_popup'>{$ProfileText}</button>
		<button class='btn join-btn' data-toggle='modal' data-target='#orders_popup'>{$orderText}</button>";
	}else{
		$output .= "<button class='btn join-btn' style='background: #5291cb;
    color: #fff;
    padding: 0.4rem 1.2rem;
    border-radius: 6px;
    font-family: 'Tajawal';
	' data-toggle='modal' data-target='#login_popup'>{$loginText}</button>";
	}
	return $output;
}

function sendMails($orderId, $email){
	GLOBAL $settingsEmail, $settingsTitle, $settingsWebsite, $settingslogo;
	for ( $i=0; $i<2; $i++){
		if ($i == 0){
			$sendEmail = $settingsEmail;
			$title = "New order - {$settingsTitle}";
			$msg = "<center>
					<img src='{$settingsWebsite}/logos/{$settingslogo}' style='width:200px;height:200px'>
					<p>&nbsp;</p>
					<p>Dear {$settingsEmail},</p>
					<p>Your have recived a new order with order ID:<br>
					</p>
					<p style='font-size: 25px; color: red'><strong>{$orderId}</strong></p>
					<p>Best regards,<br>
					<strong>{$settingsEmail}</strong></p>
					</center>";
		}else{
			$sendEmail = $email;
			$title = "Order From - {$settingsTitle}";
			$msg = "<center>
					<img src='{$settingsWebsite}/logos/{$settingslogo}' style='width:200px;height:200px'>
					<p>&nbsp;</p>
					<p>Dear {$email} owner,</p><p>Please keep this ID safe and check your order status with this ID on: <strong> <a href='{$settingsWebsite}'>{$settingsTitle}'</a></strong>.</p>
					<p>Your order ID is:<br>
					</p>
					<p style='font-size: 25px; color: red'><strong>{$orderId}</strong></p>
					<p>Best regards,<br>
					<strong>{$settingsTitle}</strong></p>
					</center>";
		}
		$curl = curl_init();
		curl_setopt_array($curl, array(
			CURLOPT_URL => 'myid.createkwservers.com/api/v1/send/notify',
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => '',
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 0,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'POST',
			CURLOPT_POSTFIELDS => array(
				'site' => $title,
				'subject' => "Order #{$orderId}",
				'body' => $msg,
				'from_email' => $settingsEmail,
				'to_email' => $sendEmail
			),
		));
		$response = curl_exec($curl);
		curl_close($curl);
	}
}

//categories
function getCategories(){
	$output = "";
	$categories = selectDB("categories","`hidden` = '0'");
	for ($i =0; $i < sizeof($categories); $i++){
		$output .= "<div class='col-md-4 col-sm-4 col-6 p-3' style='text-align: -webkit-center!important'>
		<a href='list.php?id={$categories[$i]["id"]}'>
		<img src='logos/{$categories[$i]["imageurl"]}' class='img-fluid product-box-img'>
		<span style='font-weight: 600;font-size: 18px;'>";
		$output .= direction($categories[$i]["enTitle"],$categories[$i]["arTitle"]);
		$output .= "</span>
		</a>
		</div>";
	}
	return $output;
}

//cart
function getCartPrice(){
	GLOBAL $_SESSION;
	for ($i =0; $i < sizeof($_SESSION["cart"]["id"]); $i++){
		$discount = selectDB("products","`id` = '{$_SESSION["cart"]["id"][$i]}'");
		$price = selectDB("subproducts","`id` = '{$_SESSION["cart"]["subId"][$i]}'");
		if ( isset($discount[0]["discount"]) && $discount[0]["discount"] != "0" ){
			$price = $price[0]["price"] - ( $price[0]["price"] * $discount[0]["discount"] / 100 );
		}else{
			$price = $price[0]["price"];
		}
		$totals[] = $price * $_SESSION["cart"]["qorder"][$i];
	}
	if ( isset($totals) ){
		return array_sum($totals) . "KD";
	}else{
		return 0 . "KD";
	}
}

function cartSVG(){
	return '<svg xmlns="http://www.w3.org/2000/svg" width="12.686" height="16" viewBox="0 0 12.686 16"><g data-name="Group 2704" transform="translate(-27.023 -2)"><g data-name="Group 17" transform="translate(27.023 5.156)"><g data-name="Group 16"><path data-name="Path 3" d="M65.7,111.043l-.714-9A1.125,1.125,0,0,0,63.871,101H62.459V103.1a.469.469,0,1,1-.937,0V101H57.211V103.1a.469.469,0,1,1-.937,0V101H54.862a1.125,1.125,0,0,0-1.117,1.033l-.715,9.006a2.605,2.605,0,0,0,2.6,2.8H63.1a2.605,2.605,0,0,0,2.6-2.806Zm-4.224-4.585-2.424,2.424a.468.468,0,0,1-.663,0l-1.136-1.136a.469.469,0,0,1,.663-.663l.8.8,2.092-2.092a.469.469,0,1,1,.663.663Z" transform="translate(-53.023 -101.005)" fill="currentColor"></path></g></g><g data-name="Group 19" transform="translate(30.274 2)"><g data-name="Group 18"><path data-name="Path 4" d="M160.132,0a3.1,3.1,0,0,0-3.093,3.093v.063h.937V3.093a2.155,2.155,0,1,1,4.311,0v.063h.937V3.093A3.1,3.1,0,0,0,160.132,0Z" transform="translate(-157.039)" fill="currentColor"></path></g></g></g></svg>';
}

//database connections
function selectDB($table, $where){
	GLOBAL $dbconnect;
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

function selectDB2($select, $table, $where){
	GLOBAL $dbconnect;
	$check = [';','"'];
	$where = str_replace($check,"",$where);
	$sql = "SELECT {$select} FROM `{$table}`";
	if ( !empty($where) ){
		$sql .= " WHERE {$where}";
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

function insertDB($table, $data){
	GLOBAL $dbconnect;
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
	GLOBAL $dbconnect;
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


//items
function updateItemQuantity($data){
	GLOBAL $dbconnect;
	$check = [';','"',"'"];
	$data = str_replace($check,"",$data);
	$sql = "UPDATE `subproducts`
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

// payment
function payment($data){
	$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL => 'https://createkwservers.com/payapi/api/v2/index.php',
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
	  CURLOPT_URL => 'https://createkwservers.com/payapi/api/v2/index.php',
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
    if (count($array) > 0){
        foreach ($array as $k => $v){
            if (is_array($v)){
                foreach ($v as $k2 => $v2){
                    if ($k2 == $on){
                        $sortable_array[$k] = $v2;
                    }
                }
            }else{
                $sortable_array[$k] = $v;
            }
        }
        switch($order){
            case SORT_ASC:
                asort($sortable_array);
            break;
            case SORT_DESC:
                arsort($sortable_array);
            break;
        }
        foreach ($sortable_array as $k => $v){
            $new_array[$k] = $array[$k];
        }
    }
    return $new_array;
}
?>