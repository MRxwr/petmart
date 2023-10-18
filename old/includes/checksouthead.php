<?php
if ( isset ( $_COOKIE[$cookieSession."Store"] ) )
{
	echo $svdva = $_COOKIE[$cookieSession."Store"];
	$sql = "SELECT * 
			FROM `users` 
			WHERE 
            `keepMeAlive` LIKE '%".$svdva."%'
            ";
	$result = $dbconnect->query($sql);
	if ( $result->num_rows == 1 )
	{
		$row = $result->fetch_assoc();
		$userID = $row["id"];
		$email = $row["email"];
		$username = $row["fullName"];
		$_SESSION[$cookieSession."Store"] = $email;	
	}
}
?>