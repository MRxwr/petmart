<?php
if ( isset($_GET["c"]) ){
	$Key = $_GET["c"];
	//$KeyType = "InvoiceId";
	$orderId = $_GET["c"];
}else{
	$Key = $_GET["OrderID"];
	$orderId = $_GET["OrderID"];
	//$KeyType = "paymentId";
}
/*
$postMethodLines = array(
"endpoint" 				=> "PaymentStatusCheck",
"apikey" 				=> "$PaymentAPIKey",
"Key" 					=> $Key,
"KeyType"				=> $KeyType
);

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://payapi.createkwservers.com/api/index.php',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => json_encode($postMethodLines),
  CURLOPT_HTTPHEADER => array(
    'Cookie: PHPSESSID=037d057494de32a24a7effeab3ec2597'
  ),
));

$response = curl_exec($curl);
$err = curl_error($curl);
curl_close($curl);

if ($err) {
	echo "cURL Error #:" . $err;
}else{
	$resultMY = json_decode($response, true);
	$orderId = $resultMY["data"]["Data"]["InvoiceId"];
}
*/