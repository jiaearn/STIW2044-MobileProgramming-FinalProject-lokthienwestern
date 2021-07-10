<?php
include_once("dbconnect.php");
$product_id = $_POST['product_id'];

$sqldelete = "DELETE FROM tbl_products  WHERE product_id = '$product_id'";
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "Success";
} else {
    echo "Failed";
}
?>