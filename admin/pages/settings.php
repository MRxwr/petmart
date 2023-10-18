<?php
if ( isset($_GET["edit"]) ){
	$table = "settings";
	$where = "`id` LIKE '1'";
	$data = selectDB($table,$where);
}else{
	die();
}

if ( isset($_POST["edit"]) ){
	$table = "settings";
	$where = "`id` LIKE '1'";
	unset($_POST["edit"]);
	$_POST["enPolicy"] = mysqli_real_escape_string($dbconnect, $_POST["enPolicy"]);
	$_POST["arPolicy"] = mysqli_real_escape_string($dbconnect, $_POST["arPolicy"]);
	$_POST["enTerms"] = mysqli_real_escape_string($dbconnect, $_POST["enTerms"]);
	$_POST["arTerms"] = mysqli_real_escape_string($dbconnect, $_POST["arTerms"]);
	$_POST["enAbout"] = mysqli_real_escape_string($dbconnect, $_POST["enAbout"]);
	$_POST["arAbout"] = mysqli_real_escape_string($dbconnect, $_POST["arAbout"]);
	$data = $_POST;
	updateDB($table,$data,$where);
	$data = selectDB($table,$where);
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
<h6 class="panel-title txt-dark">Settings</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=settings&edit=1" method="post" enctype="multipart/form-data">

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Email</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" id="exampleInputuname_1" placeholder="Email" name="email" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["email"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Call</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="float" class="form-control" id="exampleInputuname_1" placeholder="Phone to call" name="call" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["call"] ?>"<?php }?> required>
</div>
</div>
</div>	

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">WhatsApp</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="WhatsApp Nunber" name="whatsapp" <?php if(isset($_GET["edit"])){?>value="<?php echo $data[0]["whatsapp"] ?>"<?php }?> required>
</div>
</div>
</div>

<div class="col-md-2" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Maintenance</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-upload"></i></div>
<select class="form-control" name="is_live">
	<?php
	if ( $data[0]["is_live"] == "0"){
		echo '<option value="0">No</option>';
	}else{
		echo '<option value="1">Yes</option>';
	}
	?>
	<option value="0">No</option>
	<option value="1">Yes</option>
</select>
</div>
</div>
</div>

<div class="col-md-2" style="display:none">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Hide socialmedia</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-upload"></i></div>
<select class="form-control" name="hideSocial">
	<?php
	if ( $data[0]["hideSocial"] == "0"){
		echo '<option value="0">No</option>';
	}else{
		echo '<option value="1">Yes</option>';
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
<label class="control-label mb-10" for="exampleInputuname_1">Privacy Policy English</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<textarea class="form-control" name="enPolicy" ><?php if(isset($_GET["edit"])){ echo $data[0]["enPolicy"]; }?></textarea>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Privacy Policy Arabic</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<textarea class="form-control" name="arPolicy" ><?php if(isset($_GET["edit"])){ echo $data[0]["arPolicy"]; }?></textarea>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Terms & conditions English</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<textarea class="form-control" name="enTerms" ><?php if(isset($_GET["edit"])){ echo $data[0]["enTerms"]; }?></textarea>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Terms & conditions Arabic</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<textarea class="form-control" name="arTerms" ><?php if(isset($_GET["edit"])){ echo $data[0]["arTerms"]; }?></textarea>
</div>
</div>
</div>

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">About us English</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<textarea class="form-control" name="enAbout" ><?php if(isset($_GET["edit"])){ echo $data[0]["enAbout"]; }?></textarea>
</div>
</div>
</div>	

<div class="col-md-6">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">About us Arabic</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-text-width"></i></div>
<textarea class="form-control" name="arAbout" ><?php if(isset($_GET["edit"])){ echo $data[0]["arAbout"]; }?></textarea>
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