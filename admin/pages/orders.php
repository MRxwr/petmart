<?php
if( isset($_POST["points"]) && !empty($_POST["points"]) ){
	$user = selectDB("customers","`id` = '{$_POST["userId"]}'");
	$data = array(
		"packageId" => 0,
		"customerId" => $_POST["userId"],
		"orderId" => 0,
		"customerName" => $user[0]["name"],
		"cutomerNumber" => $user[0]["mobile"],
		"packageTitle" => "By Admin",
		"packagePoints" => $_POST["points"],
		"packageValidity" => $_POST["validity"],
		"packagePrice" => 0,
		"status" => 1
	);
	insertDB("order",$data);
	updateDB("customers",array( "points"=>($user[0]["points"]+$_POST["points"]), "validity"=>($user[0]["validity"]+$_POST["validity"]) ),"`id` = '{$_POST["userId"]}'");
	header("LOCATION: ?page=orders");
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
<h6 class="panel-title txt-dark">Add points</h6>
</div>
<div class="clearfix"></div>
</div>
<div class="panel-wrapper collapse in">
<div class="panel-body">
<div class="row">
<div class="col-sm-12 col-xs-12">
<div class="form-wrap">

<form action="?page=orders" method="post" enctype="multipart/form-data">

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputEmail_1">Select User</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-users"></i></div>
<select class="form-control" name="userId">
	<?php
	if( $users = selectDB("customers","`status` = '0' ORDER BY `name` ASC") ){
		for( $i = 0; $i < sizeof($users); $i++ ){
			echo "<option value='{$users[$i]["id"]}'>{$users[$i]["name"]}</option>";
		}
	}
	?>
</select>
</div>
</div>
</div>	

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="">Points</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-sort-numeric-desc"></i></div>
<input type="number" class="form-control" name="points" min='0'>
</div>
</div>
</div>	

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="">Validity</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
<input type="number" class="form-control" name="validity" min='0'>
</div>
</div>
</div>			

<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
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
$status 		= array('0','1');
$arrayOfTitles 	= array('List Of Orders','Inactive Addresses');
$myTable 		= array('myTable1','myTable2');
$panel 			= array('panel-default','panel-danger');
$textColor 		= array('txt-dark','txt-light');
$icon 			= array('fa fa-trash-o','fa fa-refresh');
$action			= array('delete=','return=');

$btnArray = ['danger','primary','warning','success','default','info'];
$iconArray = ['money','clock-o','car','check','times','refresh'];
$actions = array('btn'=>$btnArray, 'icon'=>$iconArray);
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
<th>Date/Time</th>
<th>Order</th>
<th>Customer</th>
<th>Package</th>
<th>Points</th>
<th>Validity</th>
<th>Price</th>
<th>Mobile</th>
<th>Status</th>
</tr>
</thead> 
<tbody>
<?php
$sql = "SELECT *
		FROM `order`
		";

$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
	if ( $row["status"] == 1 ){
		$orderStatus = "Paid";
	}else{
		$orderStatus = "Failed";
	}
?>
<tr>
<td><?php echo substr($row["date"],0,11) ?></td>
<td><?php echo $row["orderId"] ?></td>
<td><a href="index.php?page=users&edit=1&userId=<?php echo $row["customerId"]?>"  target="_blank"><?php echo $row["customerName"] ?></a></td>
<td><?php echo $row["packageTitle"] ?></td>
<td><?php echo $row["packagePoints"] ?></td>
<td><?php echo $row["packageValidity"] ?></td>
<td><?php echo $row["packagePrice"] ?></td>
<td><a href="tel:<?php echo $row["cutomerNumber"] ?>">Call</a></td>
<td>
<button class="btn btn-<?php echo $btnArray[$row["status"]] ?> btn-rounded btn-lable-wrap right-label btn-sm" style="width: 100%;"><span class="btn-text btn-sm"><?php echo $orderStatus ?></span> <span class="btn-label btn-sm"><i class="fa fa-<?php echo $iconArray[$row["status"]-1] ?>"></i> </span></button>
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