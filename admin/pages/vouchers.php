<?php
if ( isset($_POST["code"]) && !isset($_POST["edit"]) ){
	$table = "vouchers";
	insertDB($table,$_POST);
	?>
	<script>
		window.location.href = "?page=vouchers";
	</script>
	<?php
}
if ( isset($_GET["delete"]) ){
	$table = "vouchers";
	$data = array('status'=>'1');
	$where = "`id` LIKE '".$_GET["delete"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=vouchers";
	</script>
	<?php
}
if ( isset($_GET["return"]) ){
	$table = "vouchers";
	$data = array('status'=>'0');
	$where = "`id` LIKE '".$_GET["return"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=vouchers";
	</script>
	<?php
}
if ( isset($_GET["edit"]) ){
	$table = "vouchers";
	$where = "`id` LIKE '".$_GET["id"]."'";
	$data = selectDB($table,$where);
}

if ( isset($_POST["edit"]) ){
	$table = "vouchers";
	$where = "`id` LIKE '".$_POST["edit"]."'";
	unset($_POST["edit"]);
	$data = $_POST;
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=vouchers";
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
<h6 class="panel-title txt-dark">Voucher Details</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=vouchers" method="post" enctype="multipart/form-data">

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Code</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" name="code" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["code"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Discount Type</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<select class="form-control" name="discountType" required>
<?php
if( isset($_GET["edit"]) ){
	if ( $data[0]["discountType"] == 0 ){
		?>
		<option value="0" selected>Percentage</option>
		<?php
	}else{
		?>
		<option value="1" selected>Amount</option>
		<?php
	}
}
?>
<option value="0" >Percentage</option>
<option value="1">Amount</option>
</select>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Discount</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" name="discount" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["discount"] ?>"<?php }?> required>
</div>
</div>
</div>	
<?php
/*
<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">All</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<select class="form-control" name="is_all" required>
<?php
if( isset($_GET["edit"]) ){
	if ( $data[0]["is_all"] == 0 ){
		?>
		<option value="0" selected>No</option>
		<?php
	}else{
		?>
		<option value="1" selected>Yes</option>
		<?php
	}
}
?>
<option value="0" >No</option>
<option value="1">Yes</option>
</select>
</div>
</div>
</div>		

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Vendor</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<select class="form-control" name="vendorId" required>
<?php
if( isset($_GET["edit"]) ){
	if ( $data[0]["vendorId"] == 0 ){
		?>
		<option value="0" selected>Please select a vendor</option>
		<?php
	}else{
		?>
		<option value="<?php echo $data[0]["vendorId"] ?>" selected>
		<?php
		$vendor = selectDB('vendors'," `id` LIKE '".$data[0]["vendorId"]."'");
		echo $vendor[0]["username"];
		?>
		</option>
		<?php
	}
}
$vendors = selectDB('vendors'," `id` != '0'");
?>
<option value="0" >Please select a vendor</option>
<?php
for ( $i = 0 ; $i < sizeof($vendors); $i++ ){
	?>
	<option value="<?php echo $vendors[$i]["id"] ?>" >
	<?php
	echo $vendors[$i]["username"];
	?>
	</option>
	<?php
}
?>
</select>
</div>
</div>
</div>	
*/
?>
<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
<input type="hidden" class="form-control" name="is_all" value="1"required >
<input type="hidden" class="form-control" name="vendorId" value="1"required >
<input type="hidden" name="userId" value="<?php echo $userId ?>">
<input type="hidden" name="date" value="<?php echo $date ?>">
<?php if(isset($_GET["edit"])){?>
<input type="hidden" name="edit" value="<?php echo $_GET["id"] ?>">
<?php }?>
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
if ( !isset($_GET["edit"]) ){
$status 		= array('0','1');
$arrayOfTitles 	= array('Active vocuhers','Inactive vouchers');
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
<th>code</th>
<th>Discount</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<?php
$sql = "SELECT *
		FROM `vouchers`
		WHERE
		status = '".$status[$i]."'
		";
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
	if ( $row["discountType"] == 0 ){
		$discount = "%";
	}else{
		$discount = "KD";
	}
?>
<tr>
<td><?php echo substr($row["date"],0,11) ?></td>
<td><?php echo $row["code"] ?></td>
<td><?php echo $row["discount"] . $discount?></td>
<td>

<a href="?page=vouchers&edit=1&id=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-edit"></i></a>

<a href="?page=vouchers&<?php echo $action[$i] . $row["id"] ?>" style="margin:3px"><i class="<?php echo $icon[$i] ?>"></i></a>

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
				<p>2021 &copy; Create Co.</p>
			</div>
		</div>
	</footer>
	<!-- /Footer -->
	
</div>
<!-- /Main Content -->