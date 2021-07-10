<?php
include_once("dbconnect.php");
$banner_id = $_POST['banner_id'];

$sqldelete = "DELETE FROM tbl_banners  WHERE banner_id = '$banner_id'";
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "Success";
} else {
    echo "Failed";
}
?>