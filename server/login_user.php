<?php
error_reporting(0);
include_once("dbconnect.php");
$username = $_POST['username'];
$email = $_POST['email'];
$password = sha1($_POST['password']);

$sqllogin = "SELECT * FROM tbl_user WHERE email = '$email' AND password = '$password' AND otp = '0'";
$result = $conn->query($sqllogin);

$sqllogin2 = "SELECT * FROM tbl_user WHERE username = '$username' AND password = '$password' AND otp = '0'";
$result2 = $conn->query($sqllogin2);

$sqllogin3 = "SELECT * FROM tbl_user WHERE email = '$email' AND password = '$password' AND otp != '0'";
$result3 = $conn->query($sqllogin3);

$sqllogin4 = "SELECT * FROM tbl_user WHERE username = '$username' AND password = '$password' AND otp != '0'";
$result4 = $conn->query($sqllogin4);


if($username=="lokthienadmin" && $password=="f865b53623b121fd34ee5426c792e5c33af8c227"){
    echo $data= "AdminLogin";
}
else{
if ($result3->num_rows > 0) {
    while ($row = $result3 ->fetch_assoc()){
        echo $data = "Please activate your account via email first.";
    }
}

elseif ($result4->num_rows > 0) {
    while ($row = $result4 ->fetch_assoc()){
        echo $data = "Please activate your account via email first.";
    }
}
else{ 
if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo $data = "Success";
    }
}
else if($result2->num_rows > 0){
    while ($row = $result2 ->fetch_assoc()){
        echo $data = "Success";
    } 
}
else{
    echo "Failed";
}
}}
?>