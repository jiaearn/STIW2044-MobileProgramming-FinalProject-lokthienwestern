<?php
include_once("dbconnect.php");
$email = $_POST['email'];

if($email=="admin"){
$sqlloadhistory = "SELECT * FROM tbl_history 
INNER JOIN tbl_products ON tbl_history.product_id = tbl_products.product_id 
INNER JOIN tbl_purchased ON tbl_history.orderid = tbl_purchased.orderid
ORDER BY tbl_purchased.date_purchase DESC
";
$result = $conn->query($sqlloadhistory);


if ($result->num_rows > 0 ) {
    $response['history'] = array();
    while ($row = $result->fetch_assoc()) {
        $historylist[product_id] = $row['product_id'];
        $historylist[product_name] = $row['product_name'];
        $historylist[product_categ] = $row['product_categ'];
        $historylist[product_price] = $row['product_price'];
        $historylist[history_qty] = $row['qty'];
        $historylist[orderid] = $row['orderid'];
        $historylist[paid] = $row['paid'];
        $historylist[status] = $row['status'];
        $historylist[date_created] = $row['date_purchase'];
        array_push($response['history'], $historylist);
    }
    echo json_encode($response);
} 
else {
    echo "nodata";
}
}
else{
$sqlloadhistory = "SELECT * FROM tbl_history 
INNER JOIN tbl_products ON tbl_history.product_id = tbl_products.product_id 
INNER JOIN tbl_purchased ON tbl_history.orderid = tbl_purchased.orderid
WHERE tbl_history.email = '$email'
ORDER BY tbl_purchased.date_purchase DESC
";
$result = $conn->query($sqlloadhistory);


if ($result->num_rows > 0 ) {
    $response['history'] = array();
    while ($row = $result->fetch_assoc()) {
        $historylist[product_id] = $row['product_id'];
        $historylist[product_name] = $row['product_name'];
        $historylist[product_categ] = $row['product_categ'];
        $historylist[product_price] = $row['product_price'];
        $historylist[history_qty] = $row['qty'];
        $historylist[orderid] = $row['orderid'];
        $historylist[paid] = $row['paid'];
        $historylist[status] = $row['status'];
        $historylist[date_created] = $row['date_purchase'];
        array_push($response['history'], $historylist);
    }
    echo json_encode($response);
} 
else {
    echo "nodata";
}
}
?>