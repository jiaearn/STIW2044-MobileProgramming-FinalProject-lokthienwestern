<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlloadcart = "SELECT * FROM tbl_carts INNER JOIN tbl_products ON tbl_carts.product_id = tbl_products.product_id WHERE tbl_carts.email = '$email'";;

$result = $conn->query($sqlloadcart);

if ($result->num_rows > 0) {
    $response['cart'] = array();
    while ($row = $result->fetch_assoc()) {
        $prlist[product_id] = $row['product_id'];
        $prlist[product_name] = $row['product_name'];
        $prlist[product_categ] = $row['product_categ'];
        $prlist[product_price] = $row['product_price'];
        $prlist[cartqty] = $row['qty'];
        array_push($response['cart'], $prlist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>