<?php
if ( isset($_COOKIE["ezyoVCreate"]) ){
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

if ( isset($_GET["done"]) ){
	$table = "complains";
	$where = "`id` LIKE '".$_GET["done"]."'";
	$data = array("status"=>"1");
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=complains";
	</script>
	<?php
}

if ( isset($_GET["return"]) ){
	$table = "complains";
	$where = "`id` LIKE '".$_GET["return"]."'";
	$data = array("status"=>"0");
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=complains";
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

<!-- Row -->
<?php

$status 		= array('0','1');
$arrayOfTitles 	= array('Active Complains','Finished Complains');
$myTable 		= array('myTable1','myTable2');
$panel 			= array('panel-default','panel-danger');
$textColor 		= array('txt-dark','txt-light');
$icon 			= array('fa fa-trash-o','fa fa-refresh');
$action			= array('done=','return=');
$actionText		= array('Done','Return');

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
<th>Username</th>
<th>Email</th>
<th>Mobile</th>
<th>Subject</th>
<th>Message</th>
<th>Actions</th>
</tr>
</thead>
<tbody>
<?php
$sql = "SELECT c.*, u.email, u.mobile, u.username
		FROM `complains` as c
		JOIN `user` as u
		ON u.id = c.userId
		WHERE
		c.status LIKE '".$status[$i]."'
		";
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
?>
<tr>
<td><?php echo substr($row["date"],0,11) ?></td>
<td><?php echo $row["username"] ?></td>
<td><a href="mailto:<?php echo $row["email"] ?>" target="_blank">Mail</a></td>
<td><a href="tel:<?php echo $row["mobile"] ?>" target="_blank">Call</a></td>
<td><?php echo $row["subject"] ?></td>
<td><?php echo $row["msg"] ?></td>
<td>
<a href="?page=complains&<?php echo $action[$i] . $row["id"] ?>" style="margin:3px" class="btn btn-default"><?php echo $actionText[$i] ?></a>
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