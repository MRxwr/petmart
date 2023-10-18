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

if ( isset($_POST["variantId"]) ){
	unset($_POST["submit"]);	
	for ( $i = 0 ; $i < sizeof($_POST["variantId"]) ; $i++ ){
		$data = array(
			"variantId" => $_POST["variantId"][$i],
			"itemId" => $_POST["itemId"],
			"sku" => $_POST["sku"][$i],
			"quantity" => $_POST["quantity"][$i],
			"cost" => $_POST["cost"][$i],
			"price" => $_POST["price"][$i],
			"enTitle" => $_POST["enTitle"][$i],
			"arTitle" => $_POST["arTitle"][$i]
		);
		$table = "item_variants";
		insertDB($table, $data);
	}
}

if ( isset($_GET["delete"]) ){
	$table = "item_variants";
	$data = array('status'=>'1');
	$where = "`id` LIKE '".$_GET["delete"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=variants&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
if ( isset($_GET["return"]) ){
	$table = "item_variants";
	$data = array('status'=>'0');
	$where = "`id` LIKE '".$_GET["return"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=variants&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
if ( isset($_GET["edit"]) ){
	$table = "item_variants";
	$where = "`id` LIKE '".$_GET["edit"]."'";
	$data = selectDB($table,$where);
}

if ( isset($_POST["edit"]) ){
	$table = "item_variants";
	$where = "`id` LIKE '".$_POST["edit"]."'";
	unset($_POST["edit"]);
	$data = $_POST;
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=variants&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
?>
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
<h6 class="panel-title txt-dark">Select Variants [ 0 wont be selected ] </h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<?php
$form = "";
if ( isset($_POST["next2"]) ){
	$url = "?page=variants";
	if ( isset($_GET["id"]) ){
		$url .= "&id={$_GET["id"]}";
	}
	$next = "next1";
	for ( $i = 0 ; $i < sizeof($_POST["attribute"]) ; $i++ ){
		$attributes = selectDB("attributes", "`id` LIKE '{$_POST["attribute"][$i]}'");
		for ( $y = 0 ; $y < $_POST["values"][$i] ; $y++ ){
			$form .= "
			<div class='col-md-6'>
				<div class='form-group'>
				<label class='control-label mb-10' for='exampleInputuname_1'>{$attributes[0]["enTitle"]} English {$y}</label>
				<div class='input-group'>
				<div class='input-group-addon'><i class='fa fa-file'></i></div>
				<input type='text' class='form-control' name='variants[]' value='' required>
				</div>
				</div>
			</div>
			<div class='col-md-6'>
				<div class='form-group'>
				<label class='control-label mb-10' for='exampleInputuname_1'>{$attributes[0]["enTitle"]} Arabic {$y}</label>
				<div class='input-group'>
				<div class='input-group-addon'><i class='fa fa-file'></i></div>
				<input type='text' class='form-control' name='variants[]' value='' required>
				</div>
				</div>
			</div>
			<input type='hidden' class='form-control' name='attribute[]' value='{$attributes[0]["id"]}' required>			
				";
		}
	}
}elseif( isset($_POST["next1"]) ){
	$next = "submit";
	$url = "?page=variants";
	if ( isset($_GET["id"]) ){
		$url .= "&id={$_GET["id"]}";
	}
	$y = 0;
	for ( $i = 0 ; $i < sizeof($_POST["attribute"]) ; $i++ ){
		$attributes = selectDB("attributes", "`id` LIKE '{$_POST["attribute"][$i]}'");
		$y = $y;
		$z = $y + 1;
		$data = array(
			"attributeId" 	=> $_POST["attribute"][$i],
			"itemId" 		=> $_POST["itemId"],
			"enTitle" 		=> $_POST["variants"][$y],
			"arTitle" 		=> $_POST["variants"][$z]
		);
		insertDB("item_attribute",$data);
		$y+=2;
	}
	$enTitle = array();
	$title = array();
	$arraySize = 1;
	$variant = selectDB("item_attribute", "`itemId` LIKE '{$_GET["id"]}' GROUP BY `attributeId`");
	for ( $i = 0 ; $i < sizeof($variant) ; $i++ ){
		$buildArray = selectDB("item_attribute", "`itemId` LIKE '{$_GET["id"]}' AND `attributeId` LIKE '{$variant[$i]["attributeId"]}'");
		$arraySize = $arraySize * sizeof($buildArray);
	}
	for ( $i = 0 ; $i < sizeof($variant) ; $i++ ){
		$buildArray = selectDB("item_attribute", "`itemId` LIKE '{$_GET["id"]}' AND `attributeId` LIKE '{$variant[$i]["attributeId"]}'");
		$loops = $arraySize / sizeof($buildArray);
		if ( ($arraySize / sizeof($buildArray)) == sizeof($buildArray)){
			for ($y = 0 ; $y < sizeof($buildArray) ; $y++ ){
				for ( $x = 0 ; $x < $loops ; $x++ ){
					if ( ($i%2) == 0 ){
						$r = $y; 
					}else{
						$r = $x;
					}
					$enTitle[] = $buildArray[$r]["enTitle"];
				}
			}	
		}else{
			for ($y = 0 ; $y < $loops ; $y++ ){
				for ( $x = 0 ; $x < sizeof($buildArray) ; $x++ ){
					if ( ($loops%2) == 0 ){
						$r = $y; 
					}else{
						$r = $x;
					}
					$enTitle[] = $buildArray[$x]["enTitle"];
				}
			}
		}
		for ($z = 0 ; $z < $arraySize ; $z++ ){
			$title[$z] = $enTitle[$z] . "-" . $title[$z];
		}
		unset($enTitle);
	}
	for ( $i = 0 ; $i < sizeof($title) ; $i++ ){
	$form .= "
		<div class='col-md-12'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>Variant ID</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='text' class='form-control' name='variantId[]' value='{$title[$i]}' readonly required>
			</div>
			</div>
		</div>
		
		<div class='col-md-4'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>English Title</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='text' class='form-control' name='enTitle[]' value='' required>
			</div>
			</div>
		</div>
		
		<div class='col-md-4'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>Arabic Title</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='text' class='form-control' name='arTitle[]' value='' required>
			</div>
			</div>
		</div>
		
		<div class='col-md-4'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>Quantity</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='number' class='form-control' name='quantity[]' value='0' required>
			</div>
			</div>
		</div>
		
		<div class='col-md-4'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>Cost</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='float' class='form-control' name='cost[]' value='0' required>
			</div>
			</div>
		</div>
		
		<div class='col-md-4'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>Price</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='float' class='form-control' name='price[]' value='0' required>
			</div>
			</div>
		</div>
		
		<div class='col-md-4'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>SKU</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='text' class='form-control' name='sku[]' value=''>
			</div>
			</div>
		</div>
			";
	}
}else{
	$url = "?page=variants";
	if ( isset($_GET["id"]) ){
		$url .= "&id={$_GET["id"]}";
	}
	$next = "next2";
	$attributes = selectDB("attributes", "`status` LIKE '0'");
	for ( $i = 0 ; $i < sizeof($attributes) ; $i++ ){
		$form .= "
		<div class='col-md-6'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>{$attributes[$i]["enTitle"]}</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='number' class='form-control' name='values[{$i}]' value='0' required>
			</div>
			</div>
		</div>
		<input type='hidden' class='form-control' name='attribute[{$i}]' value='{$attributes[$i]["id"]}' required>
			";
	}
}
?>

<form action="<?php echo $url ?>" method="post" enctype="multipart/form-data">

<?php 
echo $form;
?>

<div class="col-md-12" style="padding:10px">
<button type="submit" class="btn btn-success mr-10" >Next</button>
<input type="hidden" name="<?php echo $next ?>" value="1">
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
<th>Arabic Title</th>
<th>Quantity</th>
<th>Cost</th>
<th>Price</th>
<th>SKU</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<?php
$sql = "SELECT *
		FROM `item_variants`
		WHERE
		status = '".$status[$i]."'
		AND
		`itemId` LIKE '{$_GET["id"]}'
		";
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
?>
<tr>
<td><?php echo substr($row["date"],0,11) ?></td>
<td><?php echo $row["enTitle"] ?></td>
<td><?php echo $row["arTitle"] ?></td>
<td><?php echo $row["quantity"] ?></td>
<td><?php echo $row["cost"] ?>KD</td>
<td><?php echo $row["price"] ?>KD</td>
<td><?php echo $row["sku"] ?></td>
<td>

<a href="?page=variants&edit=<?php echo $row["id"] ?>&id=<?php echo $_GET["id"] ?>" style="margin:3px"><i class="fa fa-edit"></i></a>

<a href="?page=variants&id=<?php echo $_GET["id"] ?>&<?php echo $action[$i] . $row["id"] ?>" style="margin:3px"><i class="<?php echo $icon[$i] ?>"></i></a>

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
}else{
	?>
<div class="row">
<div class="col-md-12">
<div class="panel panel-default card-view">
<div class="panel-heading">
<div class="pull-left">
<h6 class="panel-title txt-dark">Edit Variant</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=variants&id=<?php echo $_GET["id"] ?>" method="post" enctype="multipart/form-data">

		<div class='col-md-4'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>English Title</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='text' class='form-control' name='enTitle' value='<?php echo $data[0]["enTitle"] ?>' required>
			</div>
			</div>
		</div>
		
		<div class='col-md-4'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>Arabic Title</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='text' class='form-control' name='arTitle' value='<?php echo $data[0]["arTitle"] ?>' required>
			</div>
			</div>
		</div>
		
		<div class='col-md-4'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>Quantity</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='number' class='form-control' name='quantity' value='<?php echo $data[0]["quantity"] ?>' required>
			</div>
			</div>
		</div>
		
		<div class='col-md-4'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>Cost</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='float' class='form-control' name='cost' value='<?php echo $data[0]["cost"] ?>' required>
			</div>
			</div>
		</div>
		
		<div class='col-md-4'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>Price</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='float' class='form-control' name='price' value='<?php echo $data[0]["price"] ?>' required>
			</div>
			</div>
		</div>
		
		<div class='col-md-4'>
			<div class='form-group'>
			<label class='control-label mb-10' for='exampleInputuname_1'>SKU</label>
			<div class='input-group'>
			<div class='input-group-addon'><i class='fa fa-file'></i></div>
			<input type='text' class='form-control' name='sku' value='<?php echo $data[0]["sku"] ?>'>
			</div>
			</div>
		</div>

<div class="col-md-12" style="padding:10px">
<button type="submit" class="btn btn-success mr-10" >Submit</button>
<input type="hidden" name="edit" value="<?php echo $_GET["edit"] ?>">
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