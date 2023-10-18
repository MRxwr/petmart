 
    
         <div id="footer">
            <div class="container">
               <div class="row">
                  <div class="col-12 text-center" dir="ltr">
                     Powered with <img src="img/heart-footer.svg" class="heart-footer"> by  Create. <br>
                     <img src="img/payment-icons.webp" class="img-fluid payment-icons" align="img">
                  </div>
               </div>
            </div>
         </div>

<div class="modal search-modal" id="serch_popup">
  <div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-body">
        <form method="get" action="order">
            <table style="width:100%">
            <tr>
            <td>
            <div class="search-box d-flex align-items-center">
                <span class="cat"><?php echo $orderStatusText ?></span>
                <div class="form-group mb-0">
                    <input type="text" name="orderId" class="form-control" placeholder="<?php echo $orderNumberText ?>" required>
                </div>
            </div>
            </td>
            <td>
            <button style="border:0px; background-color:white" class="search-fa-icon"><span class="fa fa-car"></span></button>
            </td>
            </tr>
            </table>
            </form>
        </div>
    </div>
  </div>
</div>

<div class="modal fade cart-popup <?php echo $directionCART ?>" id="cart_popup">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
        <div class="modal-header d-flex justify-content-between align-items-center">
            <div class="CartItem">
                <svg xmlns="http://www.w3.org/2000/svg" width="19px" height="24px" viewBox="0 0 23.786 30"><g data-name="shopping-bag (3)" transform="translate(-53.023)"><g data-name="Group 2704"><g data-name="Group 17" transform="translate(53.023 5.918)"><g data-name="Group 16"><path data-name="Path 3" d="M76.8,119.826l-1.34-16.881A2.109,2.109,0,0,0,73.362,101H70.716v3.921a.879.879,0,1,1-1.757,0V101H60.875v3.921a.879.879,0,1,1-1.757,0V101H56.472a2.109,2.109,0,0,0-2.094,1.937l-1.34,16.886a4.885,4.885,0,0,0,4.87,5.259H71.926a4.884,4.884,0,0,0,4.87-5.261Zm-7.92-8.6-4.544,4.544a.878.878,0,0,1-1.243,0l-2.13-2.13A.878.878,0,0,1,62.2,112.4l1.509,1.508,3.923-3.923a.879.879,0,1,1,1.242,1.243Z" transform="translate(-53.023 -101.005)" fill="currentColor"></path></g></g><g data-name="Group 19" transform="translate(59.118)"><g data-name="Group 18"><path data-name="Path 4" d="M162.838,0a5.806,5.806,0,0,0-5.8,5.8v.119H158.8V5.8a4.042,4.042,0,1,1,8.083,0v.119h1.757V5.8A5.806,5.806,0,0,0,162.838,0Z" transform="translate(-157.039)" fill="currentColor"></path></g></g></g></g></svg>
                <span class="cartItemNo"><?php if ( isset($_SESSION["cart"]["id"]) ){ echo sizeof($_SESSION["cart"]["id"]); }else{ echo "0";} ?></span>
            </div>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        </div>
        <div class="modal-body">
            <div class="items-wrapper">
			<form action="checkout" method="post">
                <!-- start cart item -->
                <?php
                $i = 0;
				if ( isset($_SESSION["cart"]["id"]) ){
					$counterss = sizeof($_SESSION["cart"]["id"]);
				}else{
					$counterss = 0;
				}
                while ( $i < $counterss ){
                    $sql = "SELECT
							p.*, i.imageurl , 	sp.price AS subPrice, sp.color, sp.colorEn, sp.size, sp.sizeAr
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
					if ( isset($row["discount"]) AND $row["discount"] != "0" ){
						$price1 = ($row["subPrice"] - ( $row["subPrice"] * $row["discount"] / 100 )) ;
					}else{
						$price1 = $row["subPrice"];
					} 
					?>
					<div class="ItemBox itembox_<?php echo $_SESSION["cart"]["id"][$i] ."-". $_SESSION["cart"]["subId"][$i] ?>">
						<div style="width:100px">
							<input type="text" name="qorder<?php echo $i ?>" class="form-control input-number" value="<?php echo $_SESSION["cart"]["qorder"][$i] ?>" min="1" max="10" style="border-radius:0;border: 1px solid #e7eaf3;text-align:center;height:37px;width:45px; background-color: transparent;" readonly >
						</div>
						<!-- img -->
						<img src="logos/<?php echo $row["imageurl"] ?>" class="CartItem-Image">
						<!-- info -->
						<div class="Information">
							<span class="Name">
							<?php
							echo direction($row["enTitle"],$row["arTitle"]);
							echo " ";
							echo direction($row["size"],$row["sizeAr"]);
							echo " ";
							echo direction($row["colorEn"],$row["color"]);
							echo " ";
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
								echo $price1;
								$subTotal = $price1 * $_SESSION["cart"]["qorder"][$i];
								$totals1[] = $price1 * $_SESSION["cart"]["qorder"][$i];
								?>KD <?php echo $perPieceText ?>
							</span>
						</div>
						<!-- total per item -->
						<span class="Total itemTotal_<?php echo $_SESSION["cart"]["id"][$i] ?>">
						<?php 
						if (isset($subTotal)){
							echo $subTotal;
						}else{ 
							echo 0; 
						} 
						?>
						KD
						</span>
						<!-- remove item -->
						<button class="RemoveButton" id="<?php echo $_SESSION["cart"]["id"][$i] ."-". $_SESSION["cart"]["subId"][$i] ?>"><svg xmlns="http://www.w3.org/2000/svg" width="10.003" height="10" viewBox="0 0 10.003 10"><path data-name="_ionicons_svg_ios-close (5)" d="M166.686,165.55l3.573-3.573a.837.837,0,0,0-1.184-1.184l-3.573,3.573-3.573-3.573a.837.837,0,1,0-1.184,1.184l3.573,3.573-3.573,3.573a.837.837,0,0,0,1.184,1.184l3.573-3.573,3.573,3.573a.837.837,0,0,0,1.184-1.184Z" transform="translate(-160.5 -160.55)" fill="currentColor"></path></svg></button>

					</div>
                <?php
                    $i++;
                }
                ?>
                <!-- end cart item -->
            </div>
        </div>
        <div class="CheckoutButtonWrapper">
                <?php
                $sql = "SELECT `minPrice` FROM `s_media` WHERE `id` = 2";
                $result = $dbconnect->query($sql);
                $row = $result->fetch_assoc();
                if ( !isset($totals1) OR ($row["minPrice"] > array_sum($totals1)) ){
                ?>
            <div class="CheckoutButton checkout-pad-cust" data-toggle="modal" data-target="#minPrice_popup">
                <a class="CheckoutTitle"><b><?php echo $proceedToPaymentText ?></b></a>
                <span class="PriceBox">
				<?php 
				if (isset($totals1)) {
                    echo array_sum($totals1);
                } else { 
                    echo 0; 
                }
				?>KD
				</span>
            </div>
            <?php }else{ ?>
            <button class="CheckoutButton checkout-pad-cust" <?php
			if ( isset($_SESSION["cart"]["id"]) AND sizeof($_SESSION["cart"]["id"]) < 1 ){
				echo "disabled";
			} 
			?>
			>
                <a class="CheckoutTitle"><b><?php echo $proceedToPaymentText ?></b></a>
                <span class="PriceBox">
				<?php 
				if (isset($totals1)) {
					echo array_sum($totals1);
				}else{
					echo 0;
				}
				?>KD
				</span>
            </button>
            <?php } ?>
			</form>
        </div>
    </div>
  </div>
</div>

<!-- sign up popup -->
<div class="modal form-popup myModal--effect-zoomIn" id="reg_popup" style="">
    <div class="modal-dialog">
        <div class="modal-content">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <div class="modal-body text-center">
                <div class="modal-box-padding">
                    <h4 class="title"><?php echo $signUpText ?></h4>
                    <p class="mb-4"><?php echo $PleaseEnterYourDetails ?>:</p>
                    <div class="form-group">
                        <input type="email" class="form-control newEmail" name="email" placeholder="<?php echo $emailText ?>" title="Email" required >
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control newPass" name="password" placeholder="<?php echo $paswordText ?>" minlength="8" required>
                    </div>
                    <div class="form-group">
                        <input type="text" class="form-control newName" name="name" placeholder="<?php echo $fullNameText ?>" required>
                    </div>
                    <div class="form-group">
                        <input type="number" class="form-control newPhone" name="phone" placeholder="<?php echo $phoneNumberText ?>" minlength="8" maxlength="12" required>
                    </div>
                    <button class="btn theme-btn w-100 newUser"><?php echo $continueText ?></button>
                    <p class="mt-4 mb-4"><?php echo $youGotAnAccount ?> <a href="" class="link"  data-dismiss="modal" data-toggle="modal" data-target="#login_popup"><?php echo $loginText ?></a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- login popup -->
<div class="modal form-popup myModal--effect-zoomIn" id="login_popup">
    <div class="modal-dialog">
        <div class="modal-content">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <div class="modal-body text-center">
                <div class="modal-box-padding">
                    <h4 class="title"><?php echo $WelcomeBackText ?></h4>
                    <p class="mb-4"><?php echo $LoginWithYourEmailAndPasswordText ?></p>
                    <div class="form-group">
                        <input type="email" class="form-control LoginE" name="email" placeholder="<?php echo $emailText ?>">
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control LoginPass" name="password" placeholder="<?php echo $paswordText ?>">
                    </div>
                    <a href="profile.html"><button class="btn theme-btn w-100 LoginAj"><?php echo $continueText ?></button></a>
                    <p class="mt-4 mb-4"><?php echo $DontHaveAnAccountText ?><a href="" class="link" data-dismiss="modal" data-toggle="modal" data-target="#reg_popup"><?php echo $signUpText ?></a></p>
                </div>
                <div class="forgot-link">
                    <p><?php echo $ForgotYourPasswordText ?><a href="" class="link" data-dismiss="modal" data-toggle="modal" data-target="#forgot_popup"><?php echo $restItText ?></a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- forgot modal -->
<div class="modal form-popup myModal--effect-zoomIn" id="forgot_popup">
    <div class="modal-dialog">
        <div class="modal-content">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <div class="modal-body text-center">
                <div class="modal-box-padding">
                    <form action="includes/loginfp.php" method="post">
                    <h4 class="title"><?php echo $ForgotPasswordText ?></h4>
                    <p class="mb-4"><?php echo $weWillSendYouANewPassText ?></p>
                    <div class="form-group">
                        <input type="email" class="form-control userEmail" name="email" placeholder="email">
                    </div>
                    <button class="btn theme-btn w-100 resetP"><?php echo $resetItNowText ?></button>
                    <p class="mt-4 mb-4"><?php echo $backToText ?> <a href="" class="link" data-dismiss="modal" data-toggle="modal" data-target="#login_popup"><?php echo $loginText ?></a></p>
                </div>
            </div>
                </form>
        </div>
    </div>
</div>

<!-- edit profile modal -->
<div class="modal form-popup myModal--effect-zoomIn" id="editProfile_popup">
    <div class="modal-dialog">
        <div class="modal-content">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <div class="modal-body text-center">
                <div class="modal-box-padding m-3">
                <h4 class="title"><?php echo $editProfileText ?></h4>
                    <p class="mb-4"><?php echo $insertANewPass ?></p>
                    <div class="form-group">
                        <input type="email" class="form-control editEmail" name="email" placeholder="<?php echo $emailText ?>" value="<?php echo $email ?>" disabled>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control editPass" name="password" placeholder="<?php echo $paswordText ?>" value="">
                    </div>
                    <a href="profile.html"><button class="btn theme-btn w-100 editPassword"><?php echo $continueText ?></button></a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- minPrice modal -->
<?php
$sql = "SELECT `minPrice` FROM `s_media` WHERE `id` = 2";
$result = $dbconnect->query($sql);
$row = $result->fetch_assoc();
?>
<div class="modal form-popup myModal--effect-zoomIn" id="minPrice_popup">
    <div class="modal-dialog">
        <div class="modal-content">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <div class="modal-body text-center">
                <div class="modal-box-padding m-3">
                <svg xmlns="http://www.w3.org/2000/svg" height="25px" viewBox="0 0 512 512" width="25px"><g><path d="m277.332031 128c0 11.78125-9.550781 21.332031-21.332031 21.332031s-21.332031-9.550781-21.332031-21.332031 9.550781-21.332031 21.332031-21.332031 21.332031 9.550781 21.332031 21.332031zm0 0" data-original="#000000" class="active-path" data-old_color="#000000" fill="#C12020"/><path d="m256 405.332031c-8.832031 0-16-7.167969-16-16v-165.332031h-21.332031c-8.832031 0-16-7.167969-16-16s7.167969-16 16-16h37.332031c8.832031 0 16 7.167969 16 16v181.332031c0 8.832031-7.167969 16-16 16zm0 0" data-original="#000000" class="active-path" data-old_color="#000000" fill="#C12020"/><path d="m256 512c-141.164062 0-256-114.835938-256-256s114.835938-256 256-256 256 114.835938 256 256-114.835938 256-256 256zm0-480c-123.519531 0-224 100.480469-224 224s100.480469 224 224 224 224-100.480469 224-224-100.480469-224-224-224zm0 0" data-original="#000000" class="active-path" data-old_color="#000000" fill="#C12020"/><path d="m304 405.332031h-96c-8.832031 0-16-7.167969-16-16s7.167969-16 16-16h96c8.832031 0 16 7.167969 16 16s-7.167969 16-16 16zm0 0" data-original="#000000" class="active-path" data-old_color="#000000" fill="#C12020"/></g> </svg>

                <h4 class="title"><?php echo $minPriceText ?></h4>
                    <p class="mb-4"><?php echo $minPriceText . ": " . $row["minPrice"] ?>KD</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- orders popup -->
<div class="modal form-popup myModal--effect-zoomIn" id="orders_popup">
    <div class="modal-dialog">
        <div class="modal-content">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <div class="modal-body text-center">
                <div class="modal-box-padding m-3 w-100">
                    <h4 class="title"><?php echo $OrdersHistoryText ?></h4>
                    <p class="mb-4"><?php echo $checkOrdersBelowText ?></p>
                    <div class="row mb-3">
                    <div class="col-4">
                    <?php echo $Price ?>
                    </div>
                    <div class="col-4">
                    <?php echo $OrderID ?>
                    </div>
                    <div class="col-4">
                    <?php echo $dateText ?>
                    </div>
                    </div>
                    <?php 
					if ( isset($userID) ){
						$sql = "SELECT *
							FROM `orders`
							WHERE `userId` = '".$userID."'
							GROUP BY `orderId`
							ORDER BY `date` DESC
							";
						
					}else{
						$sql = "SELECT *
							FROM `orders`
							WHERE `orderId` = 'sdad' 
							";
					}
					$result = $dbconnect->query($sql);
                    while ( $row = $result->fetch_assoc() )
                    {
                    ?>
                    <div class="row mb-3">
                    <div class="col">
                    <?php echo $row["totalPrice"]; ?>KD
                    </div>
                    <div class="col">
                    <?php echo $row["orderId"]; ?>
                    </div>
                    <div class="col">
                    <a class="text-danger" href="order?orderId=<?php echo $row["orderId"]; ?>">
                    <?php $date = explode(" ",$row["date"]); echo str_replace("-","/",$date[0]) ?>
                    </a>
                    </div>
                    </div>
                    <?php 
                    }
                    ?>
            </div>
                </form>
        </div>
    </div>
</div>

</div>
<div class="h-body">
    <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-12 text-center">
            <div class="phone">
                </div>
                <div class="message">
                  Please rotate your device!
                </div>
        </div>
    </div>
</div>

<script type="text/javascript">

$(function(){
$('.resetP').click(function(e){
e.preventDefault();
var emailFP = $('.userEmail').val()
$.ajax({
type:"POST",
url: "api/functions.php",
data: {
emailAj: emailFP,
},
success:function(result){
alert(result);
}
});
});
})

$(function(){
$('.editPassword').click(function(e){
e.preventDefault();
var editEmailV = $('.editEmail').val()
var editPassV = $('.editPass').val()
$.ajax({
type:"POST",
url: "api/functions.php",
data: {
editEmailAj: editEmailV,
editPassAj: editPassV,
},
success:function(result){
alert(result);
}
});
});
})

$(function(){
$('.LoginAj').click(function(e){
e.preventDefault();
var LoginEV = $('.LoginE').val();
var loginPV = $('.LoginPass').val();
$.ajax({
type:"POST",
url: "api/functions.php",
data: {
loginEmailAj: LoginEV,
loginPassAj: loginPV,
},
success:function(result){
var data = result.split(',');
if ( data[0] == 1 )
{
    if ( !alert(data[1]) )
    {
        window.location.reload();
    }
}
else
{
    alert(data[1])
}
}
});
});
})

$(function(){
$('.newUser').click(function(e){
e.preventDefault();
var newEmail = $('.newEmail').val()
var newPhone = $('.newPhone').val()
var newName = $('.newName').val()
var newPassword = $('.newPass').val()

$.ajax({
type:"POST",
url: "api/functions.php",
data: {
nameReg: newName,
phoneReg: newPhone,
emailReg: newEmail,
passwordReg: newPassword,
},
success:function(result){
alert(result);
$("#reg_popup").removeClass('show');
$('.modal-backdrop').removeClass('show');
}
});
});
})

    $( document ).ready(function() {
        new WOW().init();
    });

    $(function(){
        $('.selectpicker').selectpicker();
		
		$('.RemoveButton').click(function(e){
            e.preventDefault();

            var codeid = $(this).attr("id");
			
			codeIdItem = codeid.split('-'); 
			var itemId = codeIdItem[0];
			//console.log(itemId);
			var itemSize = codeIdItem[1];
			//console.log(itemSize);
            $(".itembox_"+itemId+"-"+itemSize).remove();

            // remove from session
            $.ajax({
                type:"POST",
                url: "api/functions.php",
                data: {
                    removeItemBoxId: itemId,
					removeItemBoxSubId: itemSize,
                },
                success:function(result){
                    //console.log(result);
                    //$('.PriceBox').text(parseInt(result) + "KD");
                    var jqueryTotal = 0;
                    $('.Total').each(function(i, e){
                        jqueryTotal += parseInt($(e).text().trim().slice(0,-2));
                        //console.log(parseInt($(e).text().trim().slice(0,-2)));
                    });
                    $('.PriceBox').text(jqueryTotal + "KD");
                    $('.cart_price').text(jqueryTotal + "KD");
                    $('.cartItemNo').text(result);
                }
            })
        });
    });
    // for cart
    $(document).ready(function(){
        $("#voucher_text").click(function(){
            $("#voucher_text").attr('style','display:none');
            $("#voucher_code").attr('style','display:flex');
        });
    });
    //change directory
    $(document).ready(function(){
      $('.en').click(function() {
         $("html[lang=he]").attr("dir", "ltr");
          $("#body").addClass("left-to-right");
          $("#cart_popup").removeClass("left");
        $("#cart_popup").addClass("right");
      });
      $('.arab').click(function() {
         $("html[lang=he]").attr("dir", "rtl");
        $("#body").removeClass("left-to-right");
        $("#cart_popup").removeClass("right");
        $("#cart_popup").addClass("left");
      });
        
    });
    // cart popup
    $(window).scroll(function(){
      var sticky = $('.fixme'),
          scroll = $(window).scrollTop();

      if (scroll >= 500) sticky.addClass('fixed');
      else sticky.removeClass('fixed');
    });
    // owl carousel
    jQuery("#carousel").owlCarousel({
        autoplay: true,
        lazyLoad: true,
        loop: true,
        margin: 20,
        responsiveClass: true,
        autoHeight: true,
        autoplayTimeout: 3000,
        smartSpeed: 800,
        nav: true,
        dots: false,
        rtl: true,
      responsive: {
        0: {
          items: 1
        },

        600: {
          items: 2
        },

        1024: {
          items: 3
        },

        1366: {
          items: 3
        }
      }
    });
    // cat_slider
    jQuery("#cat_carousel").owlCarousel({
        autoplay: false,
        lazyLoad: true,
        loop: false,
        margin: 6,
        responsiveClass: true,
        nav: false,
        dots: false,
        rtl: true,
      responsive: {
        0: {
          items: 4
        },
        340: {
          items: 5
        },
        520: {
          items: 7
        },
        768: {
          items: 9
        }
      }
    });
    //TOGGLING NESTED ul
    $(".drop-down .selected a").click(function() {
        // $(".drop-down .options").toggle();
        $(".drop-down .options").toggleClass("show");
    });

//HIDE OPTIONS IF CLICKED on categories and scroll page on category product
      
$("#mobile-drop-cust-close .product-category-mobile").click(function() {
        // $(".drop-down .options").toggle();
         $(".drop-down .options").removeClass("show");

         $('html, body').animate({
        scrollTop: $(".main-product-sec").offset().top - 300
    }, 1000);
    });

    //HIDE OPTIONS IF CLICKED ANYWHERE ELSE ON PAGE
    $(document).bind('click', function(e) {
        var $clicked = $(e.target);
        if (! $clicked.parents().hasClass("drop-down"))
            $(".drop-down .options").removeClass("show");
    });
    /* Add to cart fly effect with jQuery. */   
    $('.add-to-cart').on('click', function () {
        var cart = $('.shopping-cart');
        var imgtodrag = $(this).parent('.product-meta').parent('.product-text').parent('.product-box').find(".product-box-img").eq(0);
        if (imgtodrag) {
            var imgclone = imgtodrag.clone()
                .offset({
                top: imgtodrag.offset().top,
                left: imgtodrag.offset().left
            })
                .css({
                    'opacity': '0.8',
                    'position': 'absolute',
                    'height': '120px',
                    'width': '120px',
                    'z-index': '100',
                    'border-radius': '50%'
            })
                .appendTo($('body'))
                .animate({
                'top': cart.offset().top + 10,
                    'left': cart.offset().left + 10,
                    'width': 75,
                    'height': 75
            }, 1000, 'easeInOutExpo');    
            // setTimeout(function () {
            //     cart.effect("shake", {
            //         times: 2
            //     }, 200);
            // }, 1500);
            imgclone.animate({
                'width': 0,
                    'height': 0
            }, function () {
                $(this).detach()
            });
        }
    });
    // for cart
    $(document).ready(function(){
        $(".add-to-cart-btn").click(function(){
            $(this).attr('style','display:none');
            $(this).next().attr('style','display:flex');
        });
        $(".counter_add").click(function() {
            var new_count = parseInt($(this).prev().html()) + 1;
            $(this).prev().html(new_count)
        });

        $(".counter_minuse").click(function() {
            var exist_count = parseInt($(this).next().html());
            if(exist_count > 1){
                $(this).next().html(exist_count - 1)
            }else{
                $(this).parent().prev().attr('style','display:flex');
                $(this).parent().attr('style','display:none');
            }
        });
        // for cart popup
        $(".cart_counter_add").click(function() {
            var new_count = parseInt($(this).prev().html()) + 1;
            $(this).prev().html(new_count)
        });

        $(".cart_counter_minuse").click(function() {
            var exist_count = parseInt($(this).next().html());
            if(exist_count > 1){
                $(this).next().html(exist_count - 1)
            }else{
                $(this).parent().prev().attr('style','display:flex');
                $(this).parent().parent().attr('style','display:none');
            }
        });
    });
    // product view slider
    $(document).ready(function() {
        var sync1 = $("#sync1");
        var sync2 = $("#sync2");
        var slidesPerPage = 4; //globaly define number of elements per page
        var syncedSecondary = true;

        sync1.owlCarousel({
            items: 1,
            slideSpeed: 2000,
            nav: false,
            autoplay: false, 
            dots: true,
            loop: true,
            rtl: true,
            responsiveRefreshRate: 200,
            navText: ['<svg width="100%" height="100%" viewBox="0 0 11 20"><path style="fill:none;stroke-width: 1px;stroke: #000;" d="M9.554,1.001l-8.607,8.607l8.607,8.606"/></svg>', '<svg width="100%" height="100%" viewBox="0 0 11 20" version="1.1"><path style="fill:none;stroke-width: 1px;stroke: #000;" d="M1.054,18.214l8.606,-8.606l-8.606,-8.607"/></svg>'],
        }).on('changed.owl.carousel', syncPosition);

        sync2
            .on('initialized.owl.carousel', function() {
                sync2.find(".owl-item").eq(0).addClass("current");
            })
            .owlCarousel({
                items: slidesPerPage,
                dots: false,
                nav: false,
                rtl: true,
                smartSpeed: 200,
                slideSpeed: 500,
                slideBy: slidesPerPage, //alternatively you can slide by 1, this way the active slide will stick to the first item in the second carousel
                responsiveRefreshRate: 100
            }).on('changed.owl.carousel', syncPosition2);
    function syncPosition(el) {
        //if you set loop to false, you have to restore this next line
        //var current = el.item.index;

        //if you disable loop you have to comment this block
        var count = el.item.count - 1;
        var current = Math.round(el.item.index - (el.item.count / 2) - .5);

        if (current < 0) {
            current = count;
        }
        if (current > count) {
            current = 0;
        }
        //end block
        sync2
            .find(".owl-item")
            .removeClass("current")
            .eq(current)
            .addClass("current");
            var onscreen = sync2.find('.owl-item.active').length - 1;
            var start = sync2.find('.owl-item.active').first().index();
            var end = sync2.find('.owl-item.active').last().index();

            if (current > end) {
                sync2.data('owl.carousel').to(current, 100, true);
            }
            if (current < start) {
                sync2.data('owl.carousel').to(current - onscreen, 100, true);
            }
        }
        function syncPosition2(el) {
            if (syncedSecondary) {
                var number = el.item.index;
                sync1.data('owl.carousel').to(number, 100, true);
            }
        }

        sync2.on("click", ".owl-item", function(e) {
            e.preventDefault();
            var number = $(this).index();
            sync1.data('owl.carousel').to(number, 300, true);
        });
    });
/////////////////////////////////////////
$('.btn-number').click(function(e){
    e.preventDefault();
    
    fieldName = $(this).attr('data-field');
    type      = $(this).attr('data-type');
	qorder = $(this).attr('data-qorder');
	qitemId = $(this).attr('data-itemId');
	itemIndex = $(this).attr('data-itemIndex');
	itemPrice = $(this).attr('data-price');
	

    var input = $("input[name='"+fieldName+"']");
    var currentVal = parseInt(input.val());
    if (!isNaN(currentVal)) {
        if(type == 'minus') {
			$.ajax({
				type:"GET",
				url: "api/functions.php",
				data: {
					itemIndexM: itemIndex
					
				},
				success:function(result){
					var itemTotalPrice = parseInt(itemPrice) * parseInt(result);
					$('.itemTotal_' + qitemId).text(itemTotalPrice +"KD");
					
					var jqueryTotal = 0;
					$('.Total').each(function(i, e){
						jqueryTotal += parseInt($(e).text().trim().slice(0,-2));
					});
					$('.PriceBox').text(jqueryTotal + "KD");
				}
			});
            
            if(currentVal > input.attr('min')) {
                input.val(currentVal - 1).change();
            } 
            if(parseInt(input.val()) == input.attr('min')) {
                $(this).attr('disabled', true);
            }

        } else if(type == 'plus') {

			$.ajax({
				type:"GET",
				url: "api/functions.php",
				data: {
					itemIndexP: itemIndex
					
				},
				success:function(result){
					var itemTotalPrice = parseInt(itemPrice) * parseInt(result);
					$('.itemTotal_' + qitemId).text(itemTotalPrice +"KD");
					
					var jqueryTotal = 0;
					$('.Total').each(function(i, e){
						jqueryTotal += parseInt($(e).text().trim().slice(0,-2));
					});
					$('.PriceBox').text(jqueryTotal + "KD");

				}
			});
			
            if(currentVal < input.attr('max')) {
                input.val(currentVal + 1).change();
            }
            if(parseInt(input.val()) == input.attr('max')) {
                $(this).attr('disabled', true);
            }

        }
    } else {
        input.val(0);
    }
});
$('.input-number').focusin(function(){
   $(this).data('oldValue', $(this).val());
});
$('.input-number').change(function() {
    
    minValue =  parseInt($(this).attr('min'));
    maxValue =  parseInt($(this).attr('max'));
    valueCurrent = parseInt($(this).val());
    
    name = $(this).attr('name');
    if(valueCurrent >= minValue) {
        $(".btn-number[data-type='minus'][data-field='"+name+"']").removeAttr('disabled')
    } else {
        alert('Sorry, the minimum value was reached');
        $(this).val($(this).data('oldValue'));
    }
    if(valueCurrent <= maxValue) {
        $(".btn-number[data-type='plus'][data-field='"+name+"']").removeAttr('disabled')
    } else {
        alert('Sorry, the maximum value was reached');
        $(this).val($(this).data('oldValue'));
    }
    
    
});
$(".input-number").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
             // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) || 
             // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
                 // let it happen, don't do anything
                 return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });

    if ( window.history.replaceState ) {
    window.history.replaceState( null, null, window.location.href );
    }
</script>

</body>
</html> 