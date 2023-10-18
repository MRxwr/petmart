<div class="right-sidebar-backdrop"></div>

<!-- Main Content -->
<div class="page-wrapper">
	<div class="container-fluid pt-25">
		<!-- Row -->
		
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

<form action="" method="post" enctype="multipart/form-data">

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">From</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
<input type="date" class="form-control" name="from" required>
</div>
</div>
</div>

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">To</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
<input type="date" class="form-control" name="to" required>
</div>
</div>
</div>	

<div class="col-md-4">
<div class="form-group">
<label class="control-label mb-10" for="exampleInputuname_1">To</label>
<div class="input-group">
<div class="input-group-addon"><i class="fa fa-user"></i></div>
<select class="form-control" name="vendor" required>
<option value='0' selected>All</option>
<?php
$array = selectDB('vendors'," `status` != '5'");
for ($i = 0 ; $i < sizeof($array) ; $i++ ){
	echo '<option value="'.$array[$i]["id"].'" >'.$array[$i]["enShop"].'</option>';
}
?>
</select>
</div>
</div>
</div>			

<div class="col-md-12">
<button type="submit" class="btn btn-success mr-10">Submit</button>
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

	
<!-- /Title -->

<!-- Row -->
<?php
$status 		= array('0','1');
$arrayOfTitles 	= array('List Of Orders','Inactive Addresses');
$myTable 		= array('myTable1','myTable2');
$panel 			= array('panel-default','panel-danger');
$textColor 		= array('txt-dark','txt-light');
$icon 			= array('fa fa-trash-o','fa fa-refresh');
$action			= array('delete=','return=');

$btnArray = ['primary','default','warning','success','danger','info'];
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
<th>Vendor</th>
<th>Voucher</th>
<th>Method</th>
<th>Price</th>
<th>Mobile</th>
<th>Status</th>
</tr>
</thead> 
<tbody>
<?php
if ( isset($_POST["vendor"]) AND $_POST["vendor"] != 0 ){
	$sql = "SELECT o.*, c.name, v.code, ven.enShop, SUM(o.price) as TotalPrice
			FROM `orders` as o
			JOIN `customers` as c
			ON o.customerId = c.id
			JOIN `vendors` as ven
			ON o.vendorId = ven.id
			LEFT JOIN `vouchers` as v
			ON o.voucherId = v.id
			WHERE
			o.date BETWEEN '".$_POST["from"]."' AND '".$_POST["to"]."'
			AND
			o.vendorId LIKE '".$_POST["vendor"]."'
			AND
			o.status != '0'
			GROUP BY o.orderId
			";
}else{
	$sql = "SELECT o.*, c.name, v.code, ven.enShop, SUM(o.price) as TotalPrice
			FROM `orders` as o
			JOIN `customers` as c
			ON o.customerId = c.id
			JOIN `vendors` as ven
			ON o.vendorId = ven.id
			LEFT JOIN `vouchers` as v
			ON o.voucherId = v.id
			WHERE
			o.date BETWEEN '".$_POST["from"]."' AND '".$_POST["to"]."'
			AND
			o.status != '0'
			GROUP BY o.orderId
			";
}
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
	if ( $row["status"] == 1 ){
		$orderStatus = "Paid";
	}elseif( $row["status"] == 2 ){
		$orderStatus = "Preparing";
	}elseif( $row["status"] == 3 ){
		$orderStatus = "Out for delivery";
	}elseif( $row["status"] == 4 ){
		$orderStatus = "Delivered";
	}elseif( $row["status"] == 5 ){
		$orderStatus = "Canceled";
	}elseif( $row["status"] == 6 ){
		$orderStatus = "Refunded";
	}elseif( $row["status"] == 7 ){
		$orderStatus = "Failed";
	}
	
	if ( $row["paymentMethod"] == 1 ){
		$paymentMethod = "K-net";
	}elseif( $row["paymentMethod"] == 2 ){
		$paymentMethod = "Visa/Master";
	}else{
		$paymentMethod = "Cash";
	}
	$TotalPrice = $row["TotalPrice"];
?>
<tr>
<td><?php echo substr($row["date"],0,11) ?></td>
<td><a href="?page=orderView&id=<?php echo $row["orderId"] ?>" target="_blank"><?php echo $row["orderId"] ?></a></td>
<td><?php echo $row["name"] ?></td>
<td><?php echo $row["enShop"] ?></td>
<td><?php if ( !empty($row["code"]) ){ echo $row["code"]; }else{ echo "None";} ?></td>
<td><?php echo $paymentMethod ?></td>
<td><?php echo $row["price"] ?>KD</td>
<td><a href="tel:<?php echo $row["mobile"] ?>">Call</a></td>
<td>
<button class="btn btn-<?php echo $btnArray[$row["status"]-1] ?> btn-rounded btn-lable-wrap right-label btn-sm" style="width: 100%;"><span class="btn-text btn-sm"><?php echo $orderStatus ?></span> <span class="btn-label btn-sm"><i class="fa fa-<?php echo $iconArray[$row["status"]-1] ?>"></i> </span></button>
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