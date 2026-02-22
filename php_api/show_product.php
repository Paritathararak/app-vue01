<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

$conn = mysqli_connect("localhost", "root", "", "db_shop");

if (!$conn) {
    die(json_encode(["error" => "เชื่อมต่อฐานข้อมูลไม่สำเร็จ"]));
}

$sql = "SELECT * FROM products";   // ← ต้องมี s
$result = mysqli_query($conn, $sql);

$data = [];

while ($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
}

echo json_encode($data);

mysqli_close($conn);
?>