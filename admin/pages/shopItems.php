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
	$array = selectDB('shopItems', " `id` LIKE '".$_GET["id"]."'");
	$array1 = selectDB('categories', " `id` LIKE '".$array[0]["categoryId"]."'");
	if ( $array1[0]["vendorId"] != $userId ){
		?>
	<script>
		window.location.href = "?page=logout";
	</script>
	<?php
	}

}

if ( isset($_POST["enTitle"]) && !isset($_POST["edit"]) ){
	$table = "shopItems";
	insertDB($table,$_POST);
	?>
	<script>
		window.location.href = "?page=shopItems&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
if ( isset($_GET["delete"]) ){
	$table = "shopItems";
	$data = array('status'=>'1');
	$where = "`id` LIKE '".$_GET["delete"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=shopItems&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
if ( isset($_GET["return"]) ){
	$table = "shopItems";
	$data = array('status'=>'0');
	$where = "`id` LIKE '".$_GET["return"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=shopItems&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
if ( isset($_GET["edit"]) ){
	$table = "shopItems";
	$where = "`id` LIKE '".$_GET["id"]."'";
	$data = selectDB($table,$where);
}

if ( isset($_POST["edit"]) ){
	$table = "shopItems";
	$where = "`id` LIKE '".$_POST["edit"]."'";
	unset($_POST["edit"]);
	$data = $_POST;
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=shopItems&id=<?php echo $_GET['id'] ?>";
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
<h6 class="panel-title txt-dark">Item Details</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=shopItems<?php if ( isset($_GET["id"]) ){echo "&id=".$_GET["id"];} ?>" method="post" enctype="multipart/form-data">

<div class="col-md-12" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="">Attributes</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<select class="form-control" name="is_variant" id="attributes" >
	 <?php
	 if(isset($_GET["edit"])){
		 if ($data[0]["is_variant"] == 0){
			 $variant = "No";
			 $styleHidden = "";
		 }else{
			 $variant = "Yes";
			 $styleHidden = "display:none";
		 }
		 echo "<option value='{$data[0]["is_variant"]}'>{$variant}</option>";
	 }
	 ?>
	<option value="0">No</option>
	<option value="1">Yes</option>
</select>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="">English Title</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="" placeholder="Full English Title" name="enTitle" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["enTitle"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="">Arabic Title</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="" placeholder="Enter Arabic Title" name="arTitle" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["arTitle"] ?>"<?php }?> required>
</div>
</div>
</div>	

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="">English Details</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="" placeholder="Full English Details" name="enDetails" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["enDetails"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="">Arabic Details</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="" placeholder="Enter Arabic Details" name="arDetails" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["arDetails"] ?>"<?php }?> required>
</div>
</div>
</div>	

<div class="col-md-4" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="">Age</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="" placeholder="Enter Arabic Details" name="age" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["age"] ?>"<?php }?> >
</div>
</div>
</div>	

<div class="col-md-4" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="">Age Type</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<select class="form-control" name="ageType" >
	<?php
	 if(isset($_GET["edit"])){
		 if ($data[0]["ageType"] == 0){
			 $ageType = "Day";
		 }elseif($data[0]["ageType"] == 1){
			 $ageType = "Week";
		 }elseif($data[0]["ageType"] == 2){
			 $ageType = "Month";
		 }else{
			 $ageType = "Year";
		 }
		 echo "<option value='{$data[0]["ageType"]}'>{$ageType}</option>";
	 }
	 ?>
	<option value="0">Day</option>
	<option value="1">Week</option>
	<option value="2">Month</option>
	<option value="3">Year</option>
</select>
</div>
</div>
</div>

<div class="col-md-4" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="">Gender</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<select class="form-control" name="gender" >
	<?php
	 if(isset($_GET["edit"])){
		 if ($data[0]["filter"] == 0){
			 $filter = "Couple";
		 }elseif($data[0]["filter"] == 1){
			 $filter = "Male";
		 }elseif($data[0]["filter"] == 2){
			 $filter = "Female";
		 }else{
			 $filter = "Not Applicable";
		 }
		 echo "<option value='{$data[0]["filter"]}'>{$filter}</option>";
	 }
	 ?>
	<option value="0">Couple</option>
	<option value="1">Male</option>
	<option value="2">Female</option>
	<option value="3">Not Applicable</option>
</select>
</div>
</div>
</div>

<div class="col-md-4" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="">Category</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<select class="form-control" name="categoryId" >

	<?php
	if ( isset($_GET["edit"]) ){
		$category = selectDB("categories","`id` = '{$data[0]["categoryId"]}'");
		echo "<option value='{$category[0]["id"]}'>{$category[0]["enTitle"]}</option>";
		unset($category);
	}
	if ( $category = selectDB("categories","`status` = '0' AND `parentId` = '0' AND `vendorId` = '{$userId}' ORDER BY `type` ASC") ){ 
		for ($i = 0 ; $i < sizeof($category) ; $i++ ){
			$parent = selectDB("tags","`status` = '0' AND `id` = '{$category[$i]["type"]}'");
			echo "<option disabled value='{$category[$i]["id"]}' style='background-color:lightblue'>{$parent[0]["enTitle"]} - {$category[$i]["enTitle"]}</option>";
			if ($subs = selectDB("categories","`status` = '0' AND `parentId` = '{$category[$i]["id"]}'") ){
				for ($y = 0 ; $y < sizeof($subs) ; $y++ ){
					echo "<option value='{$subs[$y]["id"]}'>{$subs[$y]["enTitle"]}</option>";
				}
			}
		}
	}
	?>
</select>
</div>
</div>
</div>

<div class="col-md-3" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="">Brand</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<select class="form-control" name="brandId" >

	<?php
	if ( isset($_GET["edit"]) ){
		$brand = selectDB("brands","`id` = '{$data[0]["brandId"]}'");
		echo "<option value='{$brand[0]["id"]}'>{$brand[0]["enTitle"]}</option>";
		unset($brand);
	}
	if ($brand = selectDB("brands","`status` = '0' AND `vendorId` = '{$userId}' AND `id` != '{$data[0]["brandId"]}'") ){
		for ($i = 0 ; $i < sizeof($brand) ; $i++ ){
			echo "<option value='{$brand[$i]["id"]}'>{$brand[$i]["enTitle"]}</option>";
		}
	}
	?>
</select>
</div>
</div>
</div>

<div class="col-md-3"  style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="">Discount Type</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<select class="form-control" name="discountType" >
	<?php
	 if(isset($_GET["edit"])){
		 if ($data[0]["discountType"] == 0){
			 $discountType = "Percentage";
		 }else{
			 $discountType = "Amount";
		 }
		 echo "<option value='{$data[0]["discountType"]}'>{$discountType}</option>";
	 }
	 ?>
	<option value="0">Percentage</option>
	<option value="1">Amount</option>
</select>
</div>
</div>
</div>

<div class="col-md-3"  style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="">Discount</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" id="" placeholder="Enter Discount" name="discount" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["discount"] ?>"<?php }?> >
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="">Video</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="" placeholder="Enter Video URL" name="video" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["video"] ?>"<?php }?> >
</div>
</div>
</div>

<div class="col-md-3" id="shide" style="<?php echo $styleHidden ?>; display:none">
<div class="form-group">
<label class="control-label mb-10" for="">SKU</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="" placeholder="Enter SKU" name="sku" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["sku"] ?>"<?php }?> >
</div>
</div>
</div>

<div class="col-md-3" id="qhide" style="<?php echo $styleHidden ?>; display:none">
<div class="form-group">
<label class="control-label mb-10" for="">Quantity</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="number" class="form-control" id="" placeholder="Enter Quantity" name="quantity" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["quantity"] ?>"<?php }?> >
</div>
</div>
</div>

<div class="col-md-6" id="phide" style="<?php echo $styleHidden ?>">
<div class="form-group">
<label class="control-label mb-10" for="">Price</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" id="" placeholder="Enter Price" name="price" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["price"] ?>"<?php }?> >
</div>
</div>
</div>

<div class="col-md-3" id="chide" style="<?php echo $styleHidden ?>; display:none">
<div class="form-group">
<label class="control-label mb-10" for="">Cost</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" id="" placeholder="Enter Cost" name="cost" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["cost"] ?>"<?php }?> >
</div>
</div>
</div>

<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
<input type="hidden" name="date" value="<?php echo $date ?>">
<input type="hidden" name="shopId" value="<?php echo $_GET["id"] ?>">
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
$arrayOfTitles 	= array('Active Items','Inactive Items');
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
<th>English Title</th>
<th>Shop</th>
<th>Price</th>
<th>Video</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<?php
$sql = "SELECT *
		FROM `shopItems`
		WHERE
		`status` = '".$status[$i]."'
		AND
		`shopId` = '{$_GET["id"]}'
		";
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
	$shop = selectDB("shops","`id` = '{$row["shopId"]}'");
?>
<tr>
<td><?php echo substr($row["date"],0,11) ?></td>
<td><?php echo $row["enTitle"] ?></td>
<td><?php echo $shop[0]["enShop"] ?></td>
<td><?php echo $row["price"] ?>KD</td>
<td><?php if ( !empty($row["video"]) ){ echo '<a href="'.$row["video"].'" target="_blank">View</a>'; }else{ echo "None";} ?></td>
<td>

<a href="?page=shopItems&edit=1&id=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-edit"></i></a>

<a href="?page=shopItemImages&id=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-file-image-o"></i></a>

<?php /*<a href="?page=stars&id=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-star"></i></a> */ ?>

<?php
if ( $row["is_variant"] == 1 ){
	?>
	<a href="?page=variants&id=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-shopping-bag"></i></a>
	<?php
}
?>

<a href="?page=shopItems&id=<?php echo $_GET["id"] ?>&<?php echo $action[$i] . $row["id"] ?>" style="margin:3px"><i class="<?php echo $icon[$i] ?>"></i></a>

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