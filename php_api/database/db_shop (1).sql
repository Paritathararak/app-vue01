-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2026 at 01:13 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'เครื่องใช้ไฟฟ้า'),
(2, 'เสื้อผ้า'),
(3, 'รองเท้า');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(8) UNSIGNED ZEROFILL NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `firstName`, `lastName`, `phone`, `username`, `password`) VALUES
(00000001, 'สมชาย', 'ใจดี', '0812345678', 'somchai', 'pass1234'),
(00000002, 'วิภา', 'สุขสันต์', '0898765432', 'wipa', 'wipa2025'),
(00000003, 'John', 'Doe', '0991122334', 'johnd', 'securepwd'),
(00000004, 'เมษา', 'เด็กดี', '038743690', 'mesa', '$2y$10$tSSl6/EruDffk'),
(00000005, 'มานะ', 'มีใจ', '038754920', 'mana', '$2y$10$tA0rn9nxLE.i6q5U5qvgMuij0eJZJkNEQMTRn3lJsDECEt1jSq58u'),
(00000006, 'jenny', 'jenny', '06785111236', 'jen', '$2y$10$PAr1hsvXloChl09oLSG9HOMayix/jyabPX4IDPs4jaEgzk.pNtFu2'),
(00000007, 'Parita', 'Thararak', '0924670266', 'Paritajenny', '$2y$10$t7iCH1z36YTZiCkY3vN08.Vv6TfZ7m5az/6shqJBpBDB5A1J97Gau');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `emp_id` int(10) UNSIGNED ZEROFILL NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `department` varchar(50) NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`emp_id`, `full_name`, `department`, `salary`, `active`, `created_at`) VALUES
(0000000001, 'สมชาย ใจดี', 'IT', '35000.00', 1, '2026-01-18 10:27:14'),
(0000000002, 'สมหญิง ดีงาม', 'บัญชี', '28000.00', 1, '2026-01-18 10:27:14'),
(0000000003, 'อนันต์ สุขใจ', 'การตลาด', '25000.00', 0, '2026-01-18 10:27:14'),
(0000000004, 'สุดา พรมดี', 'ทรัพยากรบุคคล', '32000.00', 1, '2026-01-18 10:27:14'),
(0000000005, 'นวรัตน์  เกิดผล', 'คอมพิวเตอร์', '25000.00', 1, '2026-01-25 09:43:49');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) UNSIGNED ZEROFILL NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` text DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `description`, `price`, `image`, `stock`, `category_id`, `created_at`) VALUES
(00000000001, 'ผ้าโพกหัวแฟชั่น', 'ผ้าโพกหัวแฟชั่นสวยๆใส่แล้วดูรวย\r\n', '199.00', 'jen1.jpg', 50, 2, '2026-01-25 10:42:55'),
(00000000002, 'แว่นเก๋ๆ', 'ทรงแว๊นนน', '799.00', 'jen2.jpg', 30, 2, '2026-01-25 10:42:55'),
(00000000003, 'ที่คาดผม', 'ที่คาดผมเวอร์ๆ พส จีนนน', '1299.00', '1771756163_1771684215_S__3735564_0.jpg', 20, 2, '2026-01-25 10:42:55'),
(00000000004, 'เสื้อแฟชั่น', 'สวย', '5500.00', '1771756136_1771685618_S__3735563_0.jpg', 5, 2, '2026-02-22 08:25:48'),
(00000000005, 'กระโปรง', 'ฟิวน่ารัก', '9662.00', '1771759817_1771145321_กระโปร.jpg', 50, 2, '2026-02-22 11:30:17'),
(00000000006, 'ชุดสม็อก ', 'เดลต้า', '450.00', '1771759854_1771684121_S__3735568_0.jpg', 53, 2, '2026-02-22 11:30:54'),
(00000000007, 'เสื้อครอป', 'สีเทา', '880.00', '1771759889_S__3735557_0.jpg', 30, 2, '2026-02-22 11:31:29'),
(00000000008, 'เสื้อครอปขาว', 'สีขาวน่ารักสดใส', '990.00', '1771759923_S__3735556_0.jpg', 50, 2, '2026-02-22 11:32:03');

-- --------------------------------------------------------

--
-- Table structure for table `type`
--

CREATE TABLE `type` (
  `type_id` int(11) NOT NULL COMMENT 'รหัสสินค้า',
  `type_name` varchar(30) NOT NULL COMMENT 'ชื่อประเภท'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `type`
--

INSERT INTO `type` (`type_id`, `type_name`) VALUES
(1, 'เครื่องใช้ไฟฟ้า'),
(2, 'เครื่องเขียน');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`type_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(8) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `emp_id` int(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `type`
--
ALTER TABLE `type`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสสินค้า', AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
