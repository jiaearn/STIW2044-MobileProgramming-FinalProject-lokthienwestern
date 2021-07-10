<?php
    error_reporting(0);
    include_once("dbconnect.php");
    $email = $_POST['email'];
    $npassword = $_POST['npassword'];
    $passhal1 = sha1($npassword);
    $otp = $_POST['otp'];
    $curpassword = $_POST['curpassword'];
    $passhal2 = sha1($curpassword);
    $status = $_POST['status'];
    $sqlcheck = "SELECT * FROM tbl_user WHERE email= '$email' AND password = '$passhal2'";
    $result = $conn-> query ($sqlcheck);
    if($status=="update" && $result ->num_rows>0){
     $sqlupdate = "UPDATE tbl_user SET password = '$passhal1' WHERE email= '$email'";
    if ($conn->query($sqlupdate) === TRUE){
        echo 'Update Success';
        }
        else{
        echo 'Update Failed';
        }
    }else{
    $sqlreset = "UPDATE tbl_user SET password = '$passhal1', otp ='0' WHERE otp = '$otp' ";
  
    if ($conn->query($sqlreset) === TRUE){
        echo 'Reset Success';
        }
        else{
        echo 'Failed';
        }}
?>