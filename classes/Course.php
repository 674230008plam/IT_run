<?php

class Course
{
    private PDO $dbConn;

    public function __construct(PDO $db)
    {
        $this->dbConn = $db;
    }

    public function isInRegularSchedule(string $studentCode, string $subjectCode, int $semester, int $year): bool
    {
        try {
            $stmt = $this->dbConn->prepare(
                'SELECT COUNT(*) FROM subject_catalog 
                 WHERE subject_code = :subject_code AND is_active = 1'
            );
            $stmt->execute([':subject_code' => $subjectCode]);
            return (bool)$stmt->fetchColumn();
        } catch (\Exception $e) {
            return false;
        }
    }
}