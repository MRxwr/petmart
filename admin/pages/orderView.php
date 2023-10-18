<?php
	$array = selectDB('orders'," `orderId` LIKE '".$_GET["id"]."' ");
?>

<div class="right-sidebar-backdrop"></div>

<!-- Main Content -->
<div class="page-wrapper">
	<div class="container-fluid">
		<!-- Row -->
		
		<div class="row">
		<div class="col-md-12">
			<div class="panel panel-default card-view">
				<div class="panel-heading">
					<div class="pull-left">
						<h6 class="panel-title txt-dark">Invoice</h6>
					</div>
					<div class="pull-right">
						<h6 class="txt-dark">Order # <?php echo $array[0]["orderId"] ?></h6>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="panel-wrapper collapse in">
					<div class="panel-body">
						<div class="row">
							
							<div class="col-xs-6">
								<span class="txt-dark head-font inline-block capitalize-font mb-5 text-center"> 
								<?php
								$vendor = selectDB('vendors',"`id` LIKE '".$array[0]["vendorId"]."'");
								?>
								<img src="logos/72315b0cac752a3de7673bb1f8f15df8.png" style="width:50px;height:50px">
								
								<br> 
								<?php
								$vendor = selectDB('vendors',"`id` LIKE '".$array[0]["vendorId"]."'");
								echo $vendor[0]["enShop"];
								?>
								
								<address>
									<span class="txt-dark head-font capitalize-font mb-5">Date:</span>
									<?php echo $array[0]["date"] ?><br><br>
								</address>
								
								</span>
							</div>
							
							<div class="col-xs-6 text-right">
								<span class="txt-dark head-font inline-block capitalize-font mb-5">Delivery:</span>
								<address class="mb-15">
									
								<?php
								$address = selectDB('addresses',"`id` LIKE '".$array[0]["addressId"]."'");
								$address= $address[0];
								$keys = array_keys($address);
								for ( $i = 0 ; $i < sizeof($keys) ; $i++ ){
									if ( $i > 3 && !empty($address[$keys[$i]]) ){
										echo $keys[$i] . ": " . $address[$keys[$i]] ;
										if ( $i != sizeof($keys)-2 ){
											echo ",<br>";
										}
									}
								}
								?>
									
								</address>
							</div>
						</div>
												
<div class="invoice-bill-table">
<div class="table-responsive">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>Item</th>
				<th>Price</th>
			</tr>
		</thead>
		<tbody>
			<?php
			for ( $i = 0 ; $i < sizeof($array) ; $i++ ){
			?>
				<tr>
					<td>
					<?php
					echo $array[$i]["quantity"] . "x";
					$item = selectDB('items',"`id` LIKE '".$array[$i]["itemId"]."'");
					if ( $item[0]["is_variant"] == 0 ){
						$variantTitle = "";
					}else{
						$item_variants = selectDB('item_variants',"`id` LIKE '".$array[$i]["variantId"]."'");
						$variantTitle = " - " . $item_variants[0]["enTitle"];
					}
					$influencerTitle = selectDB('vendors',"`id` LIKE '".$array[$i]["vendorId"]."'");
					echo $item[0]["enTitle"] . $variantTitle . " [{$influencerTitle[0]["enShop"]}]";
					?>
					</td>
					<td>
					<?php
					echo $subTotal[] = $array[$i]["itemPrice"]*$array[$i]["quantity"];
					?>KD
					</td>
				</tr>
			<?php
			}
			?>
			<tr class="txt-dark">
				<td>Subtotal</td>
				<td><?php echo array_sum($subTotal); ?>KD</td>
			</tr>
			<?php
			if ($array[0]["voucherId"] != 0){
			$voucher = selectDB('vouchers',"`id` LIKE '".$array[0]["voucherId"]."'");
			?>				
			<tr class="txt-dark">
				<td>Voucher</td>
				<td><?php echo $voucher[0]["code"] ?></td>
			</tr>
			<?php
			}
			if($array[0]["voucherDiscount"] != 0){
			?>
			<tr class="txt-dark">
				<td>Discount</td>
				<?php
				if ($voucher[0]['discountType'] == 0 ){
					echo "<td>{$array[0]['voucherDiscount']}%</td>";
				}else{
					echo "<td>{$array[0]['voucherDiscount']}KD</td>";
				}
				?>
				
			</tr>
			<?php
			}
			?>
			<tr class="txt-dark">
				<td>Shipping</td>
				<td><?php echo $array[0]["delivery"] ?>KD</td>
			</tr>
			<tr class="txt-dark">
				<td>Total</td>
				<td><?php echo $array[0]["price"] ?>KD</td>
			</tr>
		</tbody>
	</table>
	</div>
							<div class="button-list pull-right">
								<!--<button type="button" class="btn btn-primary btn-outline btn-icon left-icon" onclick="javascript:window.print();"> 
									<i class="fa fa-print"></i><span> Print</span> 
								</button>-->
							</div>
							<div class="clearfix"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		
		<!-- /Row -->
	</div>

<!-- Footer -->
	<footer class="footer container-fluid pl-30 pr-30">
		<div class="row">
			
		</div>
	</footer>
	<!-- /Footer -->
	
</div>
<!-- /Main Content -->