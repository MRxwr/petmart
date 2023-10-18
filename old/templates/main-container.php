<div class="mt-5" style="">
<div class="<?php echo $section ?>">
<div class="container">
<div class="row w-100 m-auto">
<!-- start here -->
<?php
//calculating the total sum of sub products quantities

$i = 0;
if ( isset($_GET["id"]) && !empty($_GET["id"]) ){
$sql = "SELECT * FROM
		(
			SELECT
			p.subId, p.id, p.discount, p.enTitle, p.arTitle, i.imageurl , sp.price AS subPrice, SUM(sp.quantity) as realQuantity, p.categoryId, p.preorder, p.preorderText, p.preorderTextAr
			FROM
			`products` AS p
			JOIN `images` AS i
			ON p.id = i.productId
			JOIN `subproducts` AS sp
			ON p.id = sp.productId
			WHERE
			p.hidden = '0' AND
			p.categoryId = '{$_GET["id"]}' AND
			sp.hidden = '0'
			GROUP by sp.id
			ORDER BY sp.quantity='0'
		)
		AS `my_table_tmp`
		GROUP BY `id`
		";
}else{
    $sql = "SELECT * FROM
		(
			SELECT
			p.subId, p.id, p.discount, p.enTitle, p.arTitle, i.imageurl , sp.price AS subPrice, SUM(sp.quantity) as realQuantity, p.categoryId, p.preorder, p.preorderText, p.preorderTextAr
			FROM
			`products` AS p
			JOIN `images` AS i
			ON p.id = i.productId
			JOIN `subproducts` AS sp
			ON p.id = sp.productId
			WHERE
			p.hidden = '0' AND
			sp.hidden = '0'
			GROUP by sp.id
			ORDER BY sp.quantity='0'
		)
		AS `my_table_tmp`
		GROUP BY `id`
		";
}
//ORDER BY `subId` ASC
$result = $dbconnect->query($sql);

while ( $row = $result->fetch_assoc() )
{
	$category = selectDB("categories","`id` = '{$_GET["id"]}'");
?>

<div class="col-xl-3 col-lg-4 col-md-4 col-sm-4 col-6 my-product <?php echo $row["categoryId"] ?>-product">
<table style="width:100%;direction:<?php echo $directionHTML ?>">
<tr>
<td class="text-right">
<div class="product-box" style="height: 100%;">
<?php
if ( $row["discount"] != 0 ) {
	echo "<span class='discountPercent'>{$row["discount"]}%</span>";
}

if ( $row["preorder"] != 0 ) {
	echo '<span class="preorder">';
	if ( !empty($row["preorderText"]) && !empty($row["preorderTextAr"]) ){
		echo direction($row["preorderText"],$row["preorderTextAr"]);
	}else{
		echo direction("PRE-ORDER","الطلب المسبق");
	}
	echo '</span>';
}

//if ( $row["realQuantity"] > 0 ){
	echo "<a href='product.php?id={$row["id"]}'>"; 
//}

echo "<div class='img-fluid product-box-img' ><img src='logos/{$row["imageurl"]}' style='width: 100%;'></div>";

//if ( $row["realQuantity"] > 0 ){
	echo '</a>';
//}
?>
<div class="product-text">
<h6 class="product-title">
<?php echo direction($row["enTitle"],$row["arTitle"]); ?>
</h6>
<h6 class="product-title" style="color: #b3b3b3 !important;FONT-SIZE: 11PX;"><?php echo direction($category[0]["enTitle"],$category[0]["arTitle"]) ?></h6>
<div class="product-meta">
<div class="productPriceWrapper">
<?php 
	if ( $row["discount"] != 0 ){
		echo "<span class='discountedPrice'>".$row["subPrice"]."KD</span>";
	}
?>
<span class="product-price">
<?php 
	if ( $row["discount"] != 0 ) {
		echo $row["subPrice"] - ( $row["subPrice"] * $row["discount"] / 100);
	}else{
		echo $row["subPrice"];
	}
?>KD</span>
</div>
<?php
//if ( $row["realQuantity"] > 0 ){
?>
<a href="product.php?id=<?php echo $row["id"] ?>">
<?php
//}
?>
<button type="button" class="btn cart-btn add-to-cart add-to-cart-btn" style="">
<span class="fa fa-shopping-basket mr-2 ml-2"></span>
<?php
	if ( $row["realQuantity"] > 0 ){
		echo $viewText;
	}else{
		echo "<del style='color:red;font-size:10px'>Sold Out</del>";
	}
?>
</button>
<?php
//if ( $row["realQuantity"] > 0 ){
?>
</a>
<?php
//}
?>
</div>
</div>
</div>
</td>
</tr>
</table>
</div>


<?php
$i++;
}
?>
<div class="row w-100 m-auto">
<div class="col-12 text-center mt-5 mb-4">
</div>
</div>


</div>
</div>
</div>
</div>
</div>
</div>
</div>
<script type="text/javascript">
$(".product-category").click(function() {
$('.my-product').attr('style', 'display:none');
if ( $(this).attr('type') < 1 ){
	$('.my-product').attr('style', 'display:block');
}else{
	$('.'+$(this).attr('type')+'-product').attr('style', 'display:block');
}
});

$(".product-category-mobile").click(function() {
$('.my-product').attr('style', 'display:none');
if ( $(this).attr('type') < 1 ){
	$('.my-product').attr('style', 'display:block');
}else{
	$('.'+$(this).attr('type')+'-product').attr('style', 'display:block');
}
});
</script>

<button class="product-cart shopping-cart item-pad-cust right" data-toggle="modal" data-target="#cart_popup">
<span class="totalItems">
	<span><?php echo cartSVG(); ?></span>
	<span class="cartItemNo"><?php echo sizeof($_SESSION["cart"]["id"]) ?></span>
</span>
<span class="cart_price"><?php echo getCartPrice(); ?></span>
</button>