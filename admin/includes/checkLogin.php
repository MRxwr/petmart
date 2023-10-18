<?php
if ( isset($_COOKIE["ezyoCreate"]) ){
	$sql = "SELECT *
			FROM `user`
			WHERE 
			`cookie` LIKE '".$_COOKIE["ezyoCreate"]."'
			AND
			`type` LIKE '0'
			";
	$result = $dbconnect->query($sql);
	if ( $result->num_rows < 1 ){
		$sql = "SELECT *
				FROM `user`
				WHERE 
				`cookie` LIKE '".$_COOKIE["ezyoCreate"]."'
				";
		$result = $dbconnect->query($sql);
		if ( $result->num_rows < 1 ){
			setcookie("ezyoCreate", "", time() - 3600, '/');
			header('LOCATION: pages/logout.php');die();
		}
	}
	$row = $result->fetch_assoc();
	$userId = $row["id"];
	$username = $row["username"];
	$userType = $row["type"];
}

if ( !isset($_COOKIE["ezyoCreate"]) || ( isset( $_GET["page"] ) && $_GET["page"] == "logout" ) || empty($_COOKIE["ezyoCreate"]) ){
	setcookie("ezyoCreate", "", time() - 3600, '/');
	header('LOCATION: pages/logout.php');die();
}else{
	$sql = "SELECT *
			FROM `user`
			WHERE 
			`cookie` LIKE '".$_COOKIE["ezyoCreate"]."'
			AND
			`type` LIKE '0'
			";
	$result = $dbconnect->query($sql);
	if ( $result->num_rows < 1 ){
		$sql = "SELECT *
				FROM `user`
				WHERE 
				`cookie` LIKE '".$_COOKIE["ezyoCreate"]."'
				";
		$result = $dbconnect->query($sql);
	}
	$row = $result->fetch_assoc();
	$userId = $row["id"];
	$username = $row["username"];
	$userType = $row["type"];
}
?>