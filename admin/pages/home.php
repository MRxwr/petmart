<style>
.centered {
    position: absolute;
    top: 13px;
    left: 50%;
    transform: translate(-50%, -50%);
    color: white;
    background-color: #135fad;
}
.centered1 {
    position: absolute;
    top: 13px;
    left: 50%;
    transform: translate(-50%, -50%);
    color: white;
    background-color: #2853a8;
}
.centered2 {
    position: absolute;
    top: 131px;
    left: 52%;
    min-height: 25px;
    transform: translate(-50%, -50%);
    color: black;
    background-color: #ffffff;
}
@media only screen and (max-width: 600px) {
	.centered2 {
		position: absolute;
		top: 118px;
		left: 52%;
		min-height: 25px;
		transform: translate(0%, 0%);
		color: black;
		background-color: #ffffff;
	}
}
.tabHead{
	padding: 15px;
    color: black;
    font-weight: 700;
    font-size: 16px;
	width: 100%;
    background-color: #f2f2f2;
}
.card-view.panel .panel-body {
    padding: 0px 0 0px;
}
.card-view{
	padding: 0px 15px 0;
}
.statsHeading{
	background-color: #f2f2f2;
	font-size:22px;
	font-weight:700;
	border-radius: 10px;
    margin-bottom: 10px;
}
</style>
<div class="right-sidebar-backdrop"></div>

<!-- Main Content -->
<div class="page-wrapper">
	<div class="container-fluid pt-25">
		<!-- Row -->
		<div class="row" style="padding:16px">
			<div class="col-12">
			Welcome To PetMart 2.0 Admin Panel
			</div>
		</div>
		<div class="row">
		
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center statsHeading">Earnings</div>
			
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $items = selectDataDB("SUM(packagePrice) as total","order","`status` = '1' AND DATE(date) = '" . date("Y-m-d") . "'") ){
						$totalItems = $items[0]["total"];
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $totalItems ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Daily") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-money txt-success data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $items = selectDataDB("SUM(packagePrice) as total","order","`status` = '1' AND DATE(date) BETWEEN '" . date('Y-m-d', strtotime('-7 days')) . "' AND '" . date("Y-m-d") . "'" ) ){
						$totalItems = $items[0]["total"];
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $totalItems ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Weekly") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-money txt-success data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $items = selectDataDB("SUM(packagePrice) as total","order","`status` = '1' AND DATE(date) BETWEEN '" . date('Y-m-d', strtotime('-30 days')) . "' AND '" . date("Y-m-d") . "'" ) ){
						$totalItems = $items[0]["total"];
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $totalItems ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Monthly") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-money txt-success data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $items = selectDataDB("SUM(packagePrice) as total","order","`status` = '1' AND DATE(date) BETWEEN '" . date('Y-m-d', strtotime('-365 days')) . "' AND '" . date("Y-m-d") . "'" ) ){
						$totalItems = $items[0]["total"];
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $totalItems ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Annually") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-money txt-success data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center statsHeading">Payments</div>
			<div class="row">
				<div class="col-lg-6">
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center statsHeading">Online</div>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-default card-view pa-0">
						<div class="panel-wrapper collapse in">
						<div class="panel-body pa-0">
						<div class="sm-data-box">
						<div class="container-fluid">
						<div class="row">
						<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
							<?php
							if( $online = selectDB("order","`status` = '1' AND `packageTitle` NOT LIKE '%by admin%'") ){
								$onlinePayments = sizeof($online);
							}else{
								$onlinePayments = 0;
							}
							?>					
							<span class="txt-dark block counter"><span class="counter-anim"><?php echo $onlinePayments ?></span></span>
							<span class="weight-500 uppercase-font block"><?php echo strtoupper("Paid") ?></span>
																		
						</div>
						<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
						<i class="fa fa-globe txt-success data-right-rep-icon "></i>
						</div>
						</div>	
						</div>
						</div>
						</div>
						</div>
						</div>
					</div>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-default card-view">
						<div class="panel-wrapper collapse in">
						<div class="panel-body row">
						<div class="table-wrap">
						<div class="table-responsive">
						<table id="myTable" class="table table-hover display  pb-30" >
						<label class="tabHead"><?php echo direction("Latest Orders","أخر العمليات") ?>
						</label>
						<thead>
						<tr>
						<th>Date</th>
						<th>Package</th>
						<th>Customer</th>
						<th>Mobile</th>
						<th>Price</th>
						</tr>
						</thead>
						<tbody>
						<?php
						if($ordersOnline = selectDB("order","`status` = '1' AND `packageTitle` NOT LIKE '%by admin%'ORDER BY `date` DESC LIMIT 5")){
						for ( $i = 0 ; $i < sizeof($ordersOnline) ; $i++){
						?>
						<tr>
						<td><?php echo substr($ordersOnline[$i]["date"],0,11); ?></td>
						<td><?php echo $ordersOnline[$i]["packageTitle"] ?></td>
						<td><?php echo substr($ordersOnline[$i]["customerName"],0,13) ?></td>
						<td><?php echo $ordersOnline[$i]["cutomerNumber"] ?></td>
						<td><?php echo ($ordersOnline[$i]["packagePrice"]) . "KD" ?></td>
						</tr>
						<?php }
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
				<div class="col-lg-6">
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center statsHeading">By Admin</div>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-default card-view pa-0">
						<div class="panel-wrapper collapse in">
						<div class="panel-body pa-0">
						<div class="sm-data-box">
						<div class="container-fluid">
						<div class="row">
						<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
							<?php
							if( $online = selectDB("order","`status` = '1' AND `packageTitle` LIKE '%by admin%'") ){
								$onlinePayments = sizeof($online);
							}else{
								$onlinePayments = 0;
							}
							?>					
							<span class="txt-dark block counter"><span class="counter-anim"><?php echo $onlinePayments ?></span></span>
							<span class="weight-500 uppercase-font block"><?php echo strtoupper("Paid") ?></span>
																		
						</div>
						<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
						<i class="fa fa-user txt-primary data-right-rep-icon "></i>
						</div>
						</div>	
						</div>
						</div>
						</div>
						</div>
						</div>
					</div>
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="panel panel-default card-view">
						<div class="panel-wrapper collapse in">
						<div class="panel-body row">
						<div class="table-wrap">
						<div class="table-responsive">
						<table id="myTable" class="table table-hover display  pb-30" >
						<label class="tabHead"><?php echo direction("Latest Orders","أخر العمليات") ?>
						</label>
						<thead>
						<tr>
						<th>Date</th>
						<th>Package</th>
						<th>Customer</th>
						<th>Mobile</th>
						<th>Price</th>
						</tr>
						</thead>
						<tbody>
						<?php
						if($ordersOnline = selectDB("order","`status` = '1' AND `packageTitle` LIKE '%by admin%'ORDER BY `date` DESC LIMIT 5")){
						for ( $i = 0 ; $i < sizeof($ordersOnline) ; $i++){
						?>
						<tr>
						<td><?php echo substr($ordersOnline[$i]["date"],0,11); ?></td>
						<td><?php echo $ordersOnline[$i]["packageTitle"] ?></td>
						<td><?php echo substr($ordersOnline[$i]["customerName"],0,13) ?></td>
						<td><?php echo $ordersOnline[$i]["cutomerNumber"] ?></td>
						<td><?php echo ($ordersOnline[$i]["packagePrice"]) . "KD" ?></td>
						</tr>
						<?php }
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
			</div>
		
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center statsHeading">Users</div>
			
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $android = selectDB("customers","`deviceType` LIKE '%android%'") ){
						$androidUsers = sizeof($android);
					}else{
						$androidUsers = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $androidUsers ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("android") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-android txt-success data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $ios = selectDB("customers","`deviceType` LIKE '%ios%'") ){
						$iosUsers = sizeof($ios);
					}else{
						$iosUsers = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $iosUsers ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("IOS") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-apple data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $active = selectDB("customers","`status` = '0'") ){
						$activeUsers = sizeof($active);
					}else{
						$activeUsers = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $activeUsers ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Active Users") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-users txt-primary data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-3 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $inActive = selectDB("customers","`status` != '0'") ){
						$inActiveUsers = sizeof($inActive);
					}else{
						$inActiveUsers = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $inActiveUsers ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Inactive Users") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-users txt-danger data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center statsHeading">Auctions</div>
			
			<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $auctions = selectDB("auctions","`status` != '0'") ){
						$allAuctions = sizeof($auctions);
					}else{
						$allAuctions = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $allAuctions ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("All Auctions") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-bars data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $auctions = selectDB("auctions","`status` = '1'") ){
						$successAuctions = sizeof($auctions);
					}else{
						$successAuctions = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $successAuctions ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Successful") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-check txt-success data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $auctions = selectDB("auctions","`status` = '2'") ){
						$failAuctions = sizeof($auctions);
					}else{
						$failAuctions = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $failAuctions ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Failed") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-times txt-danger data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center statsHeading">Posts</div>
			
			<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $items = selectDB("items","`type` = '1'") ){
						$totalItems = sizeof($items);
					}else{
						$totalItems = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $totalItems ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Total Posts") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-bullhorn data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $items = selectDB("items","`type` = '2'") ){
						$totalItems = sizeof($items);
					}else{
						$totalItems = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $totalItems ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Total Losts") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-question-circle data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $items = selectDB("items","`type` = '3'") ){
						$totalItems = sizeof($items);
					}else{
						$totalItems = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $totalItems ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Total Adoptions") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-comments-o data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $items = selectDB("items","`type` = '1' AND `status` = '0'") ){
						$totalItems = sizeof($items);
					}else{
						$totalItems = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $totalItems ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Active Posts") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-bullhorn txt-success data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $items = selectDB("items","`type` = '2' AND `status` = '0'") ){
						$totalItems = sizeof($items);
					}else{
						$totalItems = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $totalItems ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Active Losts") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-question-circle txt-success data-right-rep-icon "></i>
				</div>
				</div>	
				</div>
				</div>
				</div>
				</div>
				</div>
			</div>
			
			<div class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
				<div class="panel panel-default card-view pa-0">
				<div class="panel-wrapper collapse in">
				<div class="panel-body pa-0">
				<div class="sm-data-box">
				<div class="container-fluid">
				<div class="row">
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-left">
					<?php
					if( $items = selectDB("items","`type` = '3' AND `status` = '0'") ){
						$totalItems = sizeof($items);
					}else{
						$totalItems = 0;
					}
					?>					
					<span class="txt-dark block counter"><span class="counter-anim"><?php echo $totalItems ?></span></span>
					<span class="weight-500 uppercase-font block"><?php echo strtoupper("Active Adoptions") ?></span>
																
				</div>
				<div class="col-xs-6 text-center pl-0 pr-0 data-wrap-right">
				<i class="fa fa-comments-o txt-success data-right-rep-icon "></i>
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
				<p>2022 &copy; Create Co.</p>
			</div>
		</div>
	</footer>
	<!-- /Footer -->
	
</div>
<!-- /Main Content -->