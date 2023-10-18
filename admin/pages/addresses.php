<?php
if ( isset($_POST["name"]) && !isset($_POST["edit"]) ){
	$table = "addresses";
	insertDB($table,$_POST);
}
if ( isset($_GET["delete"]) ){
	$table = "addresses";
	$data = array('status'=>'1');
	$where = "`id` LIKE '".$_GET["delete"]."'";
	updateDB($table,$data,$where);
}
if ( isset($_GET["return"]) ){
	$table = "addresses";
	$data = array('status'=>'0');
	$where = "`id` LIKE '".$_GET["return"]."'";
	updateDB($table,$data,$where);
}
if ( isset($_GET["edit"]) ){
	$table = "addresses";
	$where = "`id` LIKE '".$_GET["id"]."'";
	$data = selectDB($table,$where);
}

if ( isset($_POST["edit"]) ){
	$table = "addresses";
	$where = "`id` LIKE '".$_POST["edit"]."'";
	unset($_POST["edit"]);
	$data = $_POST;
	updateDB($table,$data,$where);
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
<h6 class="panel-title txt-dark">Address Details</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=addresses&id=<?php echo $_GET["id"] ?>" method="post" enctype="multipart/form-data">

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Name</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-user"></i></div>
<input type="text" class="form-control" name="name" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["name"].'"'; } ?>>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Mobile</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-phone"></i></div>
<input type="text" class="form-control" name="mobile" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["mobile"].'"'; } ?>>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Country</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-globe"></i></div>
<input type="text" class="form-control" name="country" value="Kwuait" readonly>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Area</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-location-arrow"></i></div>
<input type="text" class="form-control" name="area" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["area"].'"'; } ?>>
</div>
</div>
</div>

<div class="col-md-2">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Block</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-arrows-h"></i></div>
<input type="text" class="form-control" name="block" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["block"].'"'; } ?>>
</div>
</div>
</div>

<div class="col-md-2">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Street</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-road"></i></div>
<input type="text" class="form-control" name="street" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["street"].'"'; } ?>>
</div>
</div>
</div>

<div class="col-md-2">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">House</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-home"></i></div>
<input type="text" class="form-control" name="house" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["house"].'"'; } ?>>
</div>
</div>
</div>

<div class="col-md-2">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Avenue</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-arrows-h"></i></div>
<input type="text" class="form-control" name="avenue" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["avenue"].'"'; } ?>>
</div>
</div>
</div>

<div class="col-md-2">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Floor</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-building"></i></div>
<input type="text" class="form-control" name="floor" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["floor"].'"'; } ?>>
</div>
</div>
</div>

<div class="col-md-2">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Flat</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-fort-awesome"></i></div>
<input type="text" class="form-control" name="flat" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["flat"].'"'; } ?>>
</div>
</div>
</div>
		
<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
<input type="hidden" name="date" value="<?php echo $date ?>">
<input type="hidden" name="customerId" value="<?php echo $_GET["id"] ?>">
<?php
if ( isset($_GET["edit"]) ){
?>
	<input type="hidden" name="edit" value="<?php echo $_GET["addressId"] ?>">
<?php
}
?>
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
$arrayOfTitles 	= array('Active Addresses','Inactive Addresses');
$myTable 		= array('myTable1','myTable2');
$panel 			= array('panel-default','panel-danger');
$textColor 		= array('txt-dark','txt-light');
$icon 			= array('fa fa-trash-o','fa fa-refresh');
$action			= array('delete=','return=');

for($i = 0; $i < 2 ; $i++ ){
	if ( !isset($_GET["edit"]) ){
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
<th>Name</th>
<th>Country</th>
<th>Area</th>
<th>Block</th>
<th>Street</th>
<th>House</th>
<th>Avenue</th>
<th>Floor</th>
<th>Flat</th>
<th>Mobile</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<?php
$sql = "SELECT *
		FROM `addresses`
		WHERE
		status LIKE '".$status[$i]."'
		AND
		customerId LIKE '".$_GET["id"]."'
		";
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
?>
<tr>
<td><?php echo $row["name"] ?></td>
<td><?php echo $row["country"] ?></td>
<td><?php echo $row["area"] ?></td>
<td><?php echo $row["block"] ?></td>
<td><?php echo $row["street"] ?></td>
<td><?php echo $row["house"] ?></td>
<td><?php echo $row["avenue"] ?></td>
<td><?php echo $row["floor"] ?></td>
<td><?php echo $row["flat"] ?></td>
<td><a href="tel:<?php echo $row["mobile"] ?>">Call</a></td>
<td>

<a href="?page=addresses&edit=1&id=<?php echo $_GET["id"] ?>&addressId=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-edit"></i></a>

<a href="?page=addresses&id=<?php echo $row["id"] ?>&<?php echo $action[$i] . $row["id"] ?>" style="margin:3px"><i class="<?php echo $icon[$i] ?>"></i></a>

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
}
?>		
		</div>
		
		<!-- /Row -->
	</div>

<!-- Footer -->
	<footer class="footer container-fluid pl-30 pr-30">
		<div class="row">
			<div class="col-sm-12">
				<p>2021 &copy; Create Co. CMS</p>
			</div>
		</div>
	</footer>
	<!-- /Footer -->
	
</div>
<!-- /Main Content -->