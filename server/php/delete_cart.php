<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$product_id = $_POST['product_id'];

$sqldelete = "DELETE FROM tbl_carts WHERE email='$email' AND product_id = '$product_id'";
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "Success";
} else {
    echo "Failed";
}
?>