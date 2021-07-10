<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home8/hubbuddi/public_html/269509/lokthienwestern/php/PHPMailer/Exception.php';
require '/home8/hubbuddi/public_html/269509/lokthienwestern/php/PHPMailer/PHPMailer.php';
require '/home8/hubbuddi/public_html/269509/lokthienwestern/php/PHPMailer/SMTP.php';

include_once("dbconnect.php");

$email = $_POST['email'];
$otp = rand(100000,999999);

$emailReset = "SELECT * FROM tbl_user WHERE email='$email' AND otp= '0'";
$result = $conn->query($emailReset);

$emailReset2 = "SELECT * FROM tbl_user WHERE email='$email' AND otp!= '0'";
$result2 = $conn->query($emailReset2);

$username = "SELECT * FROM tbl_user WHERE email='$email'";
$result3 = $conn->query($username);

if ($result2->num_rows > 0) {
    while ($row = $result2 ->fetch_assoc()){
        echo $data = "Please activate your account via email first.";
    }
}
else if($result->num_rows>0){
    $sqlupdate= "UPDATE tbl_user SET otp='$otp' WHERE email='$email'";
    if($conn->query($sqlupdate)===TRUE){
      if ($result3->num_rows > 0) {
         while ($row = $result3 ->fetch_assoc()){
            $name = $row['username'];
            echo "OTP has been successfully sent to the mail.";
            sendEmail($name,$email,$otp);
         }
        }
    }
}
else{
echo "Failed";
}


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
    $mail->Subject = "OTP Code";
    $mail->Body  = "Dear $username,<br><br>We have received your forgot password request, 
    your otp code to reset your new password is <strong>$otp</strong>. 
    Please enter the otp code in the application to continue to reset the new password.<br><br>
    Thank You.<br><br>Sincerely,<br>Customer Service<br>Lok Thien Western.<br><br>
    <center><strong>Please do not reply to this email.</strong></center>";;

    $mail->send();
}
?>