<?php
    error_reporting(0);
    include_once("dbconnect.php");
    $email = $_POST['email'];
    $fullname = $_POST['fullname'];
    $contact = $_POST['contact'];
    $gender = $_POST['gender'];
    
    $sqlupdate = "UPDATE tbl_user SET fullname = '$fullname', contact ='$contact', gender = '$gender' WHERE email = '$email'";
    if ($conn->query($sqlupdate) === TRUE){
        echo 'Success';
        }else{
        echo 'Failed';
        }
?>