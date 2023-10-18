<?php
if ( isset($_COOKIE["ezyoVCreate"]) ){
	$sql = "SELECT *
			FROM `vendors`
			WHERE 
			`cookie` LIKE '".$_COOKIE["ezyoVCreate"]."'
			";
	$result = $dbconnect->query($sql);
	if ( $result->num_rows < 1 ){
		$sql = "SELECT *
				FROM `vendors`
				WHERE 
				`cookie` LIKE '".$_COOKIE["ezyoVCreate"]."'
				";
		$result = $dbconnect->query($sql);
		if ( $result->num_rows < 1 ){
			setcookie("ezyoVCreate", "", time() - 3600, '/');
			header('LOCATION: login.php');
		}
	}
}

if ( !isset($_COOKIE["ezyoVCreate"]) || ( isset( $_GET["page"] ) && $_GET["page"] == "logout" ) || empty($_COOKIE["ezyoVCreate"]) ){
	setcookie("ezyoVCreate", "", time() - 3600, '/');
	header('LOCATION: vendorLogin.php');
}else{
	$sql = "SELECT *
			FROM `vendors`
			WHERE 
			`cookie` LIKE '".$_COOKIE["ezyoVCreate"]."'
			";
	$result = $dbconnect->query($sql);
	$userType = 0;
	if ( $result->num_rows < 1 ){
		$sql = "SELECT *
				FROM `vendors`
				WHERE 
				`cookie` LIKE '".$_COOKIE["ezyoVCreate"]."'
				";
		$result = $dbconnect->query($sql);
		$userType = 1;
	}
	$row = $result->fetch_assoc();
	$userId = $row["id"];
	$username = $row["username"];
}
?>