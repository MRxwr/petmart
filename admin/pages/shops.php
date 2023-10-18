<?php
if ( isset($_POST["arShop"]) && !isset($_POST["edit"]) ){
	if( is_uploaded_file($_FILES['header']['tmp_name']) ){
		@$ext = end((explode(".", $_FILES['header']['name'])));
		$directory = "logos/";
		$originalfile = $directory . md5(date("d-m-y").time().rand(111111,999999))."." . $ext;
		move_uploaded_file($_FILES["header"]["tmp_name"], $originalfile);
		$_POST["header"] = str_replace("logos/",'',$originalfile);
	}else{
		$_POST["header"] = "";
	}
	
	if( is_uploaded_file($_FILES['logo']['tmp_name']) ){
		@$ext = end((explode(".", $_FILES['logo']['name'])));
		$directory = "logos/";
		$originalfile = $directory . md5(date("d-m-y").time().rand(111111,999999))."." . $ext;
		move_uploaded_file($_FILES["logo"]["tmp_name"], $originalfile);
		$_POST["logo"] = str_replace("logos/",'',$originalfile);
	}else{
		$_POST["logo"] = "";
	}
	$table = "shops";
	$_POST["password"] = sha1($_POST["password"]);
	insertDB($table,$_POST);
}
if ( isset($_GET["delete"]) ){
	$table = "shops";
	$data = array('status'=>'1');
	$where = "`id` LIKE '".$_GET["delete"]."'";
	updateDB($table,$data,$where);
}
if ( isset($_GET["return"]) ){
	$table = "shops";
	$data = array('status'=>'0');
	$where = "`id` LIKE '".$_GET["return"]."'";
	updateDB($table,$data,$where);
}
if ( isset($_GET["edit"]) ){
	$table = "shops";
	$where = "`id` LIKE '".$_GET["id"]."'";
	$data = selectDB($table,$where);
}

if ( isset($_POST["edit"]) ){
	if( is_uploaded_file($_FILES['header']['tmp_name']) ){
		@$ext = end((explode(".", $_FILES['header']['name'])));
		$directory = "logos/";
		$originalfile = $directory . md5(date("d-m-y").time().rand(111111,999999))."." . $ext;
		move_uploaded_file($_FILES["header"]["tmp_name"], $originalfile);
		$_POST["header"] = str_replace("logos/",'',$originalfile);
	}else{
		unset($_POST["header"]);
	}
	
	if( is_uploaded_file($_FILES['logo']['tmp_name']) ){
		@$ext = end((explode(".", $_FILES['logo']['name'])));
		$directory = "logos/";
		$originalfile = $directory . md5(date("d-m-y").time().rand(111111,999999))."." . $ext;
		move_uploaded_file($_FILES["logo"]["tmp_name"], $originalfile);
		$_POST["logo"] = str_replace("logos/",'',$originalfile);
	}else{
		unset($_POST["logo"]);
	}
	
	if ( empty($_POST["password"]) ){
		unset($_POST["password"]);
	}else{
		$_POST["password"] = sha1($_POST["password"]);
	}

	$table = "shops";
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
<h6 class="panel-title txt-dark">Shop Details</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=shops" method="post" enctype="multipart/form-data">

<div class="col-md-4" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Name</label>
<div class="input-group">
<div class="input-group-addon"><i class="icon-user"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Full Name" name="name" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["name"] ?>"<?php }?> >
</div>
</div>
</div>

<div class="col-md-4" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">username</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-institution"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Enter username" name="username" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["username"] ?>"<?php }?> >
</div>
</div>
</div>	

<div class="col-md-4" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputpwd_1">password</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-lock"></i></div>
<input type="password" class="form-control" id="exampleInputpwd_1" placeholder="Enter password" name="password" >
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Shop Title English</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-header"></i></div>
<input type="text" class="form-control" id="exampleInputEmail_1" placeholder="Enter Title English" name="enShop" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["enShop"] ?>"<?php }?>required>
</div>
</div>
</div>

<div class="col-md-8">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Shop Details English</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-file-text-o"></i></div>
<input type="text" class="form-control" id="exampleInputEmail_1" placeholder="Enter Details English" name="enDetails" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["enDetails"] ?>"<?php }?>required>
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Shop Title Arabic</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-header"></i></div>
<input type="text" class="form-control" id="exampleInputEmail_1" placeholder="Enter Title Arabic" name="arShop" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["arShop"] ?>"<?php }?>required>
</div>
</div>
</div>

<div class="col-md-8">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Shop Details Arabic</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-file-text-o"></i></div>
<input type="text" class="form-control" id="exampleInputEmail_1" placeholder="Enter Details Arabic" name="arDetails" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["arDetails"] ?>"<?php }?>required>
</div>
</div>
</div>

<div class="col-md-3" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Email address</label>
<div class="input-group">
<div class="input-group-addon"><i class="icon-envelope-open"></i></div>
<input type="email" class="form-control" id="exampleInputEmail_1" placeholder="Enter email" name="email" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["email"] ?>"<?php }?>>
</div>
</div>
</div>	

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Mobile</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-phone"></i></div>
<input type="text" class="form-control" id="exampleInputEmail_1" placeholder="Enter phone" name="mobile" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["mobile"] ?>"<?php }?>required>
</div>
</div>
</div>	

<div class="col-md-3" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Supplier Code</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-phone"></i></div>
<input type="number" class="form-control" id="exampleInputEmail_1" placeholder="Enter supplier code" name="supplierCode" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["supplierCode"] ?>"<?php }?>>
</div>
</div>
</div>	

<div class="col-md-3" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">MyFatoorah Token</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-phone"></i></div>
<input type="text" class="form-control" id="exampleInputEmail_1" placeholder="Enter token" name="myFatoorahToken" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["myFatoorahToken"] ?>"<?php }?>>
</div>
</div>
</div>	

<div class="col-md-8" >
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Address</label>
<div class="input-group"> 
<div class="input-group-addon"><i class="fa fa-phone"></i></div>
<input type="text" class="form-control" id="exampleInputEmail_1" placeholder="Enter address" name="address" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["address"] ?>"<?php }?>>
</div>
</div>
</div>	

<div class="col-md-6" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Is Boothat ?</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-phone"></i></div>
<select name="is_boothat" class="form-control">
<?php
	if( isset($_GET["edit"]) ){
		if ( $data[0]["is_boothat"] == 0 ){
			$new = "Client";
		}else{
			$new = "Partner";
		}
		echo '<option value="'.$data[0]["is_boothat"].'">'.$new.'</option>';
	}
?>
	<option value="0">Client</option>
	<option value="1">Partner</option>
</select>
</div>
</div>
</div>	

<?php
/*
<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Delivery Time</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-clock-o"></i></div>
<input type="text" class="form-control" id="exampleInputEmail_1" placeholder="30 min" name="delivery" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["delivery"] ?>"<?php }?>required>
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Is new ?</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-phone"></i></div>
<select name="is_new" class="form-control">
<?php
	if( isset($_GET["edit"]) ){
		if ( $data[0]["is_new"] == 0 ){
			$new = "No";
		}else{
			$new = "Yes";
		}
		echo '<option value="'.$data[0]["is_new"].'">'.$new.'</option>';
	}
?>
	<option value="0">No</option>
	<option value="1">Yes</option>
</select>
</div>
</div>
</div>	

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Is Busy?</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-phone"></i></div>
<select name="is_busy" class="form-control">
<?php
	if( isset($_GET["edit"]) ){
		if ( $data[0]["is_busy"] == 0 ){
			$busy = "No";
		}else{
			$busy = "Yes";
		}
		echo '<option value="'.$data[0]["is_busy"].'">'.$busy.'</option>';
	}
?>
	<option value="0">No</option>
	<option value="1">Yes</option>
</select>
</div>
</div>
</div>
*/
?>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Upload Logo</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-upload"></i></div>
<input type="file" class="form-control" id="exampleInputEmail_1" placeholder="Enter phone" name="logo">
</div>
</div>
</div>	

<div class="col-md-6" >
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Upload Header</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-upload"></i></div>
<input type="file" class="form-control" id="exampleInputEmail_1" placeholder="Enter phone" name="header">
</div>
</div>
</div>		


<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
<input type="hidden" name="userId" value="<?php echo $userId ?>">
<input type="hidden" name="date" value="<?php echo $date ?>">
<input type="hidden" name="is_busy" value="0">
<input type="hidden" name="is_new" value="0">

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
$arrayOfTitles 	= array('Active Shops','Inactive Shops');
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
<th>Shop</th>
<th>Mobile</th>
<th>Logo</th>
<th>Added By</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<?php
$sql = "SELECT v.*, u.name as addedByName
		FROM `shops` as v
		JOIN `user` as u
		ON v.userId = u.id
		WHERE
		v.status = '".$status[$i]."'
		";
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
	if ( $row["type"] == 0 ){
		$role = "Administrator";
	}elseif( $row["type"] == 1 ) {
		$role = "Employee";
	}else{
		$role = "Driver";
	}
?>
<tr>
<td><?php echo substr($row["date"],0,11) ?></td>
<td><?php echo $row["enShop"] ?></td>
<td><a href="tel:<?php echo $row["mobile"] ?>">call</a></td>
<td>
<?php
if ( !empty($row["logo"]) ){
?>
<a href="logos/<?php echo $row["logo"] ?>" target="_blank">View</a>
<?php
}else{
	echo "None";
}
?>
</td>
<td><?php echo $row["addedByName"] ?></td>
<td>

<a href="?page=shops&edit=1&id=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-edit"></i></a>

<a href="?page=shopItems&id=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-tags"></i></a>

<?php /*<a href="?page=videoGallery&id=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-play "></i></a> */?>

<a href="?page=addFilter&id=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-filter "></i></a>

<a href="?page=shops&<?php echo $action[$i] . $row["id"] ?>" style="margin:3px"><i class="<?php echo $icon[$i] ?>"></i></a>

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