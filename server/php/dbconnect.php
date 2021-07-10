<?php
$servername = "localhost";
$username   = "hubbuddi_lokthienwesternadmin";
$password   = "6p$=8zACNSDa";
$dbname     = "hubbuddi_lokthienwesterndb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>