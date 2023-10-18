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

if ( isset($_POST["star"]) && !isset($_POST["edit"]) ){
	$stars = $_POST["star"];
	$stars = array_values($stars);
	unset($_POST["star"]);
	$table = "items_vendors";
	$sql = "DELETE FROM
			`items_vendors`
			WHERE
			`itemId` LIKE '{$_GET["id"]}'
			";
	$result = $dbconnect->query($sql);
	for ( $i = 0; $i < sizeof($stars) ;$i++ ){
		$_POST["vendorId"] = $stars[$i];
		insertDB($table,$_POST);
	}
	
	?>
	<script>
		window.location.href = "?page=stars&id=<?php echo $_GET['id'] ?>";
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
<h6 class="panel-title txt-dark">Select Stars</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=stars<?php if ( isset($_GET["id"]) ){echo "&id=".$_GET["id"];} ?>" method="post" enctype="multipart/form-data">

<?php
$stars = selectDB("vendors", "`status` LIKE '0'");
for ( $i = 0 ; $i < sizeof($stars) ; $i++ ){
	if ( selectDB("items_vendors", "`itemId` LIKE '{$_GET["id"]}' AND `vendorId` LIKE '{$stars[$i]["id"]}'") ){
		$checked = "checked";
	}else{
		$checked = "";
	}
	echo "
	<div class='col-md-3'>
		<div class='form-check'>
		  <input class='form-check-input' type='checkbox' value='{$stars[$i]["id"]}' name='star[{$i}]' {$checked}>
		  <label class='form-check-label'>
		  {$stars[$i]["enShop"]}
		  </label>
		</div>
	</div>
		";
}
?>
<div class="col-md-12" style="padding:10px">
<button type="submit" class="btn btn-success mr-10">Submit</button>
<input type="hidden" name="itemId" value="<?php echo $_GET["id"] ?>">
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