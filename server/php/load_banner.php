<?php

include_once("dbconnect.php");

$sqlload = "SELECT * FROM tbl_banners ORDER BY banner_id";

$result = $conn->query($sqlload);

if ($result->num_rows > 0){
    $response["banner"] = array();
    while ($row = $result -> fetch_assoc()){
        $bnlist = array();
        $bnlist[banner_id] = $row['banner_id'];
        $bnlist[banner_name] = $row['banner_name'];
        $bnlist[date_created] = $row['date_created'];
        array_push($response["banner"],$bnlist);
    }
    echo json_encode($response);
}else{
    echo "nodata";
}
?>