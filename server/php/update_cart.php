<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$product_id = $_POST['product_id'];
$op = $_POST['op'];
$qty = $_POST['qty'];

if ($op == "addcart") {
    $sqlupdatecart = "UPDATE tbl_carts SET qty = qty +1 WHERE product_id = '$product_id' AND email = '$email'";
    if ($conn->query($sqlupdatecart) === TRUE) {
        echo "Success";
    } else {
        echo "Failed";
    }
}
if ($op == "removecart") {
    if ($qty == 1) {
        echo "Failed";
    } else {
        $sqlupdatecart = "UPDATE tbl_carts SET qty = qty - 1 WHERE product_id = '$product_id' AND email = '$email'";
        if ($conn->query($sqlupdatecart) === TRUE) {
            echo "Success";
        } else {
            echo "Failed";
        }
    }
}
?>