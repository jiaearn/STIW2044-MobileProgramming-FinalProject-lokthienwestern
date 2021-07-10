<?php
    error_reporting(0);
    include_once("dbconnect.php");
    $product_id = $_POST['product_id'];
    $product_name = $_POST['product_name'];
    $product_price = $_POST['product_price'];
    $product_categ = $_POST['product_categ'];
    $product_desc = $_POST['product_desc'];
    $product_rating = $_POST['product_rating'];
    
    $sqlupdate = "UPDATE tbl_products SET product_name = '$product_name', product_price ='$product_price', product_categ = '$product_categ', product_desc = '$product_desc', product_rating = '$product_rating' WHERE product_id = '$product_id'";
    if ($conn->query($sqlupdate) === TRUE){
        echo 'Success';
        }else{
        echo 'Failed';
        }
?>