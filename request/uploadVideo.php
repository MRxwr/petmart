<?php
if ( isset($_FILES['video']["tmp_name"]) && !empty($_FILES['video']["tmp_name"]) ){
	$curl = curl_init();
	curl_setopt_array($curl, array(
	  CURLOPT_URL => 'https://api.imgur.com/3/upload',
	  CURLOPT_RETURNTRANSFER => true,
	  CURLOPT_ENCODING => '',
	  CURLOPT_MAXREDIRS => 10,
	  CURLOPT_TIMEOUT => 0,
	  CURLOPT_FOLLOWLOCATION => true,
	  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
	  CURLOPT_CUSTOMREQUEST => 'POST',
	  CURLOPT_POSTFIELDS => array('video'=> new CURLFILE($_FILES['video']["tmp_name"])),
	  CURLOPT_HTTPHEADER => array(
		'Authorization: Client-ID 386563124e58e6c'
	  ),
	));
	$response = curl_exec($curl);
	curl_close($curl);
	$response1 = json_decode($response,true);
}else{
	$msg = array('msg'=>"Please uplaod video.");
	echo outputError($msg); die();
}

if ( !isset( $response1["data"]["link"]) || empty( $response1["data"]["link"]) ){
	$video = array('msg'=>"Could not uplaod this video, Try Uploading again.");
	echo outputError($video);
}else{
	$video = array('link'=>$response1["data"]["link"]);
	echo outputData($video);
}
?>