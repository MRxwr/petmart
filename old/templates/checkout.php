<div class="sec-pad grey-bg">
<div class="container">
<div class="row d-flex justify-content-center">
<div class="col-lg-10 col-12">
<div class="checkout-page">
<div class="sidebar-item">
<div class="make-me-sticky check-make-me-sticky">
<h3 class="bold text-center mb-4 pb-3"><?php echo $cartText ?></h3>
<div class="checkoutsidebar">
<?php

if ( sizeof($_SESSION["cart"]["id"]) < 1 )
{
    header("LOCATION: index.php");
}

$i = 0;
while ( $i < sizeof($_SESSION["cart"]["id"]) ){
	$sql = "SELECT
			p.*, i.imageurl , sp.price AS subPrice, sp.size, sp.sizeAr, sp.color, sp.colorEn
			FROM `products` AS p
			JOIN `images` AS i
			ON p.id = i.productId
			JOIN `subproducts` AS sp
			ON p.id = sp.productId
			WHERE
			p.id = '".$_SESSION["cart"]["id"][$i]."'
			AND
			sp.id = '".$_SESSION["cart"]["subId"][$i]."'
			AND
			sp.hidden = '0'
			";
	$result = $dbconnect->query($sql);
	$row = $result->fetch_assoc();
	?>
	<div class="checkoutsidebar-item">
		<span class="quantity">
		<?php 
		if ( isset ($_POST["qorder$i"]) AND $_POST["qorder$i"] != $_SESSION["cart"]["qorder"][$i] ){
			echo $_POST["qorder$i"]; 
			$_SESSION["cart"]["qorder"][$i] = $_POST["qorder$i"];
		}else{
			echo $_SESSION["cart"]["qorder"][$i];
		}
		?>
		</span>
		<span class="multiplier">x</span>
		<span class="iteminfo">
		<?php
		echo direction($row["enTitle"],$row["arTitle"]);
		echo " ";
		echo direction($row["size"],$row["sizeAr"]);
		echo " ";
		echo direction($row["colorEn"],$row["color"]);
		if ( !empty($_SESSION["cart"]["collection"][$i]) ){
			$items = explode(",",$_SESSION["cart"]["collection"][$i]);
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
		echo $_SESSION["cart"]["productNotes"][$i];
		?>
		</span>
		<span class="Price">
		<?php 
			if ( isset($row["discount"]) AND $row["discount"] != "0" ){
				echo $price2 = $row["subPrice"] - ( $row["subPrice"] * $row["discount"] / 100 );
			}else{
				echo $price2 = $row["subPrice"];
			} ?>KD
		</span>
	</div>
	<?php
	$totals2[] = $price2 * $_SESSION["cart"]["qorder"][$i];
	$i++;
}
?>
</div>
<div class="checkoutsidebar-calculation">

<div class="calc-text-box d-flex justify-content-between">
    <span class="calc-text bold"></span>
    <span class="calc-text bold ShoppingSpan">
    <?php echo ""?>
    </span>
</div>

<div class="calc-text-box d-flex justify-content-between">
    <span class="calc-text bold"><?php echo $totalPriceText ?></span>
    <span class="calc-text bold totalSpan">
    <?php echo $totals2 = array_sum($totals2); ?>KD
    </span>
</div>

<div class="calc-text-box d-flex justify-content-between">
<span class="bold voucherMsgS" style="color:red;font-size:18px"><b class="voucherMsg"></b></span>
</div>

</div>
</div>
</div>
<form method="post" action="bill">
<div class="content-section">

<?php
if ( isset($_GET["status"]) )
{
?>
<div class="checkout-informationbox">
<div style="color:red; font-size:18px; text-align:center">
<img src="https://i.imgur.com/h8aeHER.png" style="width:50px;heightL50px">
<br>
<br>
<?php echo $paymentFailureMsgText ?>
</div>
</div>
<br>

<?php
}

if ( $giftCard == 1 ){
?>
<div class="checkout-informationbox">
<div class="media checkout-heading-box">
<span class="count-number">1</span>
<div class="media-body">
    <h3 class="checkout-heading"><?php echo $pleaseFillForGiftsText ?></h3>
    <p class="checkout-heading-text"></p>
</div>
</div>
    <div class="form-group">
    <input type="text" class="form-control" name="cardFrom" value="" placeholder="<?php echo $fromText ?>" >
    </div>
    <div class="form-group">
    <input type="text" class="form-control" name="cardTo" value=""  placeholder="<?php echo $toText ?>" >
    </div>
    <div class="form-group">
    <input type="text" class="form-control" name="cardMsg" value="" placeholder="<?php echo $msgText ?>" >
    </div>
</div>
<?php
}else{
	?>
	<input type="hidden" class="form-control" name="cardFrom" value="" placeholder="From" >
	<input type="hidden" class="form-control" name="cardTo" value=""  placeholder="To" >
	<input type="hidden" class="form-control" name="cardMsg" value="" placeholder="Message" >
	<?php
}
?>
<div class="checkout-informationbox">
<div class="media checkout-heading-box">
<span class="count-number">2</span>
<div class="media-body">
    <h3 class="checkout-heading"><?php echo $personalInfoText ?></h3>
    <p class="checkout-heading-text"></p>
</div>
</div>
<?php 
if ( $emailOpt == 0 ){
	$emailHidden = "hidden";
}else{
	$emailHidden = "text";
}

if ( isset($userID) AND !empty($userID) )
{
    $sql = "SELECT * FROM `users` WHERE `id` = '".$userID."'";
    $result = $dbconnect->query($sql);
    $row = $result->fetch_assoc();
    ?>
    <div class="form-group">
    <input type="text" class="form-control" name="name" value="<?php echo $row["fullName"] ?>" >
    </div>
    <div class="form-group">
    <input type="number" class="form-control" name="phone" value="<?php echo $row["phone"] ?>" minlength="8" required>
    </div>
    <div class="form-group">
    <input type="<?php echo $emailHidden ?>" class="form-control" name="email" value="<?php echo $row["email"] ?>" >
    </div>
	<div class="form-group " id="civilIdDiv">
	<input type="hidden" class="form-control" name="civilId" placeholder="<?php echo $civilIdText ?>" >
	</div>
    <?php
}else{
?>
	<div class="form-group">
	<input type="text" class="form-control" name="name" placeholder="<?php echo $fullNameText ?>" >
	</div>
	<div class="form-group">
	<input type="number" class="form-control" name="phone" placeholder="<?php echo $Mobile ?>" minlength="8" required >
	</div>
	<div class="form-group">
	<input type="<?php echo $emailHidden ?>" class="form-control" name="email" placeholder="<?php echo $emailText ?>" >
	</div>
	<div class="form-group " id="civilIdDiv">
	<input type="hidden" class="form-control" name="civilId" placeholder="<?php echo $civilIdText ?>" >
	</div>
<?php
}
?>
</div>
<div class="checkout-informationbox">
<div class="media checkout-heading-box">
<span class="count-number">3</span>
<div class="media-body">
    <h3 class="checkout-heading"><?php echo $addressText ?></h3>
    <p class="checkout-heading-text"></p>
</div>
</div>
<div class="form-group">
<p class="mb-2"><?php echo $countryText ?></p>
<select name="country" class="form-control CountryClick" required>
<option value="KW">Kuwait</option>
<?php
$sql = "SELECT *
		FROM `cities`
		WHERE `status` LIKE '1'
		GROUP BY `CountryCode`
		ORDER BY `CountryName` ASC
		";
$result = $dbconnect->query($sql);
while ($row = $result->fetch_assoc() )
{
?>
   <option value="<?php echo $row["CountryCode"] ?>"><?php echo $row["CountryName"] ?></option>
<?php
}
?>
</select>
<i class="fa fa-angle-down"></i>
</div>
<ul class="nav nav-tabs" style="padding-right:0px">
<li class="nav-item">
    <a class="nav-link active homeForm" id="homeFormId">
        <img src="img/home.png" class="main-img">
        <img src="img/home-active.png" class="active-img">
        <p><?php echo $houseText ?></p>
    </a>
</li>
<li class="nav-item">
    <a class="nav-link apartmentForm" id="apartmentFormId">
        <img src="img/apartment.png" class="main-img">
        <img src="img/apartment-active.png" class="active-img">
        <p><?php echo $apartmentText ?></p>
    </a>
</li>

<?php
$sql = "SELECT `inStore` FROM `s_media` WHERE `id` LIKE '3'";
$result = $dbconnect->query($sql);
$row = $result->fetch_assoc();
if ( $row["inStore"] == "1")
{
?>

<li class="nav-item">
    <a class="nav-link pickUpFROM" id="pickUpFROMid">
        <img src="https://i.imgur.com/8k3poG6.png" class="main-img" style="width:31px; height:31px">
        <img src="https://i.imgur.com/8k3poG6.png"  style="color: #f00;-webkit-filter: invert(100%);filter: invert(100%);width:31px; height:31px" class="active-img">
        <p><?php echo $pickUpText ?></p>
    </a>
</li>
<?php
}
?>
</ul>

<div class="tab-content">
<input type="hidden" class="form-control" name="totalPrice" value="<?php echo $totals2 ?>">
<input type="hidden" class="form-control orderVoucherInput" name="orderVoucher" value="">
<input type="hidden" class="form-control" id="pMethod" name="paymentMethod" value="1">
<input type="hidden" class="form-control" id="place" name="place" value="1">

<div id="" class="tab-pane active homeFormDiv">
<div class="form-group">
<p class="mb-2"><?php echo $selectAreaText ?></p>
            <select name="area" class="form-control getAreas" required>
			<option selected disabled value=""><?php echo $selectAreaText ?></option>
            <?php 
            $sql = "SELECT * FROM `areas` ORDER BY ";
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
				echo direction($row["enTitle"],$row["arTitle"]);
				?>
				</option>
            <?php
            }
            ?>
            </select>
				<!--<input type="text" class="form-control" name="area" placeholder="المنطقة" required>-->
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="block" placeholder="<?php echo $blockText ?>" required>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="street" placeholder="<?php echo $streetText ?>" required>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="avenue" placeholder="<?php echo $avenueText ?>" >
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="house" placeholder="<?php echo $houseText ?>" required>
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="postalCode" placeholder="<?php echo $postalCodeText ?>">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" name="notes" placeholder="<?php echo $specialInstructionText ?>">
			</div>
</div>
</div>
</div>

<div class="checkout-informationbox">
<div class="media checkout-heading-box">
<span class="count-number">4</span>
<div class="media-body">
    <h3 class="checkout-heading"><?php echo $paymentMethodText ?></h3>
    <p class="checkout-heading-text"></p>
</div>
</div>
<div class="row form-row d-flex align-items-center justify-content-center payment-box">
<div class="col-sm-6 col-12 col-md-12">
    <a class="payKnet"><label id="payKnet" class="radiocardwrapper active">
        <img src="img/knet.png" class="d-block">
        <span class="cardcontent d-block">KNET</span>
    </label></a>
</div>
<?php
$sql = "SELECT `visa` FROM `s_media` WHERE `id` LIKE '3'";
$result = $dbconnect->query($sql);
$row = $result->fetch_assoc();
if ( $row["visa"] == "1")
{
?>
<div class="col-sm-6 col-12 col-md-12">
        <a class="payVisa"><label id="payVisa" class="radiocardwrapper ">
        <img src="https://i.imgur.com/Q4nZ3El.png" style="width:33px; height:21px" class="d-block">
        <span class="cardcontent d-block">Visa / Master</span>
    </label></a>
</div>
<?php
}
?>

<?php
$sql = "SELECT `cash` FROM `s_media` WHERE `id` LIKE '3'";
$result = $dbconnect->query($sql);
$row = $result->fetch_assoc();
if ( $row["cash"] == "1")
{
?>
<div class="col-sm-6 col-12 col-md-12">
        <a class="payCash"><label id="payCash" class="radiocardwrapper ">
        <img src="https://i.imgur.com/AZyDbmw.png" style="width:33px; height:21px" class="d-block">
        <span class="cardcontent d-block">CASH</span>
    </label></a>
</div>
<?php
}
?>
</div>
<div class="mt-5">
<p class="pl-1 mt-4"><?php //echo $termsAndConditionsText ?></p>
<button class="btn theme-btn w-100 payBtnNow"><?php echo $payNowText ?></button>
</div>
</form>
</div>
</div>
</div>
</div>
</div>
</div>
</div>

<?php
$visaTaxMsg = direction("Visa/Master Tax (2.5%) Will be add","سيتم اضافة 2.5% عمولة الفيزا/الماستر");
$mobileNumberMsg = direction("Please enter your phone number correctly","الرجاء ادخال رقم الهاتف بالشكل الصحيح");
?>

<script>
$('.payBtnNow').on('click',function(){
	var mobileNumber = $('input[name=phone]').val();
	if ( $.isNumeric(mobileNumber) ){
		if ( mobileNumber.length > 7 ){
		}else{
			alert('<?php echo $mobileNumberMsg ?>');
			return false;
		}
	}else{
		alert('<?php echo $mobileNumberMsg ?>');
		return false;
	}
});
$(function(){
$('.CountryClick').change(function(e){
e.preventDefault();
var countryName = $(this).val()
if ( countryName != "KW" ){
	$('input[name="name"]').prop('required',true);
	$('input[name="email"]').prop('required',true);
	$('input[name="civilId"]').prop('required',true);
	$('input[name="civilId"]').attr('type','text');
	$('#payCash').hide();
	$('#civilIdDiv').show();
}else{
	$('input[name="name"]').removeAttr('required');
	$('input[name="postalCode"]').removeAttr('required');
	$('input[name="email"]').removeAttr('required');
	$('input[name="civilId"]').removeAttr('required');
	$('input[name="civilId"]').attr('type','hidden');
	$('#payCash').show();
	$('#civilIdDiv').hide();
}
$.ajax({
type:"POST",
url: "api/functions.php",
data: {
getAreasA: countryName,
},
success:function(result){
$('.getAreas').html(result);
}
});
});
})

$(function(){
$('.sendVoucher').click(function(e){
e.preventDefault();
var voucher = $('#voucherInput').val()
console.log(voucher)
$.ajax({
type:"POST",
url: "api/functions.php",
data: {
checkVoucherVal: voucher,
totals2: <?php echo $totals2 ?>
},
success:function(result){
console.log(result);

var data = result.split(',');
$('.totalSpan').text(data[0]+"KD");
$('.voucherMsg').html(data[1]);
$('.orderVoucherInput').val(data[2]);

}
});
});
})

$(function(){
$('.homeForm').click(function(e){
e.preventDefault();
$.ajax({
type:"POST",
url: "api/functions.php",
data: {
homeForm: 1,
},
success:function(result){
$('.homeFormDiv').html(result);
$('#homeFormId').addClass('active');
$('#apartmentFormId').removeClass('active');
$('#pickUpFROMid').removeClass('active');
$('#place').val('1');
}
});
});
})

$(function(){
$('.apartmentForm').click(function(e){
e.preventDefault();
$.ajax({
type:"POST",
url: "api/functions.php",
data: {
apartmentForm: 1,
},
success:function(result){
$('.homeFormDiv').html(result);
$('#apartmentFormId').addClass('active');
$('#homeFormId').removeClass('active');
$('#pickUpFROMid').removeClass('active');
$('#place').val('2');
}
});
});
})

$(function(){
$('.pickUpFROM').click(function(e){
e.preventDefault();
$.ajax({
type:"POST",
url: "api/functions.php",
data: {
pickUpform: 1,
},
success:function(result){
$('.homeFormDiv').html(result);
$('#pickUpFROMid').addClass('active');
$('#homeFormId').removeClass('active');
$('#apartmentFormId').removeClass('active');
$('#place').val('3');
}
}); 
});
})

$(function(){
$('.payVisa').click(function(){
$('#payVisa').addClass('active');
$('#payKnet').removeClass('active');
$('#payCash').removeClass('active');
$('#pMethod').val("2");
alert('<?php echo $visaTaxMsg ?>');
});
})

$(function(){
$('.payKnet').click(function(){
$('#payKnet').addClass('active');
$('#payVisa').removeClass('active');
$('#payCash').removeClass('active');
$('#pMethod').val("1")
});
})

$(function(){
$('.payCash').click(function(){
$('#payCash').addClass('active');
$('#payVisa').removeClass('active');
$('#payKnet').removeClass('active');
$('#pMethod').val("3")
});
})
</script>