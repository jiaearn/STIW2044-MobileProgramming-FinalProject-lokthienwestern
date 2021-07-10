<?php
include_once("dbconnect.php");
$banner_name = $_POST['banner_name'];
$encoded_string = $_POST['encoded_string'];

$sqlinsert="INSERT INTO tbl_banners(banner_name) VALUES('$banner_name')";
if($conn->query($sqlinsert)===true){
    $decoded_string=base64_decode($encoded_string);
    $filename=mysqli_insert_id($conn);
    $path= '../images/banner_pictures/'.$filename.'.png';
    $is_written=file_put_contents($path,$decoded_string);
    echo "Success";
}else{
    echo "Failed";
}
?>