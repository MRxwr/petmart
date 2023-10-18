<?php
if( isset($_FILES['logo']) AND is_uploaded_file($_FILES['logo']['tmp_name']) ){
	@$ext = end((explode(".", $_FILES['logo']['name'])));
	$directory = "logos/";
	$originalfile = $directory . md5(date("d-m-y").time().rand(111111,999999))."." . $ext;
	move_uploaded_file($_FILES["logo"]["tmp_name"], $originalfile);
	$_POST["url"] = str_replace("logos/",'',$originalfile);
	$table = "shopGallery";
	insertDB($table,$_POST);
	?>
	<script>
	window.location.href = "?page=shopItemImages&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}

if ( isset($_GET["delete"]) ){
	$table = "shopGallery";
	$data = array('status'=>'1');
	$where = "`id` LIKE '".$_GET["delete"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=shopItemImages&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}

if ( isset($_GET["return"]) ){
	$table = "shopGallery";
	$data = array('status'=>'0');
	$where = "`id` LIKE '".$_GET["return"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=shopItemImages&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
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
<h6 class="panel-title txt-dark">Add Photo</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=imageGallery&id=<?php echo $_GET["id"] ?>" method="post" enctype="multipart/form-data">

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1"></label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-file"></i></div>
<input type="file" class="form-control" name="logo" required>
</div>
</div>
</div>		

<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
<input type="hidden" name="itemId" value="<?php echo $_GET["id"] ?>">
<input type="hidden" name="vendorId" value="<?php echo $_GET["id"] ?>">
<input type="hidden" name="type" value="image">
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

<!-- Row -->
<?php

$status 		= array('0','1');
$arrayOfTitles 	= array('Active Photos','Inactive Photos');
$myTable 		= array('myTable1','myTable2');
$panel 			= array('panel-default','panel-danger');
$textColor 		= array('txt-dark','txt-light');
$icon 			= array('fa fa-trash-o','fa fa-refresh');
$action			= array('delete=','return=');

for($i = 0; $i < 2 ; $i++ ){
?>

<div class="row">
<div class="col-sm-12">
<div class="panel <?php echo $panel[$i] ?> card-view">
<div class="panel-heading">
<div class="pull-left">
<h6 class="panel-title <?php echo $textColor[$i] ?>"><?php echo $arrayOfTitles[$i] ?></h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="table-wrap">
<div class="">

<table id="<?php echo $myTable[$i] ?>" class="table table-hover display  pb-30" >
<thead>
<tr>
<th>Date</th>
<th>Photo</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<?php
$sql = "SELECT *
		FROM `shopGallery`
		WHERE
		`itemId` LIKE '".$_GET["id"]."'
		AND
		`status` LIKE '".$status[$i]."'
		AND
		`type` LIKE 'image'
		";
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
?>
<tr>
<td><?php echo substr($row["date"],0,11) ?></td>
<td>
<?php
if ( !empty($row["url"]) ){
?>
<img src="logos/<?php echo $row["url"] ?>" style="width:50px;height:50px">
<?php
}
?>
</td>
<td>

<a href="?page=shopItemImages&id=<?php echo $_GET["id"] ?>&<?php echo $action[$i] . $row["id"] ?>" style="margin:3px"><i class="<?php echo $icon[$i] ?>"></i></a>

</td>
</tr>
<?php
}
?>
</tbody>
</table>

</div>
</div>
</div>
</div>
</div>	
</div>
</div>
<?php
}
?>		
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