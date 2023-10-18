<?php
ob_start();
header("Cache-Control: no-cache, no-store, must-revalidate"); // HTTP 1.1.
header("Pragma: no-cache"); // HTTP 1.0.
header("Expires: 0");
require ('admin/includes/config.php');
require ('admin/includes/translate.php');
require ('includes/checksouthead.php');
require ('admin/includes/functions.php');
$maintenace = selectDB("maintenance","`id` = '1'");
if ( $maintenace[0]["status"] == 1 ){
    header ("LOCATION: maintenance.php");
}elseif ( $maintenace[0]["status"] == 2 ){
    header ("LOCATION: busy");
}
?>
<!DOCTYPE html>
<html lang="en" dir="<?php echo $directionHTML ?>">
<head>
<meta property="og:title" content="<?php echo $settingsTitle ?>">
<meta property="og:url" content="<?php echo $settingsWebsite ?>">
<meta property="og:description" content="<?php echo $settingsOgDescription ?>">
<meta property="og:image" content="logos/<?php echo $settingslogo ?>">
    <meta charset=utf-8>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="img/favicon.png" rel="shortcut icon" />
    <title><?php echo $settingsTitle ?></title>
    <meta name="description" content="<?php echo $settingsOgDescription ?>">
    <meta name="keywords" content="<?php echo $settingsOgDescription ?>">
    <link href="css/bootstrap.min.css?x=1" rel="stylesheet">
    <link href="css/owl.carousel.min.css?p=2" rel="stylesheet">
    <link href="css/bootstrap-select.min.css?x=1" rel="stylesheet">
    <link href="css/flag-icon.min.css?x=1" rel="stylesheet">
    <link href="css/jquery-ui.css?x=1" rel="stylesheet">
    <link href="css/custome.css?x=26" rel="stylesheet">
    <link href="css/responsive.css?y=22" rel="stylesheet">
    <link href="css/font-awesome.css?x=1" rel="stylesheet">
    <link href="css/animate.min.css?x=1" rel="stylesheet">
	<link href="css/jquery.fancybox.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Almarai&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@200;300;400;500;700;800;900&display=swap" rel="stylesheet">


    <script src="js/jquery-3.3.1.slim.min.js" ></script>
    <script src="js/jquery-1.11.1.js"></script>
    <script src="js/jquery.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/wow.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/bootstrap-select.min.js"></script>
	<script src="js/jquery.fancybox.min.js"></script>
</head>
<style>
    body {
        font-family: 'Tajawal';
		padding:0 !important;
    }
    .join-btn {
    background: #997a7a;
    color: #fff;
    padding: 0.4rem 1.2rem;
    border-radius: 6px;
    font-family: 'Tajawal';
	
    
}
</style>
<body class="rtl <?php echo $directionBODY ?>" id="body">

<div class="v-body">

<div class="header fixme d-md-block d-sm-none d-none" style="background-color: #185b99;border: 1px solid #00000014;">
    <div class="container-fluid">
        <div class="row d-flex align-items-center">
            <div class="col-md-2 mt-3 mb-3" style="white-space:nowrap">
                <a href="index.php"style="color: #ffffff;
    font-size: 22px;
    font-family: 'Tajawal';
    background: #5291cb;
    padding: 10px;
    border-radius: 6px;"><?php echo $settingsTitle ?></a>
            </div>
            <div class="col-md-10 text-left">
                <ul class="nav-links list-unstyled list-inline mb-0 pl-0">
                    <li class="list-inline-item ">
                        <?php echo getLoginStatus(); ?>
                    </li>
						<?php
						$explode = explode($_SERVER['REQUEST_URI'],"/");
						if( strstr($_SERVER['REQUEST_URI'],"index") || sizeof($explode) < 1){
							$sign = "?";
						}else{
							$sign = "&";
						}
						$langParam = direction("lang=AR","lang=ENG");
						$flagClass = direction("flag-icon-arabic","flag-icon-us");
                        ?>
                        <a href="<?php echo $_SERVER['REQUEST_URI'].$sign.$langParam ?>">
                        <span class="flag-icon <?php echo $flagClass ?>" style="color:white;"></span>
                        </a>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="mobile-header fixme d-md-none d-sm-block d-block" style="background-color: #185b99;">
    <nav role='navigation' style="direction: rtl !important; float:right !important">
        <div id="menuToggle">
            <input type="checkbox" />
            <span></span>
            <span></span>
            <span></span>
            <ul id="menu">
                <a href="javascript:void()" class="join-menu-div" style="background-image: url('logos/inlogo.png'); background-size: 50%; background-repeat: no-repeat; height: 150px;background-position: center;">
                    <?php /*<!-- <img src="img/richlogo.png" class="img-fluid mb-2 slider-logo" style=""> -->*/ ?>
                </a>
                <li><a href="index.php" class="active"><?php echo $mainText ?></a></li>
                <?php if ( isset($userID) AND !empty($userID) ){ ?>
                <li><a data-toggle="modal" data-target="#editProfile_popup"><?php echo $ProfileText ?></a></li>
                <li><a data-toggle="modal" data-target="#orders_popup"><?php echo $orderText ?></a></li>
                <li><a href="logout.php" ><?php echo $logoutText ?></a></li>
                <?php }else{ ?>
                    <li><a data-toggle="modal" class="loginClick" data-target="#login_popup"><?php echo $loginText ?></a></li>
                    <?php  } ?>
                  <li><a href="#" ><?php echo $contactText ?></a></li>
                  <?php
                    $sql = "SELECT * FROM `s_media`";
                    $result = $dbconnect->query($sql);
                    $row = $result->fetch_assoc();
                    $whatsapp = $row["whatsapp"];
                    $snapchat = $row["snapchat"];
                    $instagram = $row["instagram"];
                    $location = $row["location"];
                    $email = $row["email"];
                    ?>
                <ul class="social-icons pl-0 mb-0 pr-0" style="margin-top: 10px;text-align: center;">
					<?php
					if( !empty($instagram) AND $instagram != "#" ){
					?>
                    <li style="padding: 10px;"><a style="font-size: 20px;height: 36px;width: 36px;" href="https://www.instagram.com/<?php echo $instagram ?>">
                        <span class="fa fa-instagram" style="height: 15px; background: #185b99;"></span></a></li>
					<?php
					}
					if( !empty($whatsapp) AND $whatsapp != "#" ){
					?>
                    <li style="padding: 10px;"><a style="font-size: 20px;height: 36px;width: 36px;" href="https://wa.me/<?php echo $whatsapp ?>">
                        <span class="fa fa-whatsapp" style="height: 15px; background: #185b99;"></span></a></li>
					<?php } ?>
                </ul>
                <p class="menu-foot-link">Powered by <a href="http://www.create-kw.com
" target="_blank">Create-kw.com</a></p>
            </ul>
        </div>
        <?php
		$explode = explode($_SERVER['REQUEST_URI'],"/");
		if( strstr($_SERVER['REQUEST_URI'],"index") || sizeof($explode) < 1){
			$sign = "?";
		}else{
			$sign = "&";
		}
		$langParam = direction("lang=AR","lang=ENG");
		$flagClass = direction("flag-icon-arabic","flag-icon-us");
		?>
		<a href="<?php echo $_SERVER['REQUEST_URI'].$sign.$langParam ?>">
		<span class="flag-icon <?php echo $flagClass ?>" style="color:white;"></span>
		</a>
        <a href="#" data-toggle="modal" data-target="#serch_popup">
        <span class="fa fa-car mr-1" style="color:white"></span>
        </a>
        <a href="index.php" class="" style="color:white; font-size:24px;font-family: 'Tajawal', sans-serif;white-space: nowrap;"><span style="margin-right: 67px;font-family: 'Tajawal';"><?php echo $settingsTitle ?></span></a>
    </nav>
</div>



