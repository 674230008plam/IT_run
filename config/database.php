<?php
$host     = 'localhost';
$username = 'root';$password = '';

try {
    // 1. เชื่อมต่อ MySQL Server
    $pdo = new PDO("mysql:host={$host};charset=utf8mb4", $username,$password, [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES   => false,
    ]);

    // 2. ค้นหาฐานข้อมูลที่มีอยู่ในเครื่อง
    $stmt =$pdo->query("SHOW DATABASES LIKE '%special_course%'");
    $existingDb =$stmt->fetchColumn();

    if ($existingDb) {
        $db_name =$existingDb;
    } else {
        // ถ้าไม่มี ให้สร้างฐานข้อมูล special_course_db ใหม่ทันที
        $db_name = 'special_course_db';$pdo->exec("CREATE DATABASE IF NOT EXISTS `{$db_name}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
    }

    // 3. เลือกใช้ฐานข้อมูล
    $pdo->exec("USE `{$db_name}`");

    // 4. สร้างตารางที่จำเป็นถ้ายังไม่มี
    $pdo->exec("CREATE TABLE IF NOT EXISTS section_requests (
        id INT AUTO_INCREMENT PRIMARY KEY,
        request_number VARCHAR(50) NOT NULL,
        student_code VARCHAR(20) NOT NULL,
        subject_code VARCHAR(20) NOT NULL,
        term_semester INT NOT NULL,
        term_year INT NOT NULL,
        request_reason TEXT NOT NULL,
        headcount_estimate INT DEFAULT 1,
        has_conflict_schedule TINYINT(1) DEFAULT 0,
        status_id INT DEFAULT 1,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    $pdo->exec("CREATE TABLE IF NOT EXISTS subject_catalog (
        id INT AUTO_INCREMENT PRIMARY KEY,
        subject_code VARCHAR(20) NOT NULL,
        subject_name VARCHAR(255) NOT NULL,
        is_active TINYINT(1) DEFAULT 1
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    $conn =$pdo;

} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}