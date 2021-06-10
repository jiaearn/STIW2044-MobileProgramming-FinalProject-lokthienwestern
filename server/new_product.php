<?php

include_once("dbconnect.php");
$product_name = $_POST['product_name'];
$product_price = $_POST['product_price'];
$product_categ = $_POST['product_categ'];
$product_desc = $_POST['product_desc'];
$product_rating = $_POST['product_rating'];
$encoded_string = $_POST['encoded_string'];

$sqlinsert="INSERT INTO tbl_products(product_name,product_price,product_categ,product_desc,product_rating) VALUES('$product_name','$product_price','$product_categ','$product_desc','$product_rating')";
if($conn->query($sqlinsert)===true){
    $decoded_string=base64_decode($encoded_string);
    $filename=mysqli_insert_id($conn);
    $path= '../images/product_pictures/'.$filename.'.png';
    $is_written=file_put_contents($path,$decoded_string);
    echo "Success";
}else{
    echo "Failed";
}
?>