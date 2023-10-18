<!DOCTYPE html>
<html lang="en">
<?php require ("template/header.php"); ?>
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
</style>
<body>
	<!-- Preloader -->
	<div class="preloader-it">
		<div class="la-anim-1"></div>
	</div>
	<!-- /Preloader -->
    <div class="wrapper  theme-1-active pimary-color-green">
		<!-- Top Menu Items -->
		<?php require ("template/navbar.php") ?>
		<!-- /Top Menu Items -->
		
		<!-- Left Sidebar Menu -->
		<?php require("template/leftSideBar.php") ?>
		<!-- /Left Sidebar Menu -->
		
		<!-- Right Sidebar Menu -->
		<div class="fixed-sidebar-right">
		</div>
		<!-- /Right Sidebar Menu -->
		
		
		
		<!-- Right Sidebar Backdrop -->
		<div class="right-sidebar-backdrop"></div>
		<!-- /Right Sidebar Backdrop -->

        <!-- Main Content -->
		<div class="page-wrapper">
            <div class="container-fluid ">
				<!-- Row -->
				<div class="row" style="padding:16px">
					<div class="col-12">
					Welcome To <?php echo $settingsTitle ?> CP
					</div>
				</div>
				<?php
				/*
				<div class="row w-100 mt-5 text-center">
					<div class="col-sm-5" id="LiveTraffic">
							<a href="http://livetrafficfeed.com" data-num="10" data-width="0" data-responsive="1" data-time="Asia%2FKuwait" data-root="0" data-cheader="2853a8" data-theader="ffffff" data-border="2853a8" data-background="ffffff" data-normal="000000" data-link="135d9e" target="_blank" id="LTF_live_website_visitor">Website Counter</a><script type="text/javascript" src="//cdn.livetrafficfeed.com/static/v4/live.js"></script><noscript><a href="http://livetrafficfeed.com">Website Counter</a></noscript>
							<div class="centered1">Create-KW Live Traffic</div>
					</div>
					<div class="col-sm-6" id="liveCounter">
						<a href="https://livetrafficfeed.com/website-counter" data-time="Asia%2FKuwait" data-root="0" id="LTF_counter_href">Free Blog Counter</a><script type="text/javascript" src="//cdn.livetrafficfeed.com/static/static-counter/live.v2.js"></script><noscript><a href="https://livetrafficfeed.com/website-counter">Free Blog Counter</a></noscript>
						<div class="centered">Create-KW Counter</div>
					</div>
				</div>
				<div class="row w-100 mt-5 text-left">
					<div class="col-sm-5" id="liveCounter1">
						<a href="https://livetrafficfeed.com/flag-counter" data-row="5" data-col="3" data-code="1" data-flag="1" data-bg="ffffff" data-text="000000" data-root="0" id="LTF_flags_href">Flags Counter</a><script type="text/javascript" src="//cdn.livetrafficfeed.com/static/flag-counter/live.v2.js"></script><noscript><a href="https://livetrafficfeed.com/flag-counter">Flags Counter</a><a href="https://w3seotools.com">SEO audit tools</a></noscript>
						<div class="centered2">Create-KW Countries</div>
					</div>
					<div class="col-sm-6" id="liveCounter2">
						<div class="centered" style="display:none">Create-KW Counter</div>
					</div>
				</div>
				<!-- /Row -->
				*/
				?>
			</div>
			
			<!-- Footer -->
			<?php require("template/footer.php") ?>
			<!-- /Footer -->
			
		</div>
        <!-- /Main Content -->

    </div>
    <!-- /#wrapper -->
	
	<!-- JavaScript -->
	
    <!-- jQuery -->
    <script src="../vendors/bower_components/jquery/dist/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	
	<!-- Slimscroll JavaScript -->
	<script src="dist/js/jquery.slimscroll.js"></script>
	
	<!-- Owl JavaScript -->
	<script src="../vendors/bower_components/owl.carousel/dist/owl.carousel.min.js"></script>
	
	<!-- Sweet-Alert  -->
	<script src="../vendors/bower_components/sweetalert/dist/sweetalert.min.js"></script>
	<script src="dist/js/sweetalert-data.js"></script>
		
	<!-- Switchery JavaScript -->
	<script src="../vendors/bower_components/switchery/dist/switchery.min.js"></script>
	
	<!-- Fancy Dropdown JS -->
	<script src="dist/js/dropdown-bootstrap-extended.js"></script>
		
	<!-- Init JavaScript -->
	<script src="dist/js/init.js"></script>
	
	<script>
	/*
	$(window).load(function() {
		console.log( "ready!" );
		$('#LTF_ListC').find("a").remove();
		$('#LTF_ListC').find("div").css("background-image","");
		$('#LTF_ads').find("div").css("display","none");
		setTimeout(function() {
			$('#liveCounter').find("a").removeAttr("href");
			$('#liveCounter1').find("a").removeAttr("href");
		}, 2000);
		
	});
	*/
	</script>
</body>

</html>
