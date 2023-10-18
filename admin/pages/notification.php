<?php
//require('../admin/includes/config.php');
if ( isset($_POST["title"]) ){
	$server_key = 'AAAAVw4Yilw:APA91bGxbiOtYaGU4ZyqwVxmp8Z3zalKx4eDQrXxlqtNBOAZOVi3yqP7556gM2cGoTj0_vqx4oqrL84-VVigwXSM6taL-1cNQ2379GnLRTbaqSuirgzF_jxoStNwrGwAtDBQWUKAEoPW';
	$url = 'https://fcm.googleapis.com/fcm/send';
	$headers = array(
		'Content-Type:application/json',
		'Authorization:key='.$server_key
	);
	$sql = "SELECT * FROM `customers` GROUP BY `firebase`";
	$result = $dbconnect->query($sql);
	while( $row = $result->fetch_assoc() ){
		$to = $row["firebase"];
		$title = $_POST["title"];
		$body = $_POST["msg"];
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
}
?>

<div class="right-sidebar-backdrop"></div>

<!-- Main Content -->
<div class="page-wrapper">
	<div class="container-fluid pt-25">
		<!-- Row -->
		
		<div class="row">
		
			
<!-- /Title -->

<div class="row">

<div class="col-md-12">
<div class="panel panel-default card-view">
<div class="panel-heading">
<div class="pull-left">
<h6 class="panel-title txt-dark">Send Notification</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="" method="post" enctype="multipart/form-data">

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Title</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-file"></i></div>
<input type="text" class="form-control" name="title" required>
</div>
</div>
</div>	

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Message</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-file"></i></div>
<input type="text" class="form-control" name="msg" required>
</div>
</div>
</div>	

<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
<input type="hidden" name="date" value="<?php echo $date ?>">
</div>

</form>

</div>
</div>
</div>
</div>
</div>
</div>
</div>

</div>

		</div>
		
		<!-- /Row -->
	</div>

<!-- Footer -->
	<footer class="footer container-fluid pl-30 pr-30">
		<div class="row">
			<div class="col-sm-12">
				<p>2021 &copy; Create Co.</p>
			</div>
		</div>
	</footer>
	<!-- /Footer -->
	
</div>

<!-- /Main Content -->