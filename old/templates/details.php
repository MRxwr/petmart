<style>
body{background-color:#fafafa}

</style>
<?php
date_default_timezone_set('Asia/Riyadh');
$check = ["'",'"',")","(",";","?",">","<","~","!","#","$","%","^","&","*","-","_","=","+","/","|",":"];

if ( !isset($_GET["OrderID"]) && !isset($_GET["c"]) ){
    header("LOCATION: checkout.php?status=fail");
    die();
}else{
	require('api/checkInvoice.php');
	$order = selectDB("orders","`orderId` = '{$orderId}'");
	if($voucherDetails = selectDB("vouchers","`id` = '{$order[0]["voucher"]}'")){
		$voucher = $voucherDetails[0]["voucher"];
	}else{
		$voucher = 0;
	}
	$email = $order[0]["email"];
	for( $i=0; $i<sizeof($order); $i++ ){
		$orderQuantity = selectDB("subproducts","`id` = '{$order[$i]["subId"]}'");
		$quantity[] = $orderQuantity[0]["quantity"] - $order[$i]["quantity"];
		$id[] = $order[$i]["productId"];
		$subId[] = $order[$i]["subId"];
	}
	if ( $order[0]["status"] == '0' ){
		$data = array("status" => "1");
		updateDB("orders",$data,"`orderId` = '{$orderId}'");
		for( $i=0; $i < sizeof($subId); $i++ ){
			$data = array("quantity" => $quantity[$i]);
			updateDB("subproducts",$data,"`id` = '{$subId[$i]}'");
		}
		if ( $order[0]["pMethod"] == 3 ){
			$noti = 2;
		}else{
			$noti = 1;
		}
		$settings = selectDB("settings","`id` = '1'");
		$data = array(
			'name' => $order[0]["fullName"],
			'email' => $order[0]["email"],
			'mobile' => $order[0]["mobile"],
			'price' => $order[0]["totalPrice"],
			'details' => $orderId,
			'refference' => $settings[0]["refference"],
			'noti' => $noti
		);
		sendMails($orderId,$email);
		sendNotification($data);
	}
}
?>
<div class="sec-pad grey-bg">
    <div class="container-fluid">
        <div class="row d-flex justify-content-center">
            <div class="col-lg-9">
                <div class="profile-box bordered-box">
                    <div class="profile-sec">
                    <div style="text-align:left">
                    <img src="logos/<?php echo $settingslogo ?>" style="width:150px; height:150px">
                    </div>
                    <h5 class="page-title"><?php echo $OrderReceivedText ?></h5>
                        <p class="mb-4"><?php echo $OrderReceivedMsgText ?></p>
                        <div class="row">
                            <div class="col-md-3 col-sm-6 col-6">
                                <p class="bold"><?php echo $orderNumberText ?></p>
                                <p><?php echo $orderId ?></p>
                            </div>
                            <div class="col-md-3 col-sm-6 col-6">
                                <p class="bold"><?php echo $dateText ?></p>
                                <p><?php echo substr($order[0]["date"],0,11); ?></p>
                            </div>
                            <div class="col-md-3 col-sm-6 col-6">
                                <p class="bold"><?php echo $deliveryText ?></p>
                                <p><?php echo $order[0]["d_s_charges"] ?>KD</p>
                            </div>
                            <div class="col-md-3 col-sm-6 col-6">
                                <p class="bold"><?php echo $Voucher ?></p>
                                <p><?php echo $voucher ?></p>
                            </div>
                            <div class="col-md-3 col-sm-6 col-6">
                                <p class="bold"><?php echo $discountText ?></p>
                                <p>%<?php echo $order[0]["discount"] ?></p>
                            </div>
							<?php
							/*
							<div class="col-md-3 col-sm-6 col-6">
                                <p class="bold"><?php echo $serviceChargesText ?></p>
                                <p>0.250KD</p>
                            </div>
							*/
							?>
                            <div class="col-md-3 col-sm-6 col-6">
                                <p class="bold"><?php echo $totalPriceText ?></p>
                                <p><?php echo $order[0]["totalPrice"] ?>KD</p>
                            </div>
                            <div class="col-md-3 col-sm-6 col-6">
                                <p class="bold"><?php echo $paymentMethodText ?></p>
                                <p>
								<?php
								if ( $order[0]["pMethod"] == 1 ){
									echo "K-NET";
								}elseif($order[0]["pMethod"] == 3){
									echo "CASH";
								}else{
									echo "Visa/Master";
								} 
								?>
								</p>
                            </div>
							<?php
								if( $order[0]["creditTax"] != 0 ){
									?>
								<div class="col-md-3 col-sm-6 col-6">
                                <p class="bold"><?php echo "Visa/Master Tax" ?></p>
                                <p>
								
								<?php
									echo $order[0]["creditTax"] . "KD";
									?>
								</p>
								</div>
								<?php
								}
							?>
								
                        </div>
                    </div>

                    <div class="profile-sec">
                        <h5 class="page-title"><?php echo $orderDetails ?></h5>
                        <div class="row">
                            <div class="col-sm-4 d-flex justify-content-between">
                                <p class="bold"><?php echo $numberOfProductsText ?></p>
                                <p class="bold">:</p>
                            </div>
                            <div class="col-sm-8">
                                <p><?php echo sizeof($id) ?></p>
                            </div>
                            <div class="col-sm-4 d-flex justify-content-between">
                                <p class="bold"><?php echo $deliveryTimeText ?></p>
                                <p class="bold">:</p>
                            </div>
                            <div class="col-sm-8">
                                <p><?php echo direction($settingsDTime,$settingsDTimeAr) ?></p>
                            </div>
							<?php
							if ( $emailOpt == 1 ){
							?>
								<div class="col-sm-4 d-flex justify-content-between">
                                <p class="bold"><?php echo $emailText ?></p>
                                <p class="bold">:</p>
                            </div>
                            <div class="col-sm-8">
                                <p><?php echo $order[0]["email"] ?></p>
                            </div>
							<?php
							}
							?>
							<div class="col-sm-4 d-flex justify-content-between">
                                <p class="bold"><?php echo $deliverToText ?></p>
                                <p class="bold">:</p>
                            </div>
                            <div class="col-sm-8">
                                <p><?php echo $order[0]["fullName"] ?></p>
                            </div>
							<div class="col-sm-4 d-flex justify-content-between">
                                <p class="bold"><?php echo $Mobile ?></p>
                                <p class="bold">:</p>
                            </div>
                            <div class="col-sm-8">
                                <p><?php echo $order[0]["mobile"] ?></p>
                            </div>
							<?php
							if ( !empty($order[0]["civilId"]) ){
							?>
								<div class="col-sm-4 d-flex justify-content-between">
                                <p class="bold"><?php echo $civilIdText ?></p>
                                <p class="bold">:</p>
								</div>
								<div class="col-sm-8">
									<p><?php echo $order[0]["civilId"] ?></p>
								</div>
							<?php
							}
							?>
                            <div class="col-sm-4 d-flex justify-content-between">
                                <p class="bold"><?php echo $addressText ?></p>
                                <p class="bold">:</p>
                            </div>
                            <div class="col-sm-8">
                                <p>
								<?php
								if ( $order[0]["place"] == "1" ){
                                    echo $order[0]["country"] . ", " . $order[0]["area"] . "<br> $blockText " . $order[0]["block"] . ", $streetText " . $order[0]["street"] ;
                                    if ( !empty($order[0]["avenue"]) ){
                                        echo ", $avenueText " . $order[0]["avenue"];
                                    }
                                    echo ", $houseText " . $order[0]["house"];
									echo ", $postalCodeText " . $order[0]["postalCode"];
								}elseif ($order[0]["place"] == "2"){
                                    echo $order[0]["country"] . ", " . $order[0]["area"] . "<br> $blockText " . $order[0]["blockA"] . ", $streetText " . $order[0]["streetA"];
                                    if ( !empty($order[0]["avenueA"]) ){
                                        echo ", $avenueText " . $order[0]["avenueA"];
                                    }
                                    echo ", $buildingText " . $order[0]["building"] . ", $floorText " . $order[0]["floor"] . ", $apartmentText " . $order[0]["apartment"];
									echo ", $postalCodeText " . $order[0]["postalCode"];
								}else{
								    echo 'Pick up';
								}
								?>
								</p>
                            </div>
                        </div>
                    </div>
                    <div class="profile-sec">
                        <h5 class="page-title"><?php echo $productsText ?></h5>
                            <div class="checkoutsidebar">
							<?php
							for( $i=0; $i<sizeof($subId); $i++ ){
								$products = selectDB("products","`id` = '{$order[$i]["productId"]}'");
								$subProducts = selectDB("subproducts","`id` = '{$order[$i]["subId"]}'");
							?>
                                <div class="checkoutsidebar-item">
                                    <span class="quantity"> <?php echo $order[$i]["quantity"]; ?></span>
                                    <span class="multiplier">x</span>
                                    <span class="iteminfo">
									<?php
									echo direction($products[0]["enTitle"],$products[0]["arTitle"]);
									echo " ";
									echo direction($subProducts[0]["size"],$subProducts[0]["sizeAr"]);
									echo " ";
									echo direction($subProducts[0]["colorEn"],$subProducts[0]["color"]);
									if ( !empty($order[$i]["collection"]) ){
										$items = explode(",",$order[$i]["collection"]);
										for( $y = 0; $y < sizeof($items) ; $y++ ){
											if ( !empty($items[$y]) ){
												$productsInfo = selectDB('products', "`id` = '{$items[$y]}'");
												echo "[";
												echo direction
												($productsInfo[0]["enTitle"],$productsInfo[0]["arTitle"]);
												echo "]";
											}
										}
									}
									echo " ";
									echo $order[$i]["productNote"];
									?>
									</span>
                                    <span class="Price">
									<?php 
									/*
									if ( $order[$i]["productDiscount"] != 0 ){
										echo $price2 = $subProducts[$i]["price"] * ( (100 - $order[$i]["productDiscount"]) / 100 );
									}elseif ( $order[$i]["discount"] != 0 ){
										echo $price2 = $subProducts[$i]["price"] * ( (100 - $order[$i]["discount"]) / 100 );
									}else{
										echo $price2 = $subProducts[$i]["price"];
									}
									*/
									echo round(($order[$i]["productPrice"]/$order[$i]["quantity"]),2);
									?>KD
									</span>
                                </div>
							<?php
							}
							?>
                            </div>
                            <div class="checkoutsidebar-calculation">
                            </div>
                            <button 
                            type="button" 
                            onclick="window.print()" 
                            class="btn btn-dark">
                            <?php echo $printText ?>
                            </button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<?php unset($_SESSION["cart"]);session_destroy(); ?>