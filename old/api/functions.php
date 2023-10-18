<?php
SESSION_START();
require ('../admin/includes/config.php');
require ('../admin/includes/translate.php');
require ('../admin/includes/functions.php');

if ( isset($_POST["productValue"]) ){
	$homeFormA = '<p class="mb-2">'.$selectSubProduct.'</p><div class="form-group">
			<select name="size" class="form-control" required>';
			$homeFormA .= '<option selected disabled value="">'.$selectSubProduct.'</option>';
			$sql = "SELECT *
					FROM `subproducts`
					WHERE
					`productId` = '".$_POST["productValue"]."'
					AND
					`hidden` LIKE 0
					";
			$result = $dbconnect->query($sql);
			while ( $row = $result->fetch_assoc() ){
				$homeFormA .= '<option value="'.$row["size"].'">'.$row["size"].'</option>';
			}
	echo $homeFormA;
}

if( isset($_POST["subProduct"]) ){
	
	$product = selectDB("subproducts","`id` = '{$_POST["subProduct"]}'");
	
	$sql = "SELECT
			`discount`
			FROM
			`products`
			WHERE
			`id` LIKE '{$product[0]["productId"]}'";
	$result = $dbconnect->query($sql);
	$row = $result->fetch_assoc();
	if ( $row["discount"] != 0 ){
		$discount = $row["discount"];
	}
	
	$sql = "SELECT
			`price`, `color`,`colorEn`, `id`
			FROM
			`subproducts`
			WHERE
			`id` LIKE '{$_POST["subProduct"]}'
			AND
			`hidden` = '0'";
	$result = $dbconnect->query($sql);
	while ($row = $result->fetch_assoc()){
		if ( isset($discount) ){
			$price = $row["price"];
			$discountedPrice = $row["price"] * ( (100 - $discount) / 100 );
		}else{
			$price = $row["price"];
			$discountedPrice = "0";
		}
	}
	echo $price . "^" . $discountedPrice;
}

if ( isset($_POST["subProId"]) ){
	$color = "<option selected='true' disabled='disabled'>{$pleaseSelectText}</option>";
	$sql = "SELECT
			`discount`
			FROM
			`products`
			WHERE
			`id` LIKE '".$_POST["productId"]."'";
	$result = $dbconnect->query($sql);
	$row = $result->fetch_assoc();
	if ( $row["discount"] != 0 ){
		$discount = $row["discount"];
	}
	
	$size = selectDB("subproducts","`id` = '{$_POST["subProId"]}'");
	
	$sql = "SELECT
			`price`, `color`,`colorEn`, `id`
			FROM
			`subproducts`
			WHERE
			`productId` LIKE '{$_POST["productId"]}'
			AND
			`size` LIKE '{$size[0]["size"]}'
			AND
			`hidden` = '0'";
	$result = $dbconnect->query($sql);
	while ($row = $result->fetch_assoc()){
		if ( isset($discount) ){
			if ( $directionHTML == "rtl" ){
				$color .= "<option value='{$row["id"]}'>".$row["color"]."</option>";
			}else{
				$color .= "<option value='{$row["id"]}'>".$row["colorEn"]."</option>";
			}
			$price = $row["price"];
			$discountedPrice = $row["price"] - ( $row["price"] * $discount / 100 );
		}else{
			if ( $directionHTML == "rtl" ){
				$color .= "<option value='{$row["id"]}'>".$row["color"]."</option>";
			}else{
				$color .= "<option value='{$row["id"]}'>".$row["colorEn"]."</option>";
			}
			$price = $row["price"];
			$discountedPrice = "0";
		}
	}
	echo $price . "^" . $discountedPrice . "^" . $color;
}

if ( isset($_POST["getAreasA"]) ){
	if ( $_POST["getAreasA"] == "KW" ){
		$sql = "SELECT *
				FROM `areas`
				ORDER BY ";
			if ( $directionHTML == 'rtl' ) {
				$sql .= "`arTitle`";
			}else{
				$sql .= "`enTitle`";
			}
			$sql .= " ASC";
		$result = $dbconnect->query($sql);
		while ( $row = $result->fetch_assoc() )
		{
			?>
			<option value="<?php echo $row['id'] ?>">
			<?php
			if ( $directionHTML == 'rtl' ) {
				echo $row['arTitle'];
			}else{
				echo $row['enTitle'];
			}
			?>
			</option>
		<?php
		}
	}else{
		$sql = "SELECT *
				FROM `cities`
				WHERE
				`CountryCode` LIKE '".$_POST["getAreasA"]."'
				ORDER BY `CityNames` ASC";
		$result = $dbconnect->query($sql);
		while ( $row = $result->fetch_assoc() )
		{
			?>
			<option value="<?php echo $row['CityNames'] ?>">
			<?php echo $row['CityNames']; ?>
			</option>
		<?php
		}
	}
}

if ( isset($_POST["homeForm"]) ){
	$homeFormA = '<p class="mb-2">'.$selectAreaText.'</p><div class="form-group">
			<select name="area" class="form-control" required>';
			$homeFormA .= '<option selected disabled value="">'.$selectAreaText.'</option>';
			$sql = "SELECT *
					FROM `areas`
					ORDER BY ";
			if ( $directionHTML == 'rtl' ) {
				$sql .= "`arTitle`";
			}else{
				$sql .= "`enTitle`";
				}
			$sql .= " ASC";
			$result = $dbconnect->query($sql);
			while ( $row = $result->fetch_assoc() ){
				$homeFormA .= '<option value="'.$row["id"].'">'.$row["arTitle"].'</option>';
			}
	$homeFormA .= '</select>
				</div>
				<div class="form-group">
					<input type="text" class="form-control" name="block" placeholder="'.$blockText.'" required>
				</div>
				<div class="form-group">
					<input type="text" class="form-control" name="street" placeholder="'.$streetText.'" required>
				</div>
				<div class="form-group">
					<input type="text" class="form-control" name="avenue" placeholder="'.$avenueText.'" >
				</div>
				<div class="form-group">
					<input type="text" class="form-control" name="house" placeholder="'.$houseText.'" required>
				</div>
				<div class="form-group">
					<input type="text" class="form-control" name="postalCode" placeholder="'.$postalCodeText.'">
				</div>
				<div class="form-group">
					<input type="text" class="form-control" name="notes" placeholder="'.$specialInstructionText.'">
				</div>';
	echo $homeFormA;
}

if ( isset($_POST["pickUpform"]) ){
	$homeFormA = '
			</div>
			<div class="form-group">
			<input type="hidden" class="form-control" name="area" placeholder="'.$selectAreaText.'">
				<input type="hidden" class="form-control" name="block" placeholder="'.$blockText.'">
			</div>
			<div class="form-group">
				<input type="hidden" class="form-control" name="street" placeholder="'.$streetText.'">
			</div>
			<div class="form-group">
				<input type="hidden" class="form-control" name="avenue" placeholder="'.$avenueText.'" >
			</div>
			<div class="form-group">
				<input type="hidden" class="form-control" name="house" placeholder="'.$houseText.'">
			</div>
			<div class="form-group">
					<input type="hidden" class="form-control" name="postalCode" placeholder="'.$postalCodeText.'">
				</div>
			<div class="form-group">
				<input type="hidden" class="form-control" name="notes" placeholder="'.$specialInstructionText.'">
			</div>';
			echo $homeFormA;
}

if ( isset($_POST["apartmentForm"])){
	$apartmentFormA = '<p class="mb-2">'.$selectAreaText.'</p><div class="form-group">
				<select name="areaa" class="form-control" required>';
				$apartmentFormA .= '<option selected disabled value="">'.$selectAreaText.'</option>';
	$sql = "SELECT *
			FROM `areas`
			ORDER BY ";
	if ( $directionHTML == 'rtl' ) {
		$sql .= "`arTitle`";
	}else{
		$sql .= "`enTitle`";
		}
	$sql .= " ASC";
	$result = $dbconnect->query($sql);
	while ( $row = $result->fetch_assoc() ){
		$apartmentFormA .= '<option value="'.$row["id"].'">'.$row["arTitle"].'</option>';
	}
	$apartmentFormA .= '</select>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="blocka" placeholder="'.$blockText.'" required>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="streeta" placeholder="'.$streetText.'" required>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="avenuea" placeholder="'.$avenueText.'">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="building" placeholder="'.$buildingText.'" required>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="floor" placeholder="'.$floorText.'" required>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="apartment" placeholder="'.$apartmentText.'" required>
			</div>
			<div class="form-group">
					<input type="text" class="form-control" name="postalCode" placeholder="'.$postalCodeText.'">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="notesa" placeholder="'.$specialInstructionText.'">
			</div>';
			echo $apartmentFormA;
}

if ( isset($_POST["removeItemBoxId"]) ){
	$id = $_POST["removeItemBoxId"];
	$subId = $_POST["removeItemBoxSubId"];
	
	for ($i = 0;$i < sizeof($_SESSION["cart"]["id"]) ;$i++ ){
		if ( $_SESSION["cart"]["id"][$i] == $id AND $_SESSION["cart"]["subId"][$i] == $subId ){
			unset($_SESSION["cart"]["id"][$i]);
			unset($_SESSION["cart"]["qorder"][$i]);
			unset($_SESSION["cart"]["size"][$i]);
			unset($_SESSION["cart"]["sku"][$i]);
			unset($_SESSION["cart"]["subId"][$i]);
			
			$_SESSION["cart"]["id"] = array_values($_SESSION["cart"]["id"]);
			$_SESSION["cart"]["qorder"] = array_values($_SESSION["cart"]["qorder"]);
			$_SESSION["cart"]["size"] = array_values($_SESSION["cart"]["size"]);
			$_SESSION["cart"]["sku"] = array_values($_SESSION["cart"]["sku"]);
			$_SESSION["cart"]["subId"] = array_values($_SESSION["cart"]["subId"]);
		}
	}
	$cartItemsNo = sizeof($_SESSION["cart"]["id"]);
	echo $cartItemsNo;
}

if ( isset($_POST["checkVoucherVal"]) && isset($_POST["totals2"]) && isset($_POST["shippingChargesInput"])  ) {
	$totals2 		 = $_POST["totals2"];
	$visaCard 		 = $_POST["visaCardCheck"];
	$userDiscount 	 = $_POST["userDiscountCheck"];
	$shoppingCharges = $_POST["shippingChargesInput"];
	$userDiscountP 	 = $_POST["userDiscountPercentage"];
	$sql = "SELECT 
			`percentage`, `id`
			FROM 
			`vouchers`
			WHERE 
			`voucher` LIKE '".$_POST["checkVoucherVal"]."' AND
			`hidden` != '1'
			";
	$result = $dbconnect->query($sql);
	if ( $result->num_rows == 0 ){
		if ( $userDiscount != "0" ){
			$totals2 = $userDiscount + $shoppingCharges + $visaCard ;
			$userDiscount = $userDiscount - $visaCard ;
		}else{
			$totals2 = $totals2 + $shoppingCharges + $visaCard;
			$userDiscount = 0;
		}
		$msg = $voucherInvalidText ;
		$voucherId = "";
		$discountPercentage = 0;
	}else{
		$row = $result->fetch_assoc();
		$voucherPercentage = $row["percentage"];
		$voucherId = $row["id"];
		$newPrice = array();
		$counter = 0;
		for ( $i=0; $i < sizeof($_SESSION["cart"]["id"]); $i++){
			$sql = "SELECT
					sp.price as realPrice, p.discount
					FROM
					`subproducts` AS sp
					JOIN
					`products` AS p
					ON
					sp.productId = p.id
					WHERE
					sp.id = '".$_SESSION["cart"]["subId"][$i]."' 
					AND
					sp.hidden = '0'
					AND
					sp.productId IN ( SELECT
							  `productId`
							  FROM 
							  `vouchers`
							  WHERE
							  `productId` LIKE '".$_SESSION["cart"]["id"][$i]."'
							  AND
							  `voucher` LIKE '".$_POST["checkVoucherVal"]."'
							  )
					";
			$result = $dbconnect->query($sql);
			$row = $result->fetch_assoc();
			if ( $result->num_rows > 0 AND $userDiscountP == "0" AND $row["discount"] == "0" ){
				$newPrice[] = ($row["realPrice"] - ( $row["realPrice"] * $voucherPercentage / 100 ))*$_SESSION["cart"]["qorder"][$i];
				$counter++;
			}else{
				$sql = "SELECT
						sp.price as realPrice, p.discount
						FROM
						`subproducts` AS sp
						JOIN
						`products` AS p
						ON
						sp.productId = p.id
						WHERE
						sp.productId = '".$_SESSION["cart"]["id"][$i]."'
						AND
						sp.id = '".$_SESSION["cart"]["subId"][$i]."'
						AND
						sp.hidden = '0'
						";
				$result = $dbconnect->query($sql);
				$row = $result->fetch_assoc();
				if ( $userDiscountP != "0"){
					$newPrice[] = ($row["realPrice"] - ( $row["realPrice"] * $userDiscountP / 100 ))*$_SESSION["cart"]["qorder"][$i];
				}elseif ( $row["discount"] != "0" ){
					$newPrice[] = ($row["realPrice"] - ( $row["realPrice"] * $row["discount"] / 100 ))*$_SESSION["cart"]["qorder"][$i];
				}else{
					$newPrice[] = $row["realPrice"]*$_SESSION["cart"]["qorder"][$i];
				}
			}
		}
		if ( $visaCard != 0 ){
			$visaCard = round((array_sum($newPrice) * 2.75 / 100),2);
		}else{
			$visaCard = 0;
		}
		if ( $counter != 0 ){
			$discountPercentage = (float)$voucherPercentage;
		}else{
			$discountPercentage = 0;
		}
		$msg = $validVoucherText ;
		$totals2 = array_sum($newPrice) + $shoppingCharges + $visaCard;
		$userDiscount = 0;
	}
	if (isset($newPrice)){
	    $subPriceNew = array_sum($newPrice);
	}else{
	    $subPriceNew = $totals2 - $shoppingCharges ;
	}
 	echo $totals2.','.$msg.','.$voucherId.",".$shoppingCharges .",".$discountPercentage . ',' . $visaCard . ',' . $userDiscountP. ",". $subPriceNew ;
}

if ( isset($_POST["emailAj"]) AND !empty($_POST["emailAj"]) ){
	$email = $_POST["emailAj"];
	$password1 = rand(00000000,99999999);
	$password = sha1($password1);
	$sql = "SELECT * FROM `users` WHERE `email` LIKE '".$email."' ";
	$result = $dbconnect->query($sql);
	if ( $result->num_rows == 1 ){
		$row = $result->fetch_assoc();
		$name = $row["fullName"];
		$sql = "UPDATE `users`
				SET
				`password` = '".$password."'
				WHERE
				`email` LIKE '".$email."'
				";
		$result = $dbconnect->query($sql);
		
		$curl = curl_init();
		curl_setopt_array($curl, array(
			CURLOPT_URL => 'myid.createkwservers.com/api/v1/send/notify',
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => '',
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 0,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'POST',
			CURLOPT_POSTFIELDS => array(
				'site' => "{$settingsTitle}",
				'subject' => "Forget Password - {$settingsTitle}",
				'body' => "<center>
						<img src='{$settingsWebsite}/logos/{$settingslogo}' style='width:200px;height:200px'>
						<p>&nbsp;</p>
						<p>Dear {$email},</p>
						<p>Your new password at {$settingsWebsite} is:<br>
						</p>
						<p style='font-size: 25px; color: red'><strong>{$password1}</strong></p>
						<p>Best regards,<br>
						<strong>{$settingsEmail}</strong></p>
						</center>",
				'from_email' => "noreply@{$settingsTitle}.com",
				'to_email' => $email
			),
		));
		$response = curl_exec($curl);
		curl_close($curl);
		echo $passwordToEmailText ;
	}else{
		echo $emailInvalidText;
	}
}

if ( isset($_POST["nameReg"]) AND !empty($_POST["nameReg"]) AND isset($_POST["phoneReg"]) AND !empty($_POST["phoneReg"]) AND isset($_POST["emailReg"]) AND !empty($_POST["emailReg"]) AND isset($_POST["passwordReg"]) AND !empty($_POST["passwordReg"])){
	$name = $_POST["nameReg"];
	$phone = $_POST["phoneReg"];
	$email = $_POST["emailReg"];
	$password1 = $_POST["passwordReg"];
	if ( !preg_match("/^[a-zA-Z0-9 ]*$/",$phone) AND !preg_match("/^[a-zA-Z0-9 ]*$/",$password1) AND !preg_match("/^[a-zA-Z0-9 ]*$/",$name) ){
		echo $fillCorrectlyText ;
		exit();
	}
	$password = sha1($password1);
	$sql = "SELECT * FROM `users` WHERE `email` LIKE '%".$email."%' LIMIT 1 ";
	$result = $dbconnect->query($sql);
	if ( $result->num_rows != 1 ){
		$sql = "INSERT INTO `users`
				(`fullName`, `email`, `password`, `phone`)
				VALUES
				('".$name."', '".$email."', '".$password."', '".$phone."')
				";
		$result = $dbconnect->query($sql);
		echo $RegistrationSuccText;
	}else{
		echo $emailExistText ;
	}
}

if ( isset($_POST["editPassAj"]) AND !empty($_POST["editPassAj"]) AND isset($_POST["editEmailAj"]) AND !empty($_POST["editEmailAj"]) ){
	$email = $_POST["editEmailAj"];
	$password1 = $_POST["editPassAj"];
	$password = sha1($password1);
    $sql = "UPDATE `users`
			SET
			`password` = '".$password."'
			WHERE
			`email` LIKE '".$email."'
            ";
	$result = $dbconnect->query($sql);
	echo $passwordChagnedText ;
}

if ( isset($_POST["loginEmailAj"]) AND !empty($_POST["loginEmailAj"]) AND isset($_POST["loginPassAj"]) AND !empty($_POST["loginPassAj"]) )
{
	$email = $_POST["loginEmailAj"];
	$password1 = $_POST["loginPassAj"];
	$password = sha1($password1);
    $sql = "SELECT *
			FROM `users`
			WHERE
			`email` LIKE '".$email."' AND
			`password` LIKE '".$password."'
			";
	$result = $dbconnect->query($sql);
	$row = $result->fetch_assoc();

	$coockiecode = $row["keepMeAlive"];
	$coockiecode = explode(',',$coockiecode);
	$GenerateNewCC = md5(rand());
	if ( sizeof($coockiecode) <= 3 ){
		$coockiecodenew = array();
		if ( !isset ($coockiecode[2]) ) { 
			$coockiecodenew[1] = $GenerateNewCC ; 
		}else{ 
			$coockiecodenew[0] = $coockiecode[1]; 
		}

		if ( !isset ($coockiecode[1]) ){
			$coockiecodenew[0] = $GenerateNewCC ; 
		}else{ 
			$coockiecodenew[1] = $coockiecode[2]; 
		}
		
		if ( !isset ($coockiecode[0]) ){
			$coockiecodenew[2] = $GenerateNewCC ; 
		}else{ 
			$coockiecodenew[2] = $GenerateNewCC; 
		}
	}

	$coockiecode = $coockiecodenew[0] . "," . $coockiecodenew[1] . "," . $coockiecodenew[2] ;

	if ( $result->num_rows == 1 ){
		$sql = "UPDATE `users` 
				SET 
				`keepMeAlive` = '".$coockiecode."' 
				WHERE 
				`email` LIKE '".$email."' 
				AND 
				`password` LIKE '$password'";
		$result = $dbconnect->query($sql);
		$_SESSION[$cookieSession."Store"] = $email;
		echo "1," . $loggedInText;
		setcookie($cookieSession."Store", $GenerateNewCC, time() + (86400*30 ), "/");
	}else{
		echo "0," . $wrongLoginText ;
	}
}
?>