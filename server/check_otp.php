<?php
    error_reporting(0);
    include_once("dbconnect.php");
    $otp = $_POST['otp'];
    
    $checkOTP = "SELECT otp FROM tbl_user WHERE otp='$otp'";
    $result = $conn->query($checkOTP);

if ($result->num_rows > 0) {
    echo "Reset new Password";
}
else{
    echo "Failed";
}
?>