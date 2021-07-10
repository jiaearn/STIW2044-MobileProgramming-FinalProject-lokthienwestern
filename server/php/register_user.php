<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/hubbuddi/public_html/269509/lokthienwestern/php/PHPMailer/Exception.php';
require '/home8/hubbuddi/public_html/269509/lokthienwestern/php/PHPMailer/PHPMailer.php';
require '/home8/hubbuddi/public_html/269509/lokthienwestern/php/PHPMailer/SMTP.php';

include_once("dbconnect.php");
$username = $_POST['username'];
$email = $_POST['email'];
$fullname = $_POST['fullname'];
$password = $_POST['password'];
$pass_sha1 = sha1($password);
$otp = rand(100000,999999);
$contact = $_POST['contact'];

$dupEmail = "SELECT email FROM tbl_user WHERE email='$email'";
$result1 = $conn->query($dupEmail);

$dupUsername = "SELECT username FROM tbl_user WHERE username='$username'";
$result2 = $conn->query($dupUsername);

if($result1->num_rows>0){
    echo "Email Already Exists.";
    }
else if($result2->num_rows>0){
    echo "Username Already Exists.";
    }

else{    
$sqlregister = "INSERT INTO tbl_user(username,email,fullname,password,otp,contact) VALUES('$username','$email','$fullname','$pass_sha1','$otp','$contact')";

if($conn->query($sqlregister) === TRUE){
    echo "Success";
    sendEmail($username,$email,$otp);
}else{
    echo "Failed";
}
    
};

function sendEmail($username,$email,$otp){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0; 
    $mail->isSMTP(); 
    $mail->Host= 'mail.hubbuddies.com'; 
    $mail->SMTPAuth= true; 
    $mail->Username= 'lokthienwestern@hubbuddies.com'; 
    $mail->Password= '6p$=8zACNSDa';
    $mail->SMTPSecure= 'tls';         
    $mail->Port= 587;
    
    $mail->setFrom("lokthienwestern@hubbuddies.com","Lok Thien Western");
    $mail->addAddress($email,$username);
    
    $mail->isHTML(true);
    $mail->Subject = "Email Verification";
    $mail->Body  = "Dear $username,<br><br>Thank you for applying to open an account with us.<br><br>
    To ensure that your email address is correctly captured into our system, 
    kindly verify your email address by clicking the link below or copy paste the below URL in new browser:<br><br> 
    <a href='https://hubbuddies.com/269509/lokthienwestern/php/verify_user.php?email=".$email."'>
    https://hubbuddies.com/269509/lokthienwestern/php/verify_user.php?email=".$email."</a><br><br>
    Thank You.<br><br>Sincerely,<br>Customer Service<br>Lok Thien Western.<br><br>
    <center><strong>Please do not reply to this email.</strong></center>";

    $mail->send();
}
?>