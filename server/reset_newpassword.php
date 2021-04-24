<?php
    error_reporting(0);
    include_once("dbconnect.php");
    $npassword = $_POST['npassword'];
    $passhal1 = sha1($npassword);
    $otp = $_POST['otp'];
    
    $sqlupdate = "UPDATE tbl_user SET password = '$passhal1', otp ='0' WHERE otp = '$otp' ";
    if ($conn->query($sqlupdate) === TRUE){
        echo 'Reset Sucess';
        }else{
        echo 'Failed';
        }
?>