<?php

class Student
{
    private PDO $dbConn;

    public function __construct(PDO $db)
    {
        $this->dbConn = $db;
    }

    public function isEligibleForSpecialCourse(string $studentCode): bool
    {
        return true; 
    }
}