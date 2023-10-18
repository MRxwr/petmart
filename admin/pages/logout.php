<?php
setcookie("ezyoCreate", "", time() - 3600, '/');
setcookie("ezyoVCreate", "", time() - 3600, '/');
header('LOCATION: ../login.php');
?>