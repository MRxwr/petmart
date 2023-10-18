
<!-- Left Sidebar Menu -->
<div class="fixed-sidebar-left">
	<ul class="nav navbar-nav side-nav nicescroll-bar">
		<li class="navigation-header">
			<span>Petmart 2.0 CP LIST</span> 
			<i class="zmdi zmdi-more"></i>
		</li>

		<li>

			<a class="active" href="?page=home" >
				<div class="pull-left">
					<i class="zmdi zmdi-landscape mr-20"></i>
					<span class="right-nav-text">Dashboard</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>	
		<?php if ( isset($_COOKIE["ezyoCreate"]) && $userType  == 0 ){ ?>
			<a class="" href="?page=mainCategories" >
				<div class="pull-left">
					<i class="fa fa-columns mr-20"></i>
					<span class="right-nav-text">Categories</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
		<?php } if ( isset($_COOKIE["ezyoCreate"]) && $userType  == 0 ){ ?>
			<a class="" href="?page=tags" >
				<div class="pull-left">
					<i class="fa fa-tags mr-20"></i>
					<span class="right-nav-text">Type</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
		<?php } if ( isset($_COOKIE["ezyoCreate"]) && $userType  != 2 ){ ?>	
			<a class="" href="?page=filters" >
				<div class="pull-left">
					<i class="fa fa-filter  mr-20"></i>
					<span class="right-nav-text">Filters</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
			
			<a class="" href="?page=hospitals" >
				<div class="pull-left">
					<i class="fa fa-hospital-o  mr-20"></i>
					<span class="right-nav-text">Hospitals</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
			
			<a class="" href="?page=services" >
				<div class="pull-left">
					<i class="fa fa-briefcase mr-20"></i>
					<span class="right-nav-text">Services</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
			
			<a class="" href="?page=shops" >
				<div class="pull-left">
					<i class="fa fa-bank  mr-20"></i>
					<span class="right-nav-text">Shops</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
		<?php } if ( isset($_COOKIE["ezyoCreate"]) && $userType  != 2 ){ ?>	
			<a class="" href="?page=items" >
				<div class="pull-left">
					<i class="fa fa-tag mr-20"></i>
					<span class="right-nav-text">Posts</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
		<?php } if ( isset($_COOKIE["ezyoCreate"]) && $userType  != 2 ){ ?>	
			<a class="" href="?page=users" >
				<div class="pull-left">
					<i class="fa fa-users mr-20"></i>
					<span class="right-nav-text">Users</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
		<?php } if ( isset($_COOKIE["ezyoCreate"]) && $userType  != 2 ){ ?>	
			<a class="" href="?page=packages" >
				<div class="pull-left">
					<i class="fa fa-money mr-20"></i>
					<span class="right-nav-text">Packages</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
		<?php } if ( isset($_COOKIE["ezyoCreate"]) ){ ?>	
		
			<a class="" href="?page=bidOptions" >
				<div class="pull-left">
					<i class="fa fa-sort-numeric-asc mr-20"></i>
					<span class="right-nav-text">Bids</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>	
		
			<a class="" href="?page=auctions" >
				<div class="pull-left">
					<i class="fa fa-shopping-cart mr-20"></i>
					<span class="right-nav-text">Auctions</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
		
			<a class="" href="?page=orders" >
				<div class="pull-left">
					<i class="fa fa-shopping-cart mr-20"></i>
					<span class="right-nav-text">Orders</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
		<?php } if ( (isset($_COOKIE["ezyoCreate"]) && $userType  == 0) ){ ?>
			
			<a class="" href="?page=banners" >
				<div class="pull-left">
					<i class="fa fa-image mr-20"></i>
					<span class="right-nav-text">Banners</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
			
			<?php /* <a class="" href="?page=adminReports" >
				<div class="pull-left">
					<i class="fa fa-copy  mr-20"></i>
					<span class="right-nav-text">reports</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a> */ ?>
			
			<a class="" href="?page=employees" >
				<div class="pull-left">
					<i class="fa fa-user-md mr-20"></i>
					<span class="right-nav-text">Employees</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
			
			<?php /*<a class="" href="?page=localization" >
				<div class="pull-left">
					<i class="fa fa-font mr-20"></i>
					<span class="right-nav-text">Localization</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a> */ ?>
			
			<a class="" href="?page=notification" >
				<div class="pull-left">
					<i class="fa fa-commenting mr-20"></i>
					<span class="right-nav-text">Notification</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
			
			<a class="" href="?page=settings&edit=1" >
				<div class="pull-left">
					<i class="fa fa-gears mr-20"></i>
					<span class="right-nav-text">Settings</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
		<?php } if ( isset($_COOKIE["ezyoVCreate"]) ){ ?>
		
			<a class="" href="?page=categories&id=<?php echo $userId ?>" >
				<div class="pull-left">
					<i class="fa fa-columns  mr-20"></i>
					<span class="right-nav-text">categories</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
			
			<a class="" href="?page=orders" >
				<div class="pull-left">
					<i class="fa fa-shopping-cart mr-20"></i>
					<span class="right-nav-text">orders</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
			
			<a class="" href="?page=reports" >
				<div class="pull-left">
					<i class="fa fa-copy  mr-20"></i>
					<span class="right-nav-text">reports</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
			
			<a class="" href="?page=profile&edit=1" >
				<div class="pull-left">
					<i class="fa fa-user mr-20"></i>
					<span class="right-nav-text">Profile</span>
				</div>
				<div class="pull-right"></div>
				<div class="clearfix"></div>
			</a>
		<?php } ?>
		</li>

	</ul>
</div>
<!-- /Left Sidebar Menu -->
