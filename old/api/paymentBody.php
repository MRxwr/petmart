<?php
if ( $_POST["paymentMethod"] == 3 ){
	$paymentMethod = 1;
	$cash = 1;
}else{
	$cash = 0;
}

if (is_numeric($phone)){
	$phone1 = $phone;
}else{
	$phone1 = "12345678";
}

$postMethodLines = array(
	"endpoint" 				=> "PaymentRequestExicuteForStore",
	"apikey" 				=> "$PaymentAPIKey",
	"PaymentMethodId" 		=> "$paymentMethod",
	"CustomerName"			=> "$name",
	"DisplayCurrencyIso"	=> "KWD", 
	"MobileCountryCode"		=> "+965", 
	"CustomerMobile"		=> substr($phone1,0,11),
	"CustomerEmail"			=> $settingsEmail,
	"invoiceValue"			=> $totalPrice,
	"SourceInfo"			=> '',
	"CallBackUrl"			=> $settingsWebsite.'/details.php',
	"ErrorUrl"				=> $settingsWebsite.'/checkout.php?status=fail'
);
/*
for ( $i = 0 ; $i < sizeof($RealId) ; $i++ ){
	$postMethodLines["InvoiceItems"][$i] =
	array(
		"ItemName" 	=> $RealTitle[$i],
		"Quantity" 	=> $_SESSION["cart"]["qorder"][$i],
		"UnitPrice" => $productPrice[$i]
	);
}

$postMethodLines["InvoiceItems"][] =
	array(
		"ItemName" 	=> 'Delivery',
		"Quantity" => 1,
		"UnitPrice" => $delivery
	);
/*
$postMethodLines["InvoiceItems"][] =
	array(
		"ItemName" 	=> 'Service Charge',
		"Quantity" => 1,
		"UnitPrice" => 0.250
	);

if ( $VisaCard != 0 ){
	$postMethodLines["InvoiceItems"][] =
		array(
			"ItemName" 	=> 'Visa/Master',
			"Quantity" => 1,
			"UnitPrice" => $VisaCard
		);
}

$postMethodLines["Suppliers"][0] =
	array(
		"SupplierCode" 	=> 19,
		"ProposedShare" => null,
		"InvoiceShare" => (array_sum($productPrice)+$delivery+$VisaCard)
	);
*/

jump:
####### Execute Payment ######
$curl = curl_init();
$headers  = [
            'Content-Type:application/json'
        ];
curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://payapi.createkwservers.com/api/v2/index.php',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_POST => 1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  CURLOPT_POSTFIELDS => json_encode($postMethodLines),
  CURLOPT_HTTPHEADER => $headers,
));
$response = curl_exec($curl);
curl_close($curl);
$resultMY = json_decode($response, true);
//echo json_encode($resultMY);

if(isset($resultMY["data"]["InvoiceId"])){
  $orderId = $resultMY["data"]["InvoiceId"];
}else{
  goto jump;
}
// if ( empty($orderId) ){
  
// }

if ( $cash == 1 ){
	$paymentMethod = 3;
}
?>