<?php
if ( isset($_POST["name"]) && !isset($_POST["edit"]) ){
	$table = "user";
	$_POST["password"] = sha1($_POST["password"]);
	insertDB($table,$_POST);
}
if ( isset($_GET["delete"]) ){
	$table = "user";
	$data = array('status'=>'1');
	$where = "`id` LIKE '".$_GET["delete"]."'";
	updateDB($table,$data,$where);
}
if ( isset($_GET["return"]) ){
	$table = "user";
	$data = array('status'=>'0');
	$where = "`id` LIKE '".$_GET["return"]."'";
	updateDB($table,$data,$where);
}
if ( isset($_GET["edit"]) ){
	$table = "user";
	$where = "`id` LIKE '".$_GET["employeeId"]."'";
	$data = selectDB($table,$where);
}

if ( isset($_POST["edit"]) ){
	$table = "user";
	$where = "`id` LIKE '".$_POST["edit"]."'";
	if ( !empty($_POST["password"]) ){
		$_POST["password"] = sha1($_POST["password"]);
	}else{
		unset($_POST["password"]);
	}
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
<h6 class="panel-title txt-dark">Employee Details</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=employees" method="post" enctype="multipart/form-data">

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">Name</label>
<div class="input-group">
<div class="input-group-addon"><i class="icon-user"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Full Name" name="name" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["name"].'"'; } ?> >
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">username</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-institution"></i></div>
<input type="text" class="form-control" id="exampleInputuname_1" placeholder="Enter username" name="username" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["username"].'"'; } ?> >
</div>
</div>
</div>	

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputpwd_1">password</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-lock"></i></div>
<input type="password" class="form-control" id="exampleInputpwd_1" placeholder="Enter password" name="password">
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Email address</label>
<div class="input-group">
<div class="input-group-addon"><i class="icon-envelope-open"></i></div>
<input type="email" class="form-control" id="exampleInputEmail_1" placeholder="Enter email" name="email" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["email"].'"'; } ?> >
</div>
</div>
</div>	

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Mobile</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-phone"></i></div>
<input type="text" class="form-control" id="exampleInputEmail_1" placeholder="Enter phone" name="mobile" <?php if(isset($_GET["edit"])){ echo 'value="'.$data[0]["mobile"].'"'; } ?> >
</div>
</div>
</div>		

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Role</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-user-md"></i></div>
<select class="form-control" name="type" required>
<?php
	if( isset($_GET["edit"]) ){
		$jobs = ['Administrator','Employee','Driver'];
		$jobId = ['0','1','2'];
		
		for( $i = 0 ; $i < 3 ; $i++ ){
			if ($jobId[$i] == $data[0]["type"] ){
				$isSelected = "selected";
			}else{
				$isSelected = "";
			}
			echo '<option '.$isSelected.' value="'.$jobId[$i].'" >'.$jobs[$i].'</option>';
		}
	}else{
?>
	<option selected value="1" >Employee</option>
	<option value="2" >Driver</option>
	<option value="0" >Administrator</option>
<?php
}
?>
</select>
</div>
</div>
</div>	

<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
<input type="hidden" name="userId" value="<?php echo $userId ?>">
<input type="hidden" name="date" value="<?php echo $date ?>">
<?php
if ( isset($_GET["edit"]) ){
?>
	<input type="hidden" name="edit" value="<?php echo $_GET["employeeId"] ?>">
<?php
}
?>

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
$status 		= array('0','1');
$arrayOfTitles 	= array('Current Employees','Released Employees');
$myTable 		= array('myTable1','myTable2');
$panel 			= array('panel-default','panel-danger');
$textColor 		= array('txt-dark','txt-light');
$icon 			= array('fa fa-trash-o','fa fa-refresh');
$action			= array('delete=','return=');

for($i = 0; $i < 2 ; $i++ ){
	if ( !isset($_GET["edit"]) ){
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
<th>Username</th>
<th>Name</th>
<th>Email</th>
<th>Mobile</th>
<th>Role</th>
<th>Added By</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<?php
$sql = "SELECT u.*, a.name as addedByName
		FROM `user` as u
		JOIN `user` as a
		WHERE
		u.status = '".$status[$i]."'
		GROUP BY u.id
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
<td><?php echo $row["username"] ?></td>
<td><?php echo $row["name"] ?></td>
<td><a href="mailto:<?php echo $row["email"] ?>">Email</a></td>
<td><a href="tel:<?php echo $row["mobile"] ?>">call</a></td>
<td><?php echo $role ?></td>
<td><?php echo $row["addedByName"] ?></td>
<td>

<a href="?page=employees&edit=1&employeeId=<?php echo $row["id"] ?>" style="margin:3px"><i class="fa fa-edit"></i></a>

<a href="?page=employees&<?php echo $action[$i] . $row["id"] ?>" style="margin:3px"><i class="<?php echo $icon[$i] ?>"></i></a>

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