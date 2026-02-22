<?php
header("Content-Type: application/json");
include 'condb.php';

$action = $_POST['action'] ?? null;
$targetDir = "uploads/";

// สร้างโฟลเดอร์ถ้าไม่มี
if (!is_dir($targetDir)) {
    mkdir($targetDir, 0777, true);
}

// ฟังก์ชันอัปโหลดรูปแบบปลอดภัย
function uploadImage($file, $targetDir) {
    $allowed = ['jpg','jpeg','png'];
    $maxSize = 2 * 1024 * 1024; // 2MB

    $ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));

    if (!in_array($ext, $allowed)) {
        return ["error" => "อนุญาตเฉพาะไฟล์ JPG, JPEG, PNG เท่านั้น"];
    }

    if ($file['size'] > $maxSize) {
        return ["error" => "ไฟล์ต้องไม่เกิน 2MB"];
    }

    $newName = time() . '_' . rand(1000,9999) . '.' . $ext;
    $destination = $targetDir . $newName;

    if (move_uploaded_file($file['tmp_name'], $destination)) {
        return ["success" => $newName];
    }

    return ["error" => "อัปโหลดไฟล์ไม่สำเร็จ"];
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $action) {

    switch($action) {

        // ================= ADD =================
        case 'add':
            $full_name = $_POST['full_name'];
            $department = $_POST['department'];
            $salary = $_POST['salary'];
            $active = $_POST['active'];

            $filename = null;

            if (isset($_FILES['image']) && $_FILES['image']['error'] === 0) {
                $upload = uploadImage($_FILES['image'], $targetDir);
                if (isset($upload['error'])) {
                    echo json_encode(["error" => $upload['error']]);
                    exit;
                }
                $filename = $upload['success'];
            }

            $sql = "INSERT INTO employees 
                    (full_name, department, salary, active, image)
                    VALUES (:full_name, :department, :salary, :active, :image)";
            $stmt = $conn->prepare($sql);
            $stmt->execute([
                ':full_name' => $full_name,
                ':department' => $department,
                ':salary' => $salary,
                ':active' => $active,
                ':image' => $filename
            ]);

            echo json_encode(["message" => "เพิ่มพนักงานสำเร็จ"]);
            break;

        // ================= UPDATE =================
        case 'update':
            $emp_id = $_POST['emp_id'];
            $full_name = $_POST['full_name'];
            $department = $_POST['department'];
            $salary = $_POST['salary'];
            $active = $_POST['active'];

            // ดึงรูปเก่า
            $stmtOld = $conn->prepare("SELECT image FROM employees WHERE emp_id = :emp_id");
            $stmtOld->execute([':emp_id' => $emp_id]);
            $oldData = $stmtOld->fetch(PDO::FETCH_ASSOC);
            $oldImage = $oldData['image'] ?? null;

            $filename = $oldImage;

            if (isset($_FILES['image']) && $_FILES['image']['error'] === 0) {

                $upload = uploadImage($_FILES['image'], $targetDir);
                if (isset($upload['error'])) {
                    echo json_encode(["error" => $upload['error']]);
                    exit;
                }

                // ลบรูปเก่า
                if ($oldImage && file_exists($targetDir . $oldImage)) {
                    unlink($targetDir . $oldImage);
                }

                $filename = $upload['success'];
            }

            $sql = "UPDATE employees SET
                        full_name = :full_name,
                        department = :department,
                        salary = :salary,
                        active = :active,
                        image = :image
                    WHERE emp_id = :emp_id";

            $stmt = $conn->prepare($sql);
            $stmt->execute([
                ':full_name' => $full_name,
                ':department' => $department,
                ':salary' => $salary,
                ':active' => $active,
                ':image' => $filename,
                ':emp_id' => $emp_id
            ]);

            echo json_encode(["message" => "แก้ไขข้อมูลสำเร็จ"]);
            break;

        // ================= DELETE =================
        case 'delete':
            $emp_id = $_POST['emp_id'];

            // ดึงรูปก่อนลบ
            $stmtOld = $conn->prepare("SELECT image FROM employees WHERE emp_id = :emp_id");
            $stmtOld->execute([':emp_id' => $emp_id]);
            $oldData = $stmtOld->fetch(PDO::FETCH_ASSOC);

            if ($oldData && $oldData['image']) {
                $filePath = $targetDir . $oldData['image'];
                if (file_exists($filePath)) {
                    unlink($filePath);
                }
            }

            $stmt = $conn->prepare("DELETE FROM employees WHERE emp_id = :emp_id");
            $stmt->execute([':emp_id' => $emp_id]);

            echo json_encode(["message" => "ลบข้อมูลสำเร็จ"]);
            break;

        default:
            echo json_encode(["error" => "Action ไม่ถูกต้อง"]);
            break;
    }

} else {

    // ================= GET =================
    $stmt = $conn->prepare("SELECT * FROM employees ORDER BY emp_id DESC");
    $stmt->execute();
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode([
        "success" => true,
        "data" => $data
    ]);
}
?>