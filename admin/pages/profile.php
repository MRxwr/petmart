<?php
if ( isset($_GET["edit"]) ){
	$table = "vendors";
	$where = "`id` LIKE '".$userId."'";
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

	$table = "vendors";
	$where = "`id` LIKE '".$userId."'";
	unset($_POST["edit"]);
	$data1 = $_POST;
	updateDB($table,$data1,$where);
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
<h6 class="panel-title txt-dark">Vendor Details</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=profile&edit=1" method="post" enctype="multipart/form-data">

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Name</label>
<div class="input-group">
<div class="input-group-addon"><i class="icon-user"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Full Name" name="name" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["name"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">username</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-institution"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Enter username" name="username" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["username"] ?>"<?php }?> required>
</div>
</div>
</div>	

<div class="col-md-4">
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
<label class="control-label mb-10" for="exampleInputEmail_1">Email address</label>
<div class="input-group">
<div class="input-group-addon"><i class="icon-envelope-open"></i></div>
<input type="email" class="form-control" id="exampleInputEmail_1" placeholder="Enter email" name="email" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["email"] ?>"<?php }?>required>
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

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Upload Logo</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-upload"></i></div>
<input type="file" class="form-control" id="exampleInputEmail_1" placeholder="Enter phone" name="logo">
</div>
</div>
</div>	

<div class="col-md-6">
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