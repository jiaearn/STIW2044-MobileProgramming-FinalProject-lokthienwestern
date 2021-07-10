<?php

include_once("dbconnect.php");
$product_name= $_POST['product_name'];

if ($product_name == "all") {
    $sqlload = "SELECT * FROM tbl_products ORDER BY product_id DESC";
} 
else if($product_name == "null"){
    echo("null");
}
else {
    $sqlload = "SELECT * FROM tbl_products WHERE product_name LIKE '%$product_name%' ORDER BY product_id DESC";
} 

$result = $conn->query($sqlload);

if ($result->num_rows > 0){
    $response["products"] = array();
    while ($row = $result -> fetch_assoc()){
        $prlist = array();
        $prlist[product_id] = $row['product_id'];
        $prlist[product_name] = $row['product_name'];
        $prlist[product_price] = $row['product_price'];
        $prlist[product_categ] = $row['product_categ'];
        $prlist[product_desc] = $row['product_desc'];
        $prlist[product_rating] = $row['product_rating'];
        $prlist[date_created] = $row['date_created'];
        array_push($response["products"],$prlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>