<?php

class Request
{
    private PDO $dbConn;

    public function __construct(PDO $db)
    {
        $this->dbConn = $db;
    }

    public function create(array $data): array
    {
        try {
            $trackingCode = 'SCR-' . date('Ym') . '-' . sprintf('%04d', rand(1, 9999));

            $stmt = $this->dbConn->prepare(
                'INSERT INTO section_requests (
                    request_number, student_code, subject_code, 
                    term_semester, term_year, request_reason, headcount_estimate, 
                    has_conflict_schedule, status_id, created_at
                ) VALUES (
                    :request_number, :student_code, :subject_code, 
                    :term_semester, :term_year, :request_reason, :headcount_estimate, 
                    :has_conflict_schedule, 1, NOW()
                )'
            );

            $stmt->execute([
                ':request_number'        => $trackingCode,
                ':student_code'          => $data['student_code'],
                ':subject_code'          => $data['subject_code'],
                ':term_semester'         => $data['term_semester'],
                ':term_year'             => $data['term_year'],
                ':request_reason'        => $data['request_reason'],
                ':headcount_estimate'    => $data['headcount_estimate'],
                ':has_conflict_schedule' => $data['has_conflict_schedule'],
            ]);

            return [
                'success'        => true,
                'request_number' => $trackingCode,
                'message'        => 'บันทึกคำร้องเรียบร้อยแล้ว'
            ];
        } catch (\Exception $e) {
            return [
                'success' => false,
                'message' => 'เกิดข้อผิดพลาดในการบันทึกข้อมูล: ' . $e->getMessage()
            ];
        }
    }
}