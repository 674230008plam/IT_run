<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once __DIR__ . '/config/database.php';
require_once __DIR__ . '/classes/Logger.php';
require_once __DIR__ . '/classes/Request.php';
require_once __DIR__ . '/includes/functions.php';

checkSession();

$dbInstance = null;
if (isset($pdo)) {
    $dbInstance = $pdo;
}
if (isset($conn)) {
    $dbInstance = $conn;
}

$searchCode = isset($_GET['request_number']) ? cleanInput($_GET['request_number']) : '';
$requestData = null;
$searched    = false;

if (!empty($searchCode) && $dbInstance) {
    $searched   = true;
    $requestObj = new Request($dbInstance);
    $requestData = $requestObj->getByTrackingCode($searchCode);
}

$pageTitle = 'IT Run — ติดตามสถานะคำร้อง';
require_once __DIR__ . '/includes/header.php';
?>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-header bg-success text-white py-3">
                <h5 class="mb-0 fw-bold"><i class="fas fa-search me-2"></i>ติดตามสถานะคำร้อง</h5>
            </div>
            <div class="card-body p-4">
                <form method="GET" action="" class="mb-0">
                    <div class="input-group input-group-lg">
                        <input type="text" class="form-control" name="request_number" placeholder="กรอกรหัสติดตามคำร้อง เช่น SCR-202610-1234" value="<?php echo htmlspecialchars($searchCode, ENT_QUOTES, 'UTF-8'); ?>" required>
                        <button class="btn btn-success px-4" type="submit"><i class="fas fa-search me-1"></i>ค้นหาคำร้อง</button>
                    </div>
                </form>
            </div>
        </div>

        <?php if ($searched): ?>
            <?php if ($requestData): ?>
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
                            <h5 class="fw-bold mb-0">รายละเอียดคำร้อง: <span class="text-primary"><?php echo htmlspecialchars($requestData['request_number'], ENT_QUOTES, 'UTF-8'); ?></span></h5>
                            <span class="badge bg-warning text-dark fs-6 px-3 py-2"><i class="fas fa-clock me-1"></i>อยู่ระหว่างพิจารณา</span>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <strong>รหัสนักศึกษา:</strong> <?php echo htmlspecialchars($requestData['student_code'], ENT_QUOTES, 'UTF-8'); ?>
                            </div>
                            <div class="col-md-6">
                                <strong>รหัสวิชา:</strong> <?php echo htmlspecialchars($requestData['subject_code'], ENT_QUOTES, 'UTF-8'); ?>
                            </div>
                            <div class="col-md-6">
                                <strong>ภาคการศึกษา/ปี:</strong> <?php echo htmlspecialchars($requestData['term_semester'] . '/' . $requestData['term_year'], ENT_QUOTES, 'UTF-8'); ?>
                            </div>
                            <div class="col-md-6">
                                <strong>จำนวนผู้เรียนประมาณ:</strong> <?php echo (int)$requestData['headcount_estimate']; ?> คน
                            </div>
                            <div class="col-12">
                                <strong>เหตุผลและความจำเป็น:</strong>
                                <p class="bg-light p-3 rounded mt-1 border"><?php echo nl2br(htmlspecialchars($requestData['request_reason'], ENT_QUOTES, 'UTF-8')); ?></p>
                            </div>
                            <div class="col-12 text-muted small">
                                ยื่นคำร้องเมื่อ: <?php echo htmlspecialchars($requestData['created_at'], ENT_QUOTES, 'UTF-8'); ?>
                            </div>
                        </div>
                    </div>
                </div>
            <?php else: ?>
                <div class="alert alert-warning text-center py-4" role="alert">
                    <i class="fas fa-exclamation-circle fa-2x mb-2"></i>
                    <h5>ไม่พบข้อมูลคำร้อง</h5>
                    <p class="mb-0">ไม่พบรหัสคำร้อง <strong><?php echo htmlspecialchars($searchCode, ENT_QUOTES, 'UTF-8'); ?></strong> ในระบบ กรุณาตรวจสอบรหัสอีกครั้ง</p>
                </div>
            <?php endif; ?>
        <?php endif; ?>
    </div>
</div>

<?php require_once __DIR__ . '/includes/footer.php'; ?>