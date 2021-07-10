-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 08, 2021 at 09:24 PM
-- Server version: 10.3.29-MariaDB-cll-lve
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hubbuddi_lokthienwesterndb`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_address`
--

CREATE TABLE `tbl_address` (
  `email` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `address` varchar(300) NOT NULL,
  `phone` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_address`
--

INSERT INTO `tbl_address` (`email`, `name`, `address`, `phone`) VALUES
('', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_banners`
--

CREATE TABLE `tbl_banners` (
  `banner_id` int(6) NOT NULL,
  `banner_name` varchar(150) NOT NULL,
  `date_created` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_banners`
--

INSERT INTO `tbl_banners` (`banner_id`, `banner_name`, `date_created`) VALUES
(1, 'New User', '2021-07-01 12:36:29.000000'),
(2, 'Business Hour', '2021-07-01 12:37:16.000000'),
(3, 'Food Categories', '2021-07-01 12:37:27.000000'),
(4, 'Contact', '2021-07-01 12:37:27.000000'),
(5, 'Delivery Area', '2021-07-01 12:37:51.000000');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_carts`
--

CREATE TABLE `tbl_carts` (
  `email` varchar(50) NOT NULL,
  `product_id` varchar(10) NOT NULL,
  `qty` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_history`
--

CREATE TABLE `tbl_history` (
  `orderid` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `product_id` varchar(50) NOT NULL,
  `qty` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_products`
--

CREATE TABLE `tbl_products` (
  `product_id` int(6) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_price` double(8,2) NOT NULL,
  `product_categ` varchar(50) NOT NULL,
  `product_desc` varchar(500) NOT NULL,
  `product_rating` varchar(1) NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_products`
--

INSERT INTO `tbl_products` (`product_id`, `product_name`, `product_price`, `product_categ`, `product_desc`, `product_rating`, `date_created`) VALUES
(1, 'Fried Chicken Burger', 7.00, 'BurgerHotdog', 'Chicken Chop + Egg + Sliced Cheese + Vegetables and French Fries\r\n', '5', '2021-06-08 03:20:48'),
(2, 'Grilled Chicken Burger', 7.00, 'BurgerHotdog', 'Grilled Chicken + Egg + Sliced Cheese + Vegetables and French Fries\r\n', '4', '2021-06-08 03:27:36'),
(3, 'Hotdog', 6.00, 'BurgerHotdog', 'Hotdog + Egg + Sliced Cheese + Vegetables and French Fries\r\n', '4', '2021-06-08 03:28:21'),
(4, 'Fried Chicken Chop Rice', 8.00, 'Rice', 'Rice + Chicken Chop + Egg + Vegetables', '4', '2021-06-08 03:30:19'),
(5, 'Grilled Chicken Chop Rice', 8.00, 'Rice', 'Rice + Grilled Chicken + Egg + Vegetables', '5', '2021-06-08 03:31:26'),
(6, 'Grilled Chicken Hotdog Rice With Egg', 7.00, 'Rice', 'Grilled Chicken Hotdog Rice With Egg.', '4', '2021-06-08 03:32:08'),
(7, 'Deep Chicken Chop', 8.00, 'Main Course', 'Extra cheese chicken chop with french fries and vegetables.', '5', '2021-06-08 03:33:43'),
(8, 'Grilled Chicken Chop', 8.00, 'Main Course', 'Grilled chicken chop with barbecue sauce.', '4', '2021-06-08 03:34:21'),
(9, 'Chicken Chop Platter', 15.00, 'Main Course', 'Cheese chicken chop with french fries and vegetables.', '5', '2021-06-08 03:34:53'),
(10, 'Fried Chicken Aglio Olio', 9.00, 'Spaghetti', 'Fried Chicken with Spaghetti Aglio Olio.', '4', '2021-06-08 03:37:04'),
(11, 'Grilled Chicken Aglio Olio', 9.00, 'Spaghetti', 'Grilled Chicken with Spaghetti Aglio Olio.', '5', '2021-06-08 03:37:49'),
(12, 'Mushroom Aglio Olio', 9.00, 'Spaghetti', 'Simple Vegan Mushroom Aglio Olio Spaghetti.', '4', '2021-06-08 03:38:23'),
(13, 'Chicken Bolognese', 9.00, 'Spaghetti', 'Spaghetti With Chicken Bolognese.', '5', '2021-06-08 03:38:53'),
(14, 'Fried Enoki', 5.00, 'Snacks', 'Crispy and delicious golden fried enoki!', '4', '2021-06-08 03:41:05'),
(15, 'French Fries', 5.00, 'Snacks', 'Crispy french fries with our chili sauce, delicious!', '3', '2021-06-08 03:41:28'),
(16, 'Cheezy / Salted Egg Fries', 5.00, 'Snacks', 'If you like salted egg yolk, you will definitely like our cheese/salted egg fries, highly recommended!', '5', '2021-06-08 03:42:22'),
(17, 'Chicken Nugget', 5.00, 'Snacks', 'A set of delicious chicken nuggets like MCD.', '4', '2021-06-08 03:42:50'),
(18, 'Fried Sausage', 5.00, 'Snacks', 'Sausages are incredibly fragrant whether they are eaten as a snack or with rice!', '4', '2021-06-08 03:43:16'),
(19, 'Mix Fried Platter', 10.00, 'Snacks', 'The snack platter is here! Fried Sausage + Chicken Nuggets + French Fries + Fried Enoki Mushroom ~', '5', '2021-06-08 03:43:47');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_purchased`
--

CREATE TABLE `tbl_purchased` (
  `orderid` varchar(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `paid` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL,
  `date_purchase` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `username` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `password` varchar(40) NOT NULL,
  `reg_date` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `otp` varchar(6) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `contact` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_banners`
--
ALTER TABLE `tbl_banners`
  ADD PRIMARY KEY (`banner_id`);

--
-- Indexes for table `tbl_products`
--
ALTER TABLE `tbl_products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`username`,`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_banners`
--
ALTER TABLE `tbl_banners`
  MODIFY `banner_id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_products`
--
ALTER TABLE `tbl_products`
  MODIFY `product_id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
