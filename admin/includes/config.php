<?php
// db data connection
$servername = "localhost";
$username = "u671249433_petmart2USER";
$password = "N@b$90949089";
$dbname = "u671249433_petmart2DB";

// Create connection
$dbconnect = mysqli_connect($servername, $username, $password, $dbname);

// Check connection
if (!$dbconnect) {
  die("Connection failed: " . mysqli_connect_error());
}
date_default_timezone_set('Asia/Kuwait');
$date = date('Y-m-d H:i:s');
?>