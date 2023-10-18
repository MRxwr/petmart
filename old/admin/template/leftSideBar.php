<?php
/*
$sql = "SELECT * 
		FROM `adminstration` 
		WHERE `email` LIKE '".$email."'";
$result = $dbconnect->query($sql);
if ( $result->num_rows == 0 )
{
	$sql = "SELECT * 
			FROM `employees` 
			WHERE
			`email` LIKE '".$email."'
			AND
			`empType` LIKE '0'
			";
	$result = $dbconnect->query($sql);
	if ( $result->num_rows == 1 )
	{
		$admin = "1";
	}
}else{
	$admin = "1";
}
if ( isset($admin) ){
	*/
?>
<div class="fixed-sidebar-left">
			<ul class="nav navbar-nav side-nav nicescroll-bar">
				<li class="navigation-header">
					<span><?php echo $settingsTitle ?></span> 
					<i class="zmdi zmdi-more"></i>
				</li>

				<li>
				<a href="javascript:void(0);" data-toggle="collapse" data-target="#myShop" class="collapsed" aria-expanded="false">
					<div class="pull-left">
						<i class="pe-7s-shopbag mr-20"></i>
						<span class="right-nav-text"><?php echo $MyShopText ?></span>
					</div>
					<div class="pull-right">
						<i class="zmdi zmdi-caret-down"></i>
					</div>
					<div class="clearfix"></div>
				</a>
				<ul id="myShop" class="collapse-level-1 collapse" aria-expanded="true" style="">
						<li>
							<a href="categories.php" ><div class="pull-left">
							<i class="glyphicon glyphicon-th-large mr-20"></i>
							<span class="right-nav-text"><?php echo $Categories ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>
						<li>
							<a href="product.php" ><div class="pull-left">
							<i class="zmdi zmdi-shopping-basket mr-20"></i>
							<span class="right-nav-text"><?php echo $Products ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>
						<li>
							<a href="vouchers.php" ><div class="pull-left">
							<i class="glyphicon glyphicon-scissors mr-20"></i>
							<span class="right-nav-text"><?php echo $Vouchers ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>
						<!--<li>
							<a href="locations.php" ><div class="pull-left">
							<i class="ti-location-pin mr-20"></i>
							<span class="right-nav-text"><?php echo $Locations ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>-->
						<li>
							<a href="users.php" ><div class="pull-left">
							<i class="fa fa-users mr-20"></i>
							<span class="right-nav-text"><?php echo $Users ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>
					</ul>
				</li>

			<li>
				<a href="javascript:void(0);" data-toggle="collapse" data-target="#orders" class="collapsed" aria-expanded="false">
					<div class="pull-left">
						<i class="ti-shopping-cart mr-20"></i>
						<span class="right-nav-text"><?php echo $ordersText ?></span>
					</div>
					<div class="pull-right">
						<i class="zmdi zmdi-caret-down"></i>
					</div>
					<div class="clearfix"></div>
				</a>
				<ul id="orders" class="collapse-level-1 collapse" aria-expanded="true" style="">
						<li>
							<a href="product-orders.php" ><div class="pull-left">
							<i class="ti-mobile mr-20"></i>
							<span class="right-nav-text"><?php echo $Online_Orders ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>
						<!--<li>
							<a href="product-orders-store.php" ><div class="pull-left">
							<i class="ti-shopping-cart mr-20"></i>
							<span class="right-nav-text"><?php echo $Stores_Orders ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>
						<li>
							<a href="product-orders-ur.php" ><div class="pull-left">
							<i class="ti-time mr-20"></i>
							<span class="right-nav-text"><?php echo $orders_ur ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>-->
					</ul>
				</li>

				<li>
					<a href="listOfEmployees.php" ><div class="pull-left">
					<i class="ti-user mr-20"></i>
					<span class="right-nav-text"><?php echo $listOfEmployees ?></span>
					</div>
					<div class="pull-right"></div><div class="clearfix"></div>
					</a>

					<a href="reports.php" ><div class="pull-left">
					<i class="icon-pie-chart mr-20"></i>
					<span class="right-nav-text"><?php echo $Reports ?></span>
					</div>
					<div class="pull-right"></div><div class="clearfix"></div>
					</a>
				</li>

				<li>
				<a href="javascript:void(0);" data-toggle="collapse" data-target="#settings" class="collapsed" aria-expanded="false">
					<div class="pull-left">
						<i class="fa fa-spin fa-cog mr-20"></i>
						<span class="right-nav-text"><?php echo $settingsText ?></span>
					</div>
					<div class="pull-right">
						<i class="zmdi zmdi-caret-down"></i>
					</div>
					<div class="clearfix"></div>
				</a>
				<ul id="settings" class="collapse-level-1 collapse" aria-expanded="true" style="">
						<li>
							<a href="banners.php" ><div class="pull-left">
							<i class="fa fa-file-image-o mr-20"></i>
							<span class="right-nav-text"><?php echo $Banners ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>
						<li>
							<a href="areas.php" ><div class="pull-left">
							<i class="fa fa-globe mr-20"></i>
							<span class="right-nav-text"><?php echo $areas ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>
						<li>
							<a href="countries.php" ><div class="pull-left">
							<i class="fa fa-globe mr-20"></i>
							<span class="right-nav-text"><?php echo $countriesText ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>
						<li>
							<a href="maintenance.php"><div class="pull-left">
							<i class="pe-7s-tools mr-20"></i>
							<span class="right-nav-text"><?php echo $Maintenance ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>
						<li>
							<a href="socialMedia.php"><div class="pull-left">
							<i class="fa fa-share-alt mr-20"></i>
							<span class="right-nav-text"><?php echo $sMediaText ?></span>
							</div>
							<div class="pull-right"></div><div class="clearfix"></div>
							</a>
						</li>
					</ul>
				</li>

			</ul>
		</div>
<?php
/*
}
else
{
	*/
	?>

	<?php
//}
?>