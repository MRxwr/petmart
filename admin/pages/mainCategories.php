<?php
if ( isset($_COOKIE["ezyoVCreate"]) AND !isset($_GET["edit"]) ){
	$array = selectDB('vendors', " `id` LIKE '".$_GET["id"]."'");
	if ( $array[0]["id"] != $_GET["id"] ){
		?>
	<script>
		window.location.href = "?page=logout";
	</script>
	<?php
	}
}
if ( isset($_COOKIE["ezyoVCreate"]) AND isset($_GET["edit"]) ){
	$array = selectDB('categories', " `id` LIKE '".$_GET["id"]."'");
	$array1 = selectDB('vendors', " `id` LIKE '".$array[0]["vendorId"]."'");
	if ( $array1[0]["id"] != $userId ){
		?>
	<script>
		window.location.href = "?page=logout";
	</script>
	<?php
	}
}
if ( isset($_POST["enTitle"]) && !isset($_POST["edit"]) ){
	if( is_uploaded_file($_FILES['logo']['tmp_name']) ){
		@$ext = end((explode(".", $_FILES['logo']['name'])));
		$directory = "logos/";
		$originalfile = $directory . md5(date("d-m-y").time().rand(111111,999999))."." . $ext;
		move_uploaded_file($_FILES["logo"]["tmp_name"], $originalfile);
		$_POST["logo"] = str_replace("logos/",'',$originalfile);
	}else{
		$_POST["logo"] = "";
	}
	$table = "categories";
	insertDB($table,$_POST);
	?>
	<script>
		window.location.href = "?page=mainCategories";
	</script>
	<?php
}
if ( isset($_GET["delete"]) ){
	$table = "categories";
	$data = array('status'=>'1');
	$where = "`id` LIKE '".$_GET["delete"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=mainCategories";
	</script>
	<?php
}
if ( isset($_GET["return"]) ){
	$table = "categories";
	$data = array('status'=>'0');
	$where = "`id` LIKE '".$_GET["return"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=mainCategories";
	</script>
	<?php
}
if ( isset($_GET["edit"]) ){
	$table = "categories";
	$where = "`id` LIKE '".$_GET["edit"]."'";
	$data = selectDB($table,$where);

}
if ( isset($_POST["edit"]) ){
	if( is_uploaded_file($_FILES['logo']['tmp_name']) ){
		@$ext = end((explode(".", $_FILES['logo']['name'])));
		$directory = "logos/";
		$originalfile = $directory . md5(date("d-m-y").time().rand(111111,999999))."." . $ext;
		move_uploaded_file($_FILES["logo"]["tmp_name"], $originalfile);
		$_POST["logo"] = str_replace("logos/",'',$originalfile);
	}else{
		unset($_POST["logo"]);
	}
	$table = "categories";
	$where = "`id` LIKE '".$_POST["edit"]."'";
	unset($_POST["edit"]);
	$data = $_POST;
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=mainCategories";
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
<h6 class="panel-title txt-dark">Category Details</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=mainCategories&id=<?php echo $_GET["id"] ?>" method="post" enctype="multipart/form-data">

<div class="col-md-6 " style="display:block">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1"><?php echo direction("Type","الصنف") ?></label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<select class="form-control" name="type">
	<?php
	if(isset($_GET["edit"]) ){
		$selectedType = selectDB('tags',"`status` = '0' AND `id` = {$data[0]["type"]}");
		$type = direction($selectedType[0]["enTitle"],$selectedType[0]["arTitle"]);
		echo "<option selected value='{$data[0]["type"]}'>{$type}</option>";
	}
	if ( $listTags = selectDB('tags',"`status` = '0' AND `id` != '{$data[0]["type"]}'") ){
		for( $i = 0; $i < sizeof($listTags) ; $i++){
			$tag = direction($listTags[$i]["enTitle"],$listTags[$i]["arTitle"]);
			echo "<option value='{$listTags[$i]["id"]}'>{$tag}</option>";
		}
	}
	?>
</select> 
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1"><?php echo direction("Parent","القسم الرئيسي") ?></label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<select class="form-control" name="parentId">
	<?php
	if(isset($_GET["edit"]) && $data[0]["parentId"] != 0){
		$selectedCat = selectDB('categories',"`id` LIKE '{$data[0]["parentId"]}'");
		echo '<option selected value="'.$data[0]["parentId"].'">'.$selectedCat[0]["enTitle"].'</option>';
	}else{
		echo '<option selected value="0">Main</option>';
	}
	if ( $listCategories = selectDB('categories',"`status` = '0' AND `parentId` = '0' AND `vendorId` = '1' AND `id` != '{$data[0]["categoryId"]}' ORDER BY `type` ASC, `enTitle` ASC") ){
		for( $i = 0; $i < sizeof($listCategories) ; $i++){
			$categoryType = selectDB('tags',"`status` = '0' AND `id` = {$listCategories[$i]["type"]}");
			$catType = direction($categoryType[0]["enTitle"],$categoryType[0]["arTitle"]);
			$categoryTitle = direction($listCategories[$i]["enTitle"],$listCategories[$i]["arTitle"]);
			$categoryTitleWithType = $catType . "-" . $categoryTitle;
			echo "<option value='{$listCategories[$i]["id"]}'>{$categoryTitleWithType}</option>";
		}
	}
	?>
</select> 
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1"><?php echo direction("English","الإنجليزية") ?></label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Full Name" name="enTitle" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["enTitle"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1"><?php echo direction("Arabic","العربية") ?></label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Enter username" name="arTitle" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["arTitle"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1"><?php echo direction("Logo","شعار") ?></label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-upload"></i></div>
<input type="file" class="form-control" name="logo" >
</div>
</div>
</div>		

<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10"><?php echo direction("Submit","أرسل") ?></button>
<input type="hidden" name="vendorId" value="1">
<input type="hidden" name="date" value="<?php echo $date ?>">
<?php if(isset($_GET["edit"])){?>
<input type="hidden" name="edit" value="<?php echo $_GET["edit"] ?>">
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
$arrayOfTitles 	= array('Active Categories','Inactive Categories');
$myTable 		= array('myTable1','myTable2');
$panel 			= array('panel-default','panel-danger');
$textColor 		= array('txt-dark','txt-light');
$icon 			= array('fa fa-trash-o','fa fa-refresh');
$action			= array('delete=','return=');
$z = 1;
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
<th><?php echo direction("#","#") ?></th>
<?php /* <th><?php echo direction("Date","االتاريخ") ?></th> */ ?>
<th><?php echo direction("Type","الصنف") ?></th>
<th><?php echo direction("Parent","الرئيسي") ?></th>
<th><?php echo direction("English","الإنجليزية") ?></th>
<th><?php echo direction("Arabic","العربية") ?></th>
<th><?php echo direction("Logo","الشعار") ?></th>
<th><?php echo direction("Actions","الأدوات") ?></th>
</tr>
</thead>
<tbody>
<?php
$oldType = 0;
$sql = "SELECT *
		FROM `categories`
		WHERE
		`status` = '".$status[$i]."'
		AND
		`parentId` = '0'
		ORDER BY `type` ASC
		";
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
	$saveType = $row["type"];
	if( $saveType != $oldType ){
		$counter = $counter + 1;
		$z = 1;
	}else{
		$counter = 1;
	}
	$listType = selectDB('tags',"`status` = '0' AND `id` = {$row["type"]}");
	$viewType = direction($listType[0]["enTitle"],$listType[0]["arTitle"]);
?>
	<tr>
	<td><span style="font-weight:700;color:darkblue"><?php echo $counter . "-" . $z ?></span></td>
	<?php  /*<td><?php echo substr($row["date"],0,11) ?></td> */?>
	<td><?php echo $viewType ?></td>
	<td><?php echo "None" ?></td>
	<td><?php echo $row["enTitle"] ?></td>
	<td><?php echo $row["arTitle"] ?></td>
	<td><img src="logos/<?php echo $row["logo"] ?>" style="width:150px;height:50px"></td>
	<td>

	<a href="?page=mainCategories&edit=<?php echo $row["id"] ?>&id=<?php echo $row["vendorId"] ?>" style="margin:3px"><i class="fa fa-edit"></i></a>

	<a href="?page=mainCategories&id=<?php echo $_GET["id"] ?>&<?php echo $action[$i] . $row["id"] ?>" style="margin:3px"><i class="<?php echo $icon[$i] ?>"></i></a>

	</td>
	</tr>
<?php
	if ( $selectedCat = selectDB('categories',"`parentId` = '{$row["id"]}' AND `status` = '0'") ){
		$x = 1;
		for ( $y = 0 ; $y < sizeof($selectedCat) ; $y++ ){
		?>
		<tr>
		<td><?php echo $counter . "-" . $z.$x ?></td>
		<?php  /*<td><?php echo substr($selectedCat[$y]["date"],0,11) ?></td> */ ?>
		<td><?php echo $viewType ?></td> 
		<td><?php echo $row["enTitle"] ?></td>
		<td><?php echo $selectedCat[$y]["enTitle"] ?></td>
		<td><?php echo $selectedCat[$y]["arTitle"] ?></td>
		<td><img src="logos/<?php echo $selectedCat[$y]["logo"] ?>" style="width:150px;height:50px"></td>
		<td>

		<a href="?page=mainCategories&edit=<?php echo $selectedCat[$y]["id"] ?>&id=<?php echo $selectedCat[$y]["vendorId"] ?>" style="margin:3px"><i class="fa fa-edit"></i></a>

		<a href="?page=mainCategories&id=<?php echo $_GET["id"] ?>&<?php echo $action[$i] . $selectedCat[$y]["id"] ?>" style="margin:3px"><i class="<?php echo $icon[$i] ?>"></i></a>

		</td>
		</tr>
		<?php
			$x++;
		}
	}
	$z++;
	$oldType = $saveType;
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