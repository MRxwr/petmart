<?php
if ( isset($_POST["priceFrom"]) && !isset($_POST["edit"]) ){
	$table = "auctions_bid_options";
	insertDB($table,$_POST);
}
if ( isset($_GET["delete"]) ){
	$table = "auctions_bid_options";
	$data = array('status'=>'1');
	$where = "`id` LIKE '".$_GET["delete"]."'";
	updateDB($table,$data,$where);
}
if ( isset($_GET["return"]) ){
	$table = "auctions_bid_options";
	$data = array('status'=>'0');
	$where = "`id` LIKE '".$_GET["return"]."'";
	updateDB($table,$data,$where);
}
if ( isset($_GET["edit"]) ){
	$table = "auctions_bid_options";
	$where = "`id` LIKE '".$_GET["id"]."'";
	$data = selectDB($table,$where);
}
if ( isset($_POST["edit"]) ){
	$table = "auctions_bid_options";
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
<h6 class="panel-title txt-dark">Bid Range Details</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=bidOptions" method="post" enctype="multipart/form-data">

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">From</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" id="exampleInputuname_1" placeholder="price start from" name="priceFrom" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["priceFrom"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">To</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" id="exampleInputuname_1" placeholder="price ends at" name="priceTo" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["priceTo"] ?>"<?php }?> required>
</div>
</div>
</div>	

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Bid 1</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" id="exampleInputuname_1" placeholder="1st bid" name="bid1" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["bid1"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Bid 2</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" id="exampleInputuname_1" placeholder="2nd bid" name="bid2" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["bid2"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Bid 3</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" id="exampleInputuname_1" placeholder="3rd bid" name="bid3" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["bid3"] ?>"<?php }?> required>
</div>
</div>
</div>	

<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
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
$arrayOfTitles 	= array('Active Bid ranges','Inactive Bid ranges');
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
<th>From</th>
<th>To</th>
<th>Bid 1</th>
<th>Bid 2</th>
<th>Bid 3</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<?php
$sql = "SELECT t.*
		FROM `auctions_bid_options` as t
		WHERE
		t.status = '".$status[$i]."'
		";
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
?>
<tr>
<td><?php echo $row["priceFrom"] ?></td>
<td><?php echo $row["priceTo"] ?></td>
<td><?php echo $row["bid1"] ?></td>
<td><?php echo $row["bid2"] ?></td>
<td><?php echo $row["bid3"] ?></td>
<td>

<a href="?page=bidOptions&edit=1&id=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-edit"></i></a>

<a href="?page=bidOptions&<?php echo $action[$i] . $row["id"] ?>" style="margin:3px"><i class="<?php echo $icon[$i] ?>"></i></a>

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