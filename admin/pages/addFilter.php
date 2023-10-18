<?php
if ( isset($_POST["shopId"]) ){
	$allTags = selectDB('filters'," `id` != '0' ");
	//var_dump($_POST);
	$table = "shops_filters";
	$data = array('status'=>'1');
	$where = " `shopId` LIKE '".$_POST["shopId"]."'";
	updateDB($table,$data,$where);
	$shopId = $_POST["shopId"];
	for( $i=0; $i < sizeof($allTags); $i++){
		if(isset($_POST["filterId$i"])){
			$filters[] = $_POST["filterId$i"];
		}
	}
	unset($_POST);
	for( $i=0; $i < sizeof($filters); $i++){
		$_POST["shopId"] = $shopId;
		$_POST["filterId"] = $filters[$i];
		//var_dump($_POST);
		insertDB($table,$_POST);
	}
	?>
	<script>
		window.location.href = "?page=shops";
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
<h6 class="panel-title txt-dark">Select Filters for Shop</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=addFilter" method="post" enctype="multipart/form-data">

<?php
$array = selectDB('filters'," `id` != '0' ");
@$array1 = selectDB('shops_filters'," `shopId` LIKE '".$_GET["id"]."' AND `status` LIKE '0' ");
for ($i=0 ; $i < sizeof($array) ; $i++){
	@$filters[] = $array1[$i]["filterId"];
}
for ($i=0 ; $i < sizeof($array) ; $i++){
	if ( @in_array($array[$i]["id"],$filters) ){
		$checked = "checked";
	}else{
		$checked = "";
	}
?>
<div class="col-md-2">
<div class="form-group">
<div class="input-group">
<div>
  <input type="checkbox" id="<?php echo $array[$i]["enTitle"] ?>" name="filterId<?php echo $i?>" <?php echo $checked ?> value="<?php echo $array[$i]["id"] ?>">
  <label for="<?php echo $array[$i]["enTitle"] ?>"><?php echo $array[$i]["enTitle"] ?></label>
</div>
</div>
</div>
</div>

<?php
}
?>
<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
</div>

<input type="hidden" name="shopId" value="<?php echo $_GET["id"] ?>" required>
<input type="hidden" name="vendorId" value="<?php echo $_GET["id"] ?>" required>
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