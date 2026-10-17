-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 18, 2026 at 12:18 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `academic_request_db`
--
CREATE DATABASE IF NOT EXISTS `academic_request_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `academic_request_db`;

-- --------------------------------------------------------

--
-- Table structure for table `academic_staff`
--

CREATE TABLE `academic_staff` (
  `staff_id` int(10) UNSIGNED NOT NULL,
  `title_prefix` varchar(10) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email_address` varchar(100) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  `academic_rank` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `learner_profiles`
--

CREATE TABLE `learner_profiles` (
  `student_code` varchar(20) NOT NULL,
  `title_prefix` varchar(10) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email_address` varchar(100) NOT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `faculty_name` varchar(100) NOT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  `program_major` varchar(100) DEFAULT NULL,
  `academic_level` tinyint(3) UNSIGNED NOT NULL,
  `study_shift` enum('regular','evening','weekend') NOT NULL DEFAULT 'regular',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `request_audit_logs`
--

CREATE TABLE `request_audit_logs` (
  `log_id` int(10) UNSIGNED NOT NULL,
  `request_id` int(10) UNSIGNED NOT NULL,
  `event_type` varchar(50) NOT NULL,
  `event_detail` text DEFAULT NULL,
  `actor_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `client_ip` varchar(45) DEFAULT NULL,
  `user_agent_str` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `section_requests`
--

CREATE TABLE `section_requests` (
  `request_id` int(10) UNSIGNED NOT NULL,
  `tracking_code` varchar(30) NOT NULL,
  `student_code` varchar(20) NOT NULL,
  `subject_code` varchar(20) NOT NULL,
  `staff_id` int(10) UNSIGNED DEFAULT NULL,
  `status_id` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `term_semester` tinyint(3) UNSIGNED NOT NULL,
  `term_year` smallint(5) UNSIGNED NOT NULL,
  `request_reason` text NOT NULL,
  `headcount_estimate` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `has_conflict_schedule` tinyint(1) NOT NULL DEFAULT 0,
  `submission_date` date NOT NULL,
  `evaluated_at` datetime DEFAULT NULL,
  `evaluated_by` varchar(100) DEFAULT NULL,
  `evaluation_remark` text DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `assigned_section` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subject_catalog`
--

CREATE TABLE `subject_catalog` (
  `subject_code` varchar(20) NOT NULL,
  `title_th` varchar(200) NOT NULL,
  `title_en` varchar(200) DEFAULT NULL,
  `lec_credit` decimal(3,1) NOT NULL DEFAULT 0.0,
  `lab_credit` decimal(3,1) NOT NULL DEFAULT 0.0,
  `self_credit` decimal(3,1) NOT NULL DEFAULT 0.0,
  `dept_name` varchar(100) DEFAULT NULL,
  `faculty_name` varchar(100) DEFAULT NULL,
  `degree_level` enum('undergraduate','graduate') NOT NULL DEFAULT 'undergraduate',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `vw_section_request_details`
-- (See below for the actual view)
--
CREATE TABLE `vw_section_request_details` (
`request_id` int(10) unsigned
,`tracking_code` varchar(30)
,`student_code` varchar(20)
,`learner_fullname` varchar(112)
,`learner_email` varchar(100)
,`faculty_name` varchar(100)
,`academic_level` tinyint(3) unsigned
,`subject_code` varchar(20)
,`subject_title_th` varchar(200)
,`lec_credit` decimal(3,1)
,`lab_credit` decimal(3,1)
,`credit_structure` varchar(17)
,`staff_id` int(10) unsigned
,`staff_fullname` varchar(112)
,`status_id` tinyint(3) unsigned
,`status_key` varchar(20)
,`status_label_th` varchar(50)
,`badge_color` varchar(20)
,`term_semester` tinyint(3) unsigned
,`term_year` smallint(5) unsigned
,`request_reason` text
,`headcount_estimate` smallint(5) unsigned
,`has_conflict_schedule` tinyint(1)
,`submission_date` date
,`evaluated_at` datetime
,`evaluated_by` varchar(100)
,`evaluation_remark` text
,`approved_at` datetime
,`assigned_section` varchar(10)
,`created_at` timestamp
,`updated_at` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `workflow_statuses`
--

CREATE TABLE `workflow_statuses` (
  `status_id` tinyint(3) UNSIGNED NOT NULL,
  `status_key` varchar(20) NOT NULL,
  `label_th` varchar(50) NOT NULL,
  `label_en` varchar(50) DEFAULT NULL,
  `badge_color` varchar(20) NOT NULL DEFAULT '#6c757d',
  `display_order` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `workflow_statuses`
--

INSERT INTO `workflow_statuses` (`status_id`, `status_key`, `label_th`, `label_en`, `badge_color`, `display_order`) VALUES
(1, 'PENDING', 'รอดำเนินการ', 'Pending', '#ffc107', 1),
(2, 'REVIEWING', 'กำลังตรวจสอบ', 'Reviewing', '#17a2b8', 2),
(3, 'APPROVED', 'อนุมัติ', 'Approved', '#28a745', 3),
(4, 'REJECTED', 'ไม่อนุมัติ', 'Rejected', '#dc3545', 4),
(5, 'CANCELLED', 'ยกเลิก', 'Cancelled', '#6c757d', 5);

-- --------------------------------------------------------

--
-- Structure for view `vw_section_request_details`
--
DROP TABLE IF EXISTS `vw_section_request_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_section_request_details`  AS SELECT `req`.`request_id` AS `request_id`, `req`.`tracking_code` AS `tracking_code`, `req`.`student_code` AS `student_code`, concat(`lp`.`title_prefix`,' ',`lp`.`first_name`,' ',`lp`.`last_name`) AS `learner_fullname`, `lp`.`email_address` AS `learner_email`, `lp`.`faculty_name` AS `faculty_name`, `lp`.`academic_level` AS `academic_level`, `req`.`subject_code` AS `subject_code`, `sub`.`title_th` AS `subject_title_th`, `sub`.`lec_credit` AS `lec_credit`, `sub`.`lab_credit` AS `lab_credit`, concat(`sub`.`lec_credit`,'-',`sub`.`lab_credit`,'-',`sub`.`self_credit`) AS `credit_structure`, `req`.`staff_id` AS `staff_id`, concat(`st`.`title_prefix`,' ',`st`.`first_name`,' ',`st`.`last_name`) AS `staff_fullname`, `req`.`status_id` AS `status_id`, `ws`.`status_key` AS `status_key`, `ws`.`label_th` AS `status_label_th`, `ws`.`badge_color` AS `badge_color`, `req`.`term_semester` AS `term_semester`, `req`.`term_year` AS `term_year`, `req`.`request_reason` AS `request_reason`, `req`.`headcount_estimate` AS `headcount_estimate`, `req`.`has_conflict_schedule` AS `has_conflict_schedule`, `req`.`submission_date` AS `submission_date`, `req`.`evaluated_at` AS `evaluated_at`, `req`.`evaluated_by` AS `evaluated_by`, `req`.`evaluation_remark` AS `evaluation_remark`, `req`.`approved_at` AS `approved_at`, `req`.`assigned_section` AS `assigned_section`, `req`.`created_at` AS `created_at`, `req`.`updated_at` AS `updated_at` FROM ((((`section_requests` `req` left join `learner_profiles` `lp` on(`req`.`student_code` = `lp`.`student_code`)) left join `subject_catalog` `sub` on(`req`.`subject_code` = `sub`.`subject_code`)) left join `academic_staff` `st` on(`req`.`staff_id` = `st`.`staff_id`)) left join `workflow_statuses` `ws` on(`req`.`status_id` = `ws`.`status_id`)) ORDER BY `req`.`created_at` DESC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academic_staff`
--
ALTER TABLE `academic_staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `uq_staff_email` (`email_address`);

--
-- Indexes for table `learner_profiles`
--
ALTER TABLE `learner_profiles`
  ADD PRIMARY KEY (`student_code`),
  ADD UNIQUE KEY `uq_learner_email` (`email_address`),
  ADD KEY `idx_faculty` (`faculty_name`);

--
-- Indexes for table `request_audit_logs`
--
ALTER TABLE `request_audit_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_request_ref` (`request_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `section_requests`
--
ALTER TABLE `section_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD UNIQUE KEY `uq_tracking_code` (`tracking_code`),
  ADD KEY `idx_student_code` (`student_code`),
  ADD KEY `idx_subject_code` (`subject_code`),
  ADD KEY `idx_status` (`status_id`),
  ADD KEY `idx_academic_term` (`term_semester`,`term_year`),
  ADD KEY `fk_req_staff` (`staff_id`);

--
-- Indexes for table `subject_catalog`
--
ALTER TABLE `subject_catalog`
  ADD PRIMARY KEY (`subject_code`),
  ADD KEY `idx_title_th` (`title_th`(50)),
  ADD KEY `idx_faculty` (`faculty_name`);

--
-- Indexes for table `workflow_statuses`
--
ALTER TABLE `workflow_statuses`
  ADD PRIMARY KEY (`status_id`),
  ADD UNIQUE KEY `uq_status_key` (`status_key`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academic_staff`
--
ALTER TABLE `academic_staff`
  MODIFY `staff_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request_audit_logs`
--
ALTER TABLE `request_audit_logs`
  MODIFY `log_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `section_requests`
--
ALTER TABLE `section_requests`
  MODIFY `request_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workflow_statuses`
--
ALTER TABLE `workflow_statuses`
  MODIFY `status_id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `request_audit_logs`
--
ALTER TABLE `request_audit_logs`
  ADD CONSTRAINT `fk_audit_request` FOREIGN KEY (`request_id`) REFERENCES `section_requests` (`request_id`) ON DELETE CASCADE;

--
-- Constraints for table `section_requests`
--
ALTER TABLE `section_requests`
  ADD CONSTRAINT `fk_req_staff` FOREIGN KEY (`staff_id`) REFERENCES `academic_staff` (`staff_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_req_status` FOREIGN KEY (`status_id`) REFERENCES `workflow_statuses` (`status_id`),
  ADD CONSTRAINT `fk_req_student` FOREIGN KEY (`student_code`) REFERENCES `learner_profiles` (`student_code`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_req_subject` FOREIGN KEY (`subject_code`) REFERENCES `subject_catalog` (`subject_code`) ON UPDATE CASCADE;
--
-- Database: `cinema_db`
--
CREATE DATABASE IF NOT EXISTS `cinema_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cinema_db`;

-- --------------------------------------------------------

--
-- Table structure for table `seat_types`
--

CREATE TABLE `seat_types` (
  `id` int(11) NOT NULL,
  `type_name` varchar(50) NOT NULL,
  `price` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seat_types`
--

INSERT INTO `seat_types` (`id`, `type_name`, `price`) VALUES
(1, 'Normal Seat', 160.00),
(2, 'VIP Leather Seat', 250.00);

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `ticket_code` varchar(20) NOT NULL,
  `movie_title` varchar(150) NOT NULL,
  `seat_type_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `has_popcorn` tinyint(1) NOT NULL DEFAULT 0,
  `total_price` decimal(8,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `ticket_code`, `movie_title`, `seat_type_id`, `quantity`, `has_popcorn`, `total_price`, `created_at`) VALUES
(1, 'TK-001', 'Avatar: The Way of Water', 1, 2, 0, 320.00, '2026-09-07 02:52:14'),
(2, 'TK-002', 'Oppenheimer', 2, 1, 1, 340.00, '2026-09-07 02:52:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `seat_types`
--
ALTER TABLE `seat_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket_code` (`ticket_code`),
  ADD KEY `seat_type_id` (`seat_type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `seat_types`
--
ALTER TABLE `seat_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`seat_type_id`) REFERENCES `seat_types` (`id`);
--
-- Database: `food_db`
--
CREATE DATABASE IF NOT EXISTS `food_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `food_db`;

-- --------------------------------------------------------

--
-- Table structure for table `foods`
--

CREATE TABLE `foods` (
  `id` int(11) NOT NULL,
  `name_th` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `foods`
--

INSERT INTO `foods` (`id`, `name_th`, `category`, `image`) VALUES
(1, 'ผัดไทยกุ้งสด', 'อาหารคาว', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `id` int(11) NOT NULL,
  `food_id` int(11) NOT NULL,
  `recipe_name` varchar(255) NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`id`, `food_id`, `recipe_name`, `quantity`, `unit_name`) VALUES
(1, 1, 'เส้นจันท์', 150.00, 'กรัม'),
(2, 1, 'กุ้งสด', 4.00, 'ตัว'),
(3, 1, 'น้ำซอสผัดไทย', 2.00, 'ช้อนโต๊ะ');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `foods`
--
ALTER TABLE `foods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `food_id` (`food_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `foods`
--
ALTER TABLE `foods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `recipes`
--
ALTER TABLE `recipes`
  ADD CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `foods` (`id`) ON DELETE CASCADE;
--
-- Database: `math_quest`
--
CREATE DATABASE IF NOT EXISTS `math_quest` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `math_quest`;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `icon` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `icon`) VALUES
(1, 'การบวกและการลบ', 'ฝึกคำนวณจำนวนเต็มและทศนิยมพื้นฐาน', '➕'),
(2, 'การคูณและการหาร', 'ฝึกความแม่นยำในการคูณและหาร', '✖️'),
(3, 'ร้อยละ', 'ฝึกคิดเปอร์เซ็นต์และโจทย์สถานการณ์', '％'),
(4, 'สมการเบื้องต้น', 'ฝึกแก้สมการตัวแปรเดียว', '𝑥'),
(5, 'เรขาคณิต', 'ฝึกพื้นที่ เส้นรอบรูป และรูปทรง', '📐'),
(6, 'โจทย์ประยุกต์', 'ฝึกวิเคราะห์โจทย์จากสถานการณ์จริง', '🧠');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `question` text NOT NULL,
  `choice_a` varchar(255) NOT NULL,
  `choice_b` varchar(255) NOT NULL,
  `choice_c` varchar(255) NOT NULL,
  `choice_d` varchar(255) NOT NULL,
  `correct_answer` enum('A','B','C','D') NOT NULL,
  `explanation` varchar(500) DEFAULT NULL,
  `difficulty` enum('ง่าย','ปานกลาง','ยาก') NOT NULL DEFAULT 'ง่าย',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `category_id`, `question`, `choice_a`, `choice_b`, `choice_c`, `choice_d`, `correct_answer`, `explanation`, `difficulty`, `created_at`) VALUES
(1, 1, '125 + 75 มีค่าเท่าไร?', '180', '190', '200', '210', 'C', '125 + 75 = 200', 'ง่าย', '2026-10-17 20:23:18'),
(2, 1, '450 - 175 มีค่าเท่าไร?', '225', '250', '275', '300', 'C', '450 - 175 = 275', 'ง่าย', '2026-10-17 20:23:18'),
(3, 1, '12.5 + 7.5 มีค่าเท่าไร?', '18', '19', '20', '21', 'C', '12.5 + 7.5 = 20', 'ง่าย', '2026-10-17 20:23:18'),
(4, 1, '1,000 - 365 มีค่าเท่าไร?', '625', '635', '645', '655', 'B', '1,000 - 365 = 635', 'ง่าย', '2026-10-17 20:23:18'),
(5, 1, '245 + 386 มีค่าเท่าไร?', '621', '631', '641', '651', 'B', '245 + 386 = 631', 'ปานกลาง', '2026-10-17 20:23:18'),
(6, 2, '12 × 8 มีค่าเท่าไร?', '86', '96', '106', '116', 'B', '12 × 8 = 96', 'ง่าย', '2026-10-17 20:23:18'),
(7, 2, '144 ÷ 12 มีค่าเท่าไร?', '10', '11', '12', '14', 'C', '144 ÷ 12 = 12', 'ง่าย', '2026-10-17 20:23:18'),
(8, 2, '25 × 16 มีค่าเท่าไร?', '300', '350', '400', '450', 'C', '25 × 16 = 400', 'ปานกลาง', '2026-10-17 20:23:18'),
(9, 2, '360 ÷ 15 มีค่าเท่าไร?', '20', '24', '30', '36', 'B', '360 ÷ 15 = 24', 'ปานกลาง', '2026-10-17 20:23:18'),
(10, 2, '18 × 7 - 6 มีค่าเท่าไร?', '110', '116', '120', '126', 'C', '18 × 7 = 126 แล้ว 126 - 6 = 120', 'ปานกลาง', '2026-10-17 20:23:18'),
(11, 3, '20% ของ 500 เท่ากับเท่าไร?', '50', '80', '100', '120', 'C', '500 × 20/100 = 100', 'ง่าย', '2026-10-17 20:23:18'),
(12, 3, 'สินค้าราคา 800 บาท ลด 10% เหลือกี่บาท?', '700', '720', '740', '760', 'B', 'ส่วนลด 80 บาท จึงเหลือ 720 บาท', 'ง่าย', '2026-10-17 20:23:18'),
(13, 3, '50 เป็นกี่เปอร์เซ็นต์ของ 200?', '20%', '25%', '30%', '40%', 'B', '50/200 × 100 = 25%', 'ง่าย', '2026-10-17 20:23:18'),
(14, 3, 'ราคา 1,200 บาท เพิ่มขึ้น 15% เป็นเท่าไร?', '1,320', '1,350', '1,380', '1,400', 'C', '1,200 × 1.15 = 1,380', 'ปานกลาง', '2026-10-17 20:23:18'),
(15, 3, 'นักเรียนสอบได้ 45 จาก 60 คะแนน คิดเป็นกี่เปอร์เซ็นต์?', '65%', '70%', '75%', '80%', 'C', '45/60 × 100 = 75%', 'ปานกลาง', '2026-10-17 20:23:18'),
(16, 4, 'x + 8 = 20 แล้ว x เท่ากับเท่าไร?', '10', '12', '14', '16', 'B', 'ย้าย 8 ไปอีกข้าง: x = 12', 'ง่าย', '2026-10-17 20:23:18'),
(17, 4, '3x = 27 แล้ว x เท่ากับเท่าไร?', '6', '7', '8', '9', 'D', '27 ÷ 3 = 9', 'ง่าย', '2026-10-17 20:23:18'),
(18, 4, '2x + 5 = 17 แล้ว x เท่ากับเท่าไร?', '5', '6', '7', '8', 'B', '2x = 12 ดังนั้น x = 6', 'ปานกลาง', '2026-10-17 20:23:18'),
(19, 4, '5x - 10 = 25 แล้ว x เท่ากับเท่าไร?', '5', '6', '7', '8', 'C', '5x = 35 ดังนั้น x = 7', 'ปานกลาง', '2026-10-17 20:23:18'),
(20, 4, '4(x + 2) = 24 แล้ว x เท่ากับเท่าไร?', '3', '4', '5', '6', 'B', '4(x+2)=24 → x+2=6 → x=4', 'ยาก', '2026-10-17 20:23:18'),
(21, 5, 'สี่เหลี่ยมผืนผ้ายาว 10 ซม. กว้าง 5 ซม. มีพื้นที่เท่าไร?', '15', '30', '50', '60', 'C', 'พื้นที่ = 10 × 5 = 50 ตารางเซนติเมตร', 'ง่าย', '2026-10-17 20:23:18'),
(22, 5, 'สี่เหลี่ยมจัตุรัสด้านละ 6 ซม. มีเส้นรอบรูปเท่าไร?', '12', '18', '24', '36', 'C', 'เส้นรอบรูป = 4 × 6 = 24 ซม.', 'ง่าย', '2026-10-17 20:23:18'),
(23, 5, 'สามเหลี่ยมฐาน 8 ซม. สูง 6 ซม. มีพื้นที่เท่าไร?', '14', '24', '28', '48', 'B', 'พื้นที่ = 1/2 × 8 × 6 = 24', 'ปานกลาง', '2026-10-17 20:23:18'),
(24, 5, 'วงกลมรัศมี 7 ซม. ใช้ π = 22/7 พื้นที่เท่าไร?', '44', '88', '154', '308', 'C', 'พื้นที่ = 22/7 × 7 × 7 = 154', 'ปานกลาง', '2026-10-17 20:23:18'),
(25, 5, 'สี่เหลี่ยมผืนผ้ามีพื้นที่ 72 ตร.ซม. และกว้าง 8 ซม. ยาวเท่าไร?', '7', '8', '9', '10', 'C', '72 ÷ 8 = 9', 'ปานกลาง', '2026-10-17 20:23:18'),
(26, 6, 'มีเงิน 500 บาท ซื้อของ 3 ชิ้น ชิ้นละ 120 บาท เหลือเงินเท่าไร?', '120', '140', '160', '180', 'B', 'ซื้อ 3 × 120 = 360 บาท เหลือ 500 - 360 = 140 บาท', 'ง่าย', '2026-10-17 20:23:18'),
(27, 6, 'รถวิ่งด้วยความเร็ว 60 กม./ชม. เป็นเวลา 2 ชั่วโมง จะเดินทางกี่กิโลเมตร?', '100', '110', '120', '130', 'C', 'ระยะทาง = ความเร็ว × เวลา = 120 กม.', 'ง่าย', '2026-10-17 20:23:18'),
(28, 6, 'มีนักเรียน 40 คน เป็นผู้หญิง 60% มีนักเรียนหญิงกี่คน?', '20', '22', '24', '26', 'C', '40 × 60% = 24', 'ปานกลาง', '2026-10-17 20:23:18'),
(29, 6, 'ร้านค้าซื้อสินค้า 400 บาท ขาย 500 บาท ได้กำไรกี่เปอร์เซ็นต์ของทุน?', '20%', '25%', '30%', '40%', 'B', 'กำไร 100 บาท / 400 × 100 = 25%', 'ปานกลาง', '2026-10-17 20:23:18'),
(30, 6, 'ถ้า 3 เล่มราคา 90 บาท หนังสือ 8 เล่มราคาเท่ากันจะเป็นเท่าไร?', '180', '210', '240', '270', 'C', 'เล่มละ 30 บาท × 8 = 240 บาท', 'ปานกลาง', '2026-10-17 20:23:18');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_results`
--

CREATE TABLE `quiz_results` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `total_questions` int(11) NOT NULL,
  `percentage` int(11) NOT NULL,
  `played_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_question_category` (`category_id`);

--
-- Indexes for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_result_category` (`category_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `quiz_results`
--
ALTER TABLE `quiz_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `fk_question_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD CONSTRAINT `fk_result_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2026-09-17 06:07:31', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"en_GB\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `smart_helpdesk`
--
CREATE DATABASE IF NOT EXISTS `smart_helpdesk` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `smart_helpdesk`;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'Hardware & PC', 'เปิดไม่ติด จอฟ้า เครื่องดับ อุปกรณ์ชำรุด'),
(2, 'Software & OS', 'Windows ติดไวรัส โปรแกรมเปิดไม่ขึ้น'),
(3, 'Network & Internet', 'เชื่อมต่ออินเทอร์เน็ตไม่ได้ สายแลนชำรุด'),
(4, 'Printer & Devices', 'ปริ้นเตอร์ไม่ออก กระดาษติด สแกนไม่ได้');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `body` text NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `score` tinyint(3) UNSIGNED NOT NULL CHECK (`score` between 1 and 5),
  `feedback` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`id`, `ticket_id`, `score`, `feedback`, `created_at`) VALUES
(1, 1, 3, 'ดีมาก', '2026-09-17 14:51:39'),
(7, 2, 4, 'เยี่ยมมาก', '2026-09-17 14:54:13'),
(8, 3, 5, 'เยี่ยมมาก', '2026-09-17 15:06:14'),
(9, 4, 4, 'เยี่ยมมาก', '2026-09-17 15:07:16'),
(10, 5, 5, 'เยี่ยมมาก', '2026-09-24 18:24:55'),
(11, 6, 5, 'เยี่ยมมาก', '2026-09-24 18:39:31');

-- --------------------------------------------------------

--
-- Table structure for table `status_logs`
--

CREATE TABLE `status_logs` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `changed_by` int(11) NOT NULL,
  `from_status` enum('Open','Assigned','InProgress','Resolved','Closed') NOT NULL,
  `to_status` enum('Open','Assigned','InProgress','Resolved','Closed') NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `status_logs`
--

INSERT INTO `status_logs` (`id`, `ticket_id`, `changed_by`, `from_status`, `to_status`, `note`, `created_at`) VALUES
(1, 1, 3, '', 'Open', 'User created ticket', '2026-09-17 14:38:35'),
(2, 1, 1, 'Open', 'Assigned', NULL, '2026-09-17 14:47:08'),
(3, 1, 2, 'Assigned', 'InProgress', NULL, '2026-09-17 14:47:30'),
(4, 1, 2, 'InProgress', 'Resolved', 'เรียบร้อย', '2026-09-17 14:47:43'),
(5, 1, 3, 'Resolved', 'Closed', 'ผู้ใช้ประเมินและปิดงาน', '2026-09-17 14:51:39'),
(6, 2, 3, '', 'Open', 'User created ticket', '2026-09-17 14:52:24'),
(7, 2, 1, 'Open', 'Assigned', NULL, '2026-09-17 14:52:35'),
(8, 2, 2, 'Assigned', 'InProgress', NULL, '2026-09-17 14:52:48'),
(9, 2, 2, 'InProgress', 'Resolved', 'เรียบร้อย', '2026-09-17 14:53:28'),
(10, 2, 3, 'Resolved', 'InProgress', 'ยังไม่ได้', '2026-09-17 14:53:45'),
(11, 2, 2, 'InProgress', 'Resolved', 'เรียบร้อย', '2026-09-17 14:53:58'),
(12, 2, 3, 'Resolved', 'Closed', 'ผู้ใช้ประเมินและปิดงาน', '2026-09-17 14:54:13'),
(13, 3, 3, '', 'Open', 'User created ticket', '2026-09-17 15:05:32'),
(14, 3, 1, 'Open', 'Assigned', NULL, '2026-09-17 15:05:45'),
(15, 3, 1, 'Assigned', 'InProgress', NULL, '2026-09-17 15:05:49'),
(16, 3, 1, 'InProgress', 'Resolved', 'เรียบร้อย', '2026-09-17 15:05:52'),
(17, 3, 1, 'Resolved', 'InProgress', 'ยังไม่ได้', '2026-09-17 15:06:03'),
(18, 3, 1, 'InProgress', 'Resolved', 'เรียบร้อย', '2026-09-17 15:06:12'),
(19, 3, 1, 'Resolved', 'Closed', 'ผู้ใช้ประเมินและปิดงาน', '2026-09-17 15:06:14'),
(20, 4, 3, '', 'Open', 'User created ticket', '2026-09-17 15:06:38'),
(21, 4, 1, 'Open', 'Assigned', NULL, '2026-09-17 15:06:48'),
(22, 4, 2, 'Assigned', 'InProgress', NULL, '2026-09-17 15:06:59'),
(23, 4, 2, 'InProgress', 'Resolved', 'เรียบร้อย', '2026-09-17 15:07:02'),
(24, 4, 3, 'Resolved', 'Closed', 'ผู้ใช้ประเมินและปิดงาน', '2026-09-17 15:07:16'),
(25, 5, 1, '', 'Open', 'User created ticket', '2026-09-24 18:24:12'),
(26, 5, 1, 'Open', 'Assigned', NULL, '2026-09-24 18:24:22'),
(27, 5, 1, 'Assigned', 'InProgress', NULL, '2026-09-24 18:24:26'),
(28, 5, 1, 'InProgress', 'Resolved', 'เรียบร้อย', '2026-09-24 18:24:31'),
(29, 5, 1, 'Resolved', 'InProgress', 'ยังไม่ได้', '2026-09-24 18:24:51'),
(30, 5, 1, 'InProgress', 'Resolved', 'เรียบร้อย', '2026-09-24 18:24:53'),
(31, 5, 1, 'Resolved', 'Closed', 'ผู้ใช้ประเมินและปิดงาน', '2026-09-24 18:24:55'),
(32, 6, 3, '', 'Open', 'User created ticket', '2026-09-24 18:37:36'),
(33, 6, 1, 'Open', 'Assigned', NULL, '2026-09-24 18:38:29'),
(34, 6, 2, 'Assigned', 'InProgress', NULL, '2026-09-24 18:38:50'),
(35, 6, 2, 'InProgress', 'Resolved', 'เรียบร้อย', '2026-09-24 18:38:57'),
(36, 6, 3, 'Resolved', 'Closed', 'ผู้ใช้ประเมินและปิดงาน', '2026-09-24 18:39:31');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `technician_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` enum('Open','Assigned','InProgress','Resolved','Closed') NOT NULL DEFAULT 'Open',
  `priority` enum('Low','Medium','High','Urgent') NOT NULL DEFAULT 'Medium',
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `resolved_at` datetime DEFAULT NULL,
  `closed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `user_id`, `category_id`, `technician_id`, `title`, `description`, `status`, `priority`, `image_path`, `created_at`, `updated_at`, `resolved_at`, `closed_at`) VALUES
(1, 3, 3, 2, 'เปิดไม่ติด', 'หอพักแสนสุข', 'Closed', 'High', NULL, '2026-09-17 14:38:35', '2026-09-17 14:51:39', '2026-09-17 09:47:43', '2026-09-17 09:51:39'),
(2, 3, 1, 2, 'จอฟ้ายาวไม่ดับ', 'หอพักแสนสุข', 'Closed', 'Medium', NULL, '2026-09-17 14:52:24', '2026-09-17 14:54:13', '2026-09-17 09:53:58', '2026-09-17 09:54:13'),
(3, 3, 1, 2, 'หนัก', 'หอพักแสนสุข', 'Closed', 'Urgent', '7659fa9155bb03715ec1c7b5.jpg', '2026-09-17 15:05:32', '2026-09-17 15:06:14', '2026-09-17 10:06:12', '2026-09-17 10:06:14'),
(4, 3, 1, 2, 'หนักมาก', 'หอพักแสนสุข', 'Closed', 'Medium', 'd9479feaf6665cf87ea48481.png', '2026-09-17 15:06:38', '2026-09-17 15:07:16', '2026-09-17 10:07:02', '2026-09-17 10:07:16'),
(5, 1, 3, 2, 'พัง', 'B725', 'Closed', 'Low', NULL, '2026-09-24 18:24:12', '2026-09-24 18:24:55', '2026-09-24 13:24:53', '2026-09-24 13:24:55'),
(6, 3, 4, 2, 'ไม่ติด', 'b725', 'Closed', 'Urgent', NULL, '2026-09-24 18:37:36', '2026-09-24 18:39:31', '2026-09-24 13:38:57', '2026-09-24 13:39:31');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('user','technician','admin') NOT NULL DEFAULT 'user',
  `line_user_id` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `role`, `line_user_id`, `created_at`) VALUES
(1, 'Admin IT Support', 'admin@helpdesk.local', '$2y$10$wE0vjI7n5yQyB9yP8B1XjeC8nN5D8t6XyK7qP9zM6vY8rQ7kO8vOe', 'admin', NULL, '2026-09-17 14:10:11'),
(2, 'ช่างซ่อม สมชาย (IT Tech)', 'tech1@helpdesk.local', '$2y$10$eA3f7pDqL8Hj/YxU2wR/A.WvGqTfxGv7Csm6J41v81mJqEfZW02kG', 'technician', NULL, '2026-09-17 14:10:11'),
(3, 'สมศรี ผู้ใช้ทั่วไป (User)', 'user1@helpdesk.local', '$2y$10$wE0vjI7n5yQyB9yP8B1XjeC8nN5D8t6XyK7qP9zM6vY8rQ7kO8vOe', 'user', NULL, '2026-09-17 14:10:11');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_comments_ticket` (`ticket_id`),
  ADD KEY `fk_comments_user` (`user_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket_id` (`ticket_id`);

--
-- Indexes for table `status_logs`
--
ALTER TABLE `status_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_logs_ticket` (`ticket_id`),
  ADD KEY `fk_logs_user` (`changed_by`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tickets_user` (`user_id`),
  ADD KEY `fk_tickets_category` (`category_id`),
  ADD KEY `fk_tickets_technician` (`technician_id`),
  ADD KEY `idx_tickets_status` (`status`),
  ADD KEY `idx_tickets_priority` (`priority`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_role` (`role`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `status_logs`
--
ALTER TABLE `status_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_comments_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_comments_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `fk_ratings_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `status_logs`
--
ALTER TABLE `status_logs`
  ADD CONSTRAINT `fk_logs_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_logs_user` FOREIGN KEY (`changed_by`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `fk_tickets_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tickets_technician` FOREIGN KEY (`technician_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_tickets_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;
--
-- Database: `special_course_db`
--
CREATE DATABASE IF NOT EXISTS `special_course_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `special_course_db`;

-- --------------------------------------------------------

--
-- Table structure for table `section_requests`
--

CREATE TABLE `section_requests` (
  `id` int(11) NOT NULL,
  `request_number` varchar(50) NOT NULL,
  `student_code` varchar(20) NOT NULL,
  `subject_code` varchar(20) NOT NULL,
  `term_semester` int(11) NOT NULL,
  `term_year` int(11) NOT NULL,
  `request_reason` text NOT NULL,
  `headcount_estimate` int(11) DEFAULT 1,
  `has_conflict_schedule` tinyint(1) DEFAULT 0,
  `status_id` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `section_requests`
--

INSERT INTO `section_requests` (`id`, `request_number`, `student_code`, `subject_code`, `term_semester`, `term_year`, `request_reason`, `headcount_estimate`, `has_conflict_schedule`, `status_id`, `created_at`) VALUES
(1, 'SCR-202610-2803', '674230008', 'CS112', 1, 2569, 'ต้องมาเรียนใหม่ครับ เลยมาลงเรียนแก้ครับ', 1, 0, 1, '2026-10-18 04:58:35'),
(2, 'SCR-202610-1149', '456456456', 'CS112', 1, 2569, '23423423423gfhyffhfthfth', 1, 0, 1, '2026-10-18 04:59:02'),
(3, 'SCR-202610-2698', '674230008', 'CS112', 1, 2569, 'หพเ่หำรนเ่จหำ่เหำ่เหำเ', 5, 0, 1, '2026-10-18 05:04:16'),
(4, 'SCR-202610-8891', '674230008', 'CS112', 2, 2569, 'หำนด่าหำย่ดหรยำ่ดยหำ่ดหำดหำดห', 5, 0, 1, '2026-10-18 05:08:55');

-- --------------------------------------------------------

--
-- Table structure for table `subject_catalog`
--

CREATE TABLE `subject_catalog` (
  `id` int(11) NOT NULL,
  `subject_code` varchar(20) NOT NULL,
  `subject_name` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `section_requests`
--
ALTER TABLE `section_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subject_catalog`
--
ALTER TABLE `subject_catalog`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `section_requests`
--
ALTER TABLE `section_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `subject_catalog`
--
ALTER TABLE `subject_catalog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Database: `stock_db`
--
CREATE DATABASE IF NOT EXISTS `stock_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `stock_db`;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `cost_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `sell_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `stock_quantity` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `code`, `name`, `cost_price`, `sell_price`, `stock_quantity`, `created_at`) VALUES
(1, 'P001', 'กาแฟคั่วเข้ม 250g', 120.00, 180.00, 25, '2026-09-20 12:08:43'),
(2, 'P002', 'ชาเขียวมัทฉะ 100g', 150.00, 220.00, 15, '2026-09-20 12:08:43'),
(3, 'P003', 'แก้วเซรามิกเก็บความเย็น', 80.00, 150.00, 8, '2026-09-20 12:08:43'),
(4, '002', 'Iphone 18 ', 25000.00, 30000.00, 5, '2026-09-20 12:22:00');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `total_revenue` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_profit` decimal(10,2) NOT NULL DEFAULT 0.00,
  `sale_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `customer_name`, `total_revenue`, `total_profit`, `sale_date`) VALUES
(1, 'plam', 30000.00, 5000.00, '2026-09-20 12:22:45');

-- --------------------------------------------------------

--
-- Table structure for table `sale_items`
--

CREATE TABLE `sale_items` (
  `id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `cost_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `sell_price` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sale_items`
--

INSERT INTO `sale_items` (`id`, `sale_id`, `product_id`, `quantity`, `cost_price`, `sell_price`) VALUES
(1, 1, 4, 1, 25000.00, 30000.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_sale_items_sales` (`sale_id`),
  ADD KEY `fk_sale_items_products` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sale_items`
--
ALTER TABLE `sale_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `sale_items`
--
ALTER TABLE `sale_items`
  ADD CONSTRAINT `fk_sale_items_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `fk_sale_items_sales` FOREIGN KEY (`sale_id`) REFERENCES `sales` (`id`) ON DELETE CASCADE;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
