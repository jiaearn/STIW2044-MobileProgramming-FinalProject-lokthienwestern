<?php
    error_reporting(0);
    include_once("dbconnect.php");
    $orderid = $_POST['order_id'];
    $status = $_POST['status'];
 
    $sqlupdate = "UPDATE tbl_purchased SET status = '$status' WHERE orderid  = '$orderid'";
    if ($conn->query($sqlupdate) === TRUE){
        echo 'Success';
        }else{
        echo 'Failed';
        }
?>