<?php
if ( !isset($_GET["page"]) ){
	require_once('pages/home.php');
}elseif( $_GET["page"] == "home" ){
	require_once('pages/home.php');
}elseif( $_GET["page"] == "notification" ){
	require_once('pages/notification.php');
}elseif( $_GET["page"] == "hospitals" ){
	require_once('pages/hospitals.php');
}elseif( $_GET["page"] == "services" ){
	require_once('pages/services.php');
}elseif( $_GET["page"] == "categories" ){
	require_once('pages/categories.php');
}elseif( $_GET["page"] == "items" ){
	require_once('pages/items.php');
}elseif( $_GET["page"] == "settings" ){
	require_once('pages/settings.php');
}elseif( $_GET["page"] == "tags" ){
	require_once('pages/tags.php');
}elseif( $_GET["page"] == "employees" ){
	require_once('pages/employees.php');
}elseif( $_GET["page"] == "addTags" ){
	require_once('pages/addTags.php');
}elseif( $_GET["page"] == "images" ){
	require_once('pages/images.php');
}elseif( $_GET["page"] == "vouchers" ){
	require_once('pages/vouchers.php');
}elseif( $_GET["page"] == "users" ){
	require_once('pages/users.php');
}elseif( $_GET["page"] == "addresses" ){
	require_once('pages/addresses.php');
}elseif( $_GET["page"] == "orders" ){
	require_once('pages/orders.php');
}elseif( $_GET["page"] == "orderView" ){
	require_once('pages/orderView.php');
}elseif( $_GET["page"] == "logout" ){
	require_once('pages/logout.php');
}elseif( $_GET["page"] == "profile" ){
	require_once('pages/profile.php');
}elseif( $_GET["page"] == "reports" ){
	require_once('pages/reports.php');
}elseif( $_GET["page"] == "adminReports" ){
	require_once('pages/adminReports.php');
}elseif( $_GET["page"] == "brands" ){
	require_once('pages/brands.php');
}elseif( $_GET["page"] == "mainCategories" ){
	require_once('pages/mainCategories.php');
}elseif( $_GET["page"] == "imageGallery" ){
	require_once('pages/imageGallery.php');
}elseif( $_GET["page"] == "videoGallery" ){
	require_once('pages/videoGallery.php');
}elseif( $_GET["page"] == "banners" ){
	require_once('pages/banners.php');
}elseif( $_GET["page"] == "attributes" ){
	require_once('pages/attributes.php');
}elseif( $_GET["page"] == "variants" ){
	require_once('pages/variants.php');
}elseif( $_GET["page"] == "stars" ){
	require_once('pages/stars.php');
}elseif( $_GET["page"] == "faq" ){
	require_once('pages/faq.php');
}elseif( $_GET["page"] == "bestseller" ){
	require_once('pages/bestseller.php');
}elseif( $_GET["page"] == "complains" ){
	require_once('pages/complains.php');
}elseif( $_GET["page"] == "localization" ){
	require_once('pages/localization.php');
}elseif( $_GET["page"] == "filters" ){
	require_once('pages/filters.php');
}elseif( $_GET["page"] == "addFilter" ){
	require_once('pages/addFilter.php');
}elseif( $_GET["page"] == "shops" ){
	require_once('pages/shops.php');
}elseif( $_GET["page"] == "shopItems" ){
	require_once('pages/shopItems.php');
}elseif( $_GET["page"] == "shopItemImages" ){
	require_once('pages/shopItemImages.php');
}elseif( $_GET["page"] == "packages" ){
	require_once('pages/packages.php');
}elseif( $_GET["page"] == "auctions" ){
	require_once('pages/auctions.php');
}elseif( $_GET["page"] == "bidOptions" ){
	require_once('pages/bidOptions.php');
}else{
	require_once('pages/home.php');
}
?>