<?php
header("Content-Type: application/json");
require_once('../admin/includes/config.php');
require_once('../admin/includes/functions.php');

if( isset($_GET["page"]) && $_GET["page"] == "success" ){
	die();
}elseif( isset($_GET["page"]) && $_GET["page"] == "failure" ){
	die();
}
/*
if ( isset(getallheaders()["petmartcreate"]) ){
	$headerAPI =  getallheaders()["petmartcreate"];
}else{
	$error = array("msg"=>"Please set headres");
	echo outputError($error);die();
}

if ( $headerAPI != "PetMartCreateCo" ){
	$error = array("msg"=>"APIKEY value is wrong");
	echo outputError($error);die();
}
*/
$unsetData = ["userId","status","date", "username", "password", "cookie", "name", "email", "forgetPassword"];

if( isset($_GET["action"]) && $_GET["action"] == "home" ){
	require("home.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "categories" ){
	require("categories.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "categoryItems" ){
	require("categoryItems.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "item" ){
	require("item.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "hospitals" ){
	require("hospitals.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "hospitalsDetails" ){
	require("hospitalsDetails.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "services" ){
	require("services.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "serviceDetails" ){
	require("serviceDetails.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "shops" ){
	require("shops.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "shopDetails" ){
	require("shopDetails.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "shopItemDetails" ){
	require("shopItemDetails.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "adoption" ){
	require("adoption.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "lost" ){
	require("lost.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "packages" ){
	require("packages.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "banners" ){
	require("banners.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "settings" ){
	require("settings.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "user" ){
	require("user.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "shareView" ){
	require("shareView.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "addPost" ){
	require("addPost.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "editPost" ){
	require("editPost.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "removePost" ){
	require("removePost.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "search" ){
	require("search.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "myPosts" ){
	require("myPosts.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "notifications" ){
	require("notifications.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "removeImage" ){
	require("removeImage.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "uploadVideo" ){
	require("uploadVideo.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "success" ){
	require("success.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "auctions" ){
	require("auctions.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "interest" ){
	require("interest.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "rating" ){
	require("rating.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "ownerResponse" ){
	require("ownerResponse.php");
}elseif( isset($_GET["action"]) && $_GET["action"] == "sms" ){
	require("sms.php");
}else{
	$error = array("msg"=>"please select the correct action");
	echo outputError($error);die();
}
?>