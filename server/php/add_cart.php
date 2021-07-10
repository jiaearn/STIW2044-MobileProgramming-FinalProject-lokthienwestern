<?php
include_once("dbconnect.php");
$email = $_POST['email'];
$product_id = $_POST['product_id'];

$sqlcheckstock = "SELECT * FROM tbl_products WHERE product_id = '$product_id' ";

$resultstock = $conn->query($sqlcheckstock);
if ($resultstock->num_rows > 0) {
     while ($row = $resultstock ->fetch_assoc()){
            $sqlcheckcart = "SELECT * FROM tbl_carts WHERE product_id = '$product_id' AND email = '$email'"; 
            $resultcart = $conn->query($sqlcheckcart);
            if ($resultcart->num_rows == 0) {
                  $sqladdtocart = "INSERT INTO tbl_carts (email, product_id, qty) VALUES ('$email','$product_id','1')";
                if ($conn->query($sqladdtocart) === TRUE) {
                    echo "Success";
                } else {
                    echo "Failed";
                }
            } else { 
                 $sqlupdatecart = "UPDATE tbl_carts SET qty = qty +1 WHERE product_id = '$product_id' AND email = '$email'";
                if ($conn->query($sqlupdatecart) === TRUE) {
                    echo "Success";
                } else {
                    echo "Failed";
                }
            }
        
    }
}else{
    echo "Failed";
}

?>