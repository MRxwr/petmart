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
	$table = "auctions";
	insertDB($table,$_POST);
	?>
	<script>
		window.location.href = "?page=auctions&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
if ( isset($_GET["delete"]) ){
	$table = "auctions";
	$data = array('status'=>'1');
	$where = "`id` LIKE '".$_GET["delete"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=auctions&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
if ( isset($_GET["return"]) ){
	$table = "auctions";
	$data = array('status'=>'0');
	$where = "`id` LIKE '".$_GET["return"]."'";
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=auctions&id=<?php echo $_GET['id'] ?>";
	</script>
	<?php
}
if ( isset($_GET["edit"]) ){
	$table = "auctions";
	$where = "`id` LIKE '".$_GET["edit"]."'";
	$data = selectDB($table,$where);

}
if ( isset($_POST["edit"]) ){
	$table = "auctions";
	$where = "`id` LIKE '".$_POST["edit"]."'";
	unset($_POST["edit"]);
	$data = $_POST;
	updateDB($table,$data,$where);
	?>
	<script>
		window.location.href = "?page=auctions&id=<?php echo $_GET['id'] ?>";
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

<!-- Row -->
<?php
if ( !isset($_GET["edit"]) ){
$status 		= array('0','1');
$arrayOfTitles 	= array('Active Auctions','Inactive Auctions');
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
<th>Owner</th>
<th>Highest Bidder</th>
<th>Price</th>
<th>Owner Rate</th>
<th>Winner Rate</th>
<th>Accept</th>
<?php 
if ( $i == 0 ){
	echo '<th>Actions</th>';
}
?>
</tr>
</thead>
<tbody>
<?php
$sql = "SELECT *
		FROM `auctions`
		WHERE
		status = '".$status[$i]."'
		";
$result = $dbconnect->query($sql);
while ( $row = $result->fetch_assoc() ){
	$winner = selectDB("customers","`id` = '{$row["winnerId"]}'");
	$owner = selectDB("customers","`id` = '{$row["customerId"]}'");
	if ( $row["accept"] == 1 ){
		$accept = "Yes";
	}else{
		$accept = "No";
	}
?>
<tr>
<td><?php echo substr($row["date"],0,11) ?></td>
<td><?php echo $row["enTitle"] ?></td>
<td><?php echo $row["arTitle"] ?></td>
<td><a href="index.php?page=users&edit=1&userId=<?php echo $owner[0]["id"]?>" target="_blank"><?php echo $owner[0]["name"] ?></a></td>
<td><a href="index.php?page=users&edit=1&userId=<?php echo $winner[0]["id"]?>" target="_blank"><?php echo $winner[0]["name"] ?></a></td>
<td><?php echo $row["reach"] ?></td>
<td><?php echo $row["rateOwner"] ?></td>
<td><?php echo $row["rateWinner"] ?></td>
<td><?php echo $accept ?></td>


<?php /*<a href="?page=auctions&edit=<?php echo $row["id"] ?>&id=<?php echo $row["vendorId"] ?>" style="margin:3px"><i class="fa fa-edit"></i></a> */

if ( $i == 0 ){
	echo "<td><a href='?page=auctions&id={$row["id"]}&{$action[$i]}{$row["id"]}' style='margin:3px'><i class='{$icon[$i]}'></i></a></td>";
}
?>


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