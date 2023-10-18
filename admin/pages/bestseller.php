<?php
if ( isset($_COOKIE["ezyoVCreate"])  && !isset($_GET["edit"]) ){
	$array = selectDB('categories', " `id` LIKE '".$_GET["id"]."'");
	if ( $array[0]["vendorId"] != $userId ){
		?>
	<script>
		window.location.href = "?page=logout";
	</script>
	<?php
	}

}
if ( isset($_COOKIE["ezyoVCreate"])  && isset($_GET["edit"]) ){
	$array = selectDB('items', " `id` LIKE '".$_GET["id"]."'");
	$array1 = selectDB('categories', " `id` LIKE '".$array[0]["categoryId"]."'");
	if ( $array1[0]["vendorId"] != $userId ){
		?>
	<script>
		window.location.href = "?page=logout";
	</script>
	<?php
	}

}

if ( isset($_GET["isBest"]) ){
	$table = "items";
	$where = "`id` LIKE '".$_GET["isBest"]."'";
	$data = array("is_best"=>"1");
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=bestseller";
	</script>
	<?php
}

if ( isset($_GET["isNotBest"]) ){
	$table = "items";
	$where = "`id` LIKE '".$_GET["isNotBest"]."'";
	$data = array("is_best"=>"0");
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=bestseller";
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

<!-- Row -->
<?php
if ( !isset($_GET["edit"]) ){
$status 		= array('0','1');
$arrayOfTitles 	= array('BestSeller','Inactive Items');
$myTable 		= array('myTable1','myTable2');
$panel 			= array('panel-default','panel-danger');
$textColor 		= array('txt-dark','txt-light');
$icon 			= array('fa fa-trash-o','fa fa-refresh');
$action			= array('delete=','return=');

for($i = 0; $i < 1 ; $i++ ){
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
<th>English Title</th>
<th>Category</th>
<th>Brand</th>
<th>Quantity</th>
<th>Price</th>
<th>Discount</th>
<th>Video</th>
<th>Type</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<?php
$sql = "SELECT *
		FROM `items`
		WHERE
		status = '".$status[$i]."'
		";
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
	$brand = selectDB("brands","`id` = '{$row["brandId"]}'");
	$category = selectDB("categories","`id` = '{$row["categoryId"]}'");
	if ( $row["type"] == 0 ){
		$type = "Product";
	}elseif( $row["type"] == 1 ){
		$type = "Digital";
	}else{
		$type = "Service";
	}
?>
<tr>
<td><?php echo substr($row["date"],0,11) ?></td>
<td><?php echo $row["enTitle"] ?></td>
<td><?php echo $category[0]["enTitle"] ?></td>
<td><?php echo $brand[0]["enTitle"] ?></td>
<td><?php echo $row["quantity"] ?></td>
<td><?php echo $row["price"] ?>KD</td>
<?php
if ( $row["discountType"] == "0" ){
	?>
	<td><?php echo $row["discount"] ?>%</td>
	<?php
}else{
	?>
	<td><?php echo $row["discount"] ?>KD</td>
	<?php
}
?>
<td><?php if ( !empty($row["video"]) ){ echo '<a href="'.$row["video"].'" target="_blank">View</a>'; }else{ echo "None";} ?></td>
<td><?php echo $type ?></td>
<td>

<?php
if ( $row["is_best"] == 0 ){
	?>
	<a href="?page=bestseller&isBest=<?php echo $row["id"] ?>" style="margin:3px" class="btn btn-warning">Add</a>
	<?php
}else{
	?>
	<a href="?page=bestseller&isNotBest=<?php echo $row["id"] ?>" style="margin:3px" class="btn btn-success">Remove</a>
	<?php
}
?>

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