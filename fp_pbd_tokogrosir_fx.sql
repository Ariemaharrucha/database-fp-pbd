-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 23, 2024 at 08:10 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fp_pbd_tokogrosir_fx`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_stock_kopibubuk_in_products` ()   BEGIN
    UPDATE products SET units_in_stock = units_in_stock + 20 WHERE product_name = 'Kopi Bubuk';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_stock_product` (`nama_product` VARCHAR(255), `unit_stock` INT)   BEGIN
    IF EXISTS (SELECT * FROM products WHERE product_name = nama_product) 
    THEN
        UPDATE products
        SET units_in_stock = units_in_stock + unit_stock
        WHERE product_name = nama_product;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `harga_product` (`p_name` VARCHAR(255), `c` VARCHAR(255)) RETURNS INT(11)  BEGIN
RETURN (SELECT unit_price FROM products WHERE product_name = p_name AND category = c);
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `total_pembayaran_order` () RETURNS INT(11)  BEGIN
RETURN (SELECT SUM(total_amount) FROM purchases);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `after_delete_products`
--

CREATE TABLE `after_delete_products` (
  `log_id` int(11) NOT NULL,
  `action` varchar(50) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `quantity_per_unit` varchar(255) DEFAULT NULL,
  `unit_price` decimal(10,0) DEFAULT NULL,
  `units_in_stock` int(11) DEFAULT NULL,
  `change_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `after_delete_products`
--

INSERT INTO `after_delete_products` (`log_id`, `action`, `product_name`, `category`, `quantity_per_unit`, `unit_price`, `units_in_stock`, `change_time`) VALUES
(2, 'AFTER DELETE', 'Saus Tomat', 'Bumbu Dapur', '340 gram', 8000, 110, '2024-07-23 06:05:54');

-- --------------------------------------------------------

--
-- Table structure for table `after_insert_customers`
--

CREATE TABLE `after_insert_customers` (
  `log_id` int(11) NOT NULL,
  `ACTION` varchar(255) DEFAULT NULL,
  `shop_name` varchar(255) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `after_insert_customers`
--

INSERT INTO `after_insert_customers` (`log_id`, `ACTION`, `shop_name`, `contact_name`, `address`, `city`, `postal_code`, `phone`) VALUES
(1, 'AFTER INSERT', 'Toko Ari', 'Radit Tukang Turu', 'Jl. Mangkunegara', 'Manggolang', '2525', '0853-4245-6586');

-- --------------------------------------------------------

--
-- Table structure for table `after_update_customers`
--

CREATE TABLE `after_update_customers` (
  `log_id` int(11) NOT NULL,
  `ACTION` varchar(255) DEFAULT NULL,
  `shop_name` varchar(255) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `after_update_customers`
--

INSERT INTO `after_update_customers` (`log_id`, `ACTION`, `shop_name`, `contact_name`, `address`, `city`, `postal_code`, `phone`) VALUES
(1, 'AFTER UPDATE', 'Toko Bijak', 'Andi', 'Jalan Melati', 'Sleman', '8686', '858 5674 2324');

-- --------------------------------------------------------

--
-- Table structure for table `before_delete_customers`
--

CREATE TABLE `before_delete_customers` (
  `log_id` int(11) NOT NULL,
  `action` varchar(50) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `change_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `before_delete_customers`
--

INSERT INTO `before_delete_customers` (`log_id`, `action`, `customer_id`, `contact_name`, `change_time`) VALUES
(1, 'BEFORE DELETE', 10, 'Andi Pratama', '2024-07-21 13:30:11'),
(2, 'BEFORE DELETE', 14, 'Radit Tukang Turu', '2024-07-21 13:54:37');

-- --------------------------------------------------------

--
-- Table structure for table `before_insert_log`
--

CREATE TABLE `before_insert_log` (
  `log_id` int(11) NOT NULL,
  `action` varchar(50) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `quantity_per_unit` varchar(255) DEFAULT NULL,
  `unit_price` decimal(10,0) DEFAULT NULL,
  `units_in_stock` int(11) DEFAULT NULL,
  `change_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `before_insert_log`
--

INSERT INTO `before_insert_log` (`log_id`, `action`, `product_name`, `category`, `quantity_per_unit`, `unit_price`, `units_in_stock`, `change_time`) VALUES
(2, 'BEFORE INSERT', 'Susu Dancow Sachet', 'Minuman', '500 gram', 5000, 90, '2024-07-21 12:57:53');

-- --------------------------------------------------------

--
-- Table structure for table `before_update_inventory_log`
--

CREATE TABLE `before_update_inventory_log` (
  `log_id` int(11) NOT NULL,
  `action` varchar(50) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `old_quantity` int(11) DEFAULT NULL,
  `new_quantity` int(11) DEFAULT NULL,
  `change_time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `before_update_inventory_log`
--

INSERT INTO `before_update_inventory_log` (`log_id`, `action`, `product_id`, `old_quantity`, `new_quantity`, `change_time`) VALUES
(1, 'BEFORE UPDATE', 1, 100, 150, '2024-07-21 13:12:09');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `shop_name` varchar(255) NOT NULL,
  `contact_name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `shop_name`, `contact_name`, `address`, `city`, `postal_code`, `phone`) VALUES
(1, 'Toko Maju Jaya', 'Budi Santoso', 'Jl. Merdeka No. 10', 'Jakarta', '10110', '081234567890'),
(2, 'Sentosa Mart', 'Dewi Lestari', 'Jl. Kemerdekaan No. 15', 'Bandung', '40123', '082345678901'),
(3, 'Sejahtera Store', 'Andi Wijaya', 'Jl. Pahlawan No. 5', 'Surabaya', '60234', '083456789012'),
(4, 'Berkah Minimarket', 'Siti Aminah', 'Jl. Proklamasi No. 20', 'Yogyakarta', '55212', '084567890123'),
(5, 'Toko Bijak', 'Andi', 'Jalan Melati', 'Sleman', '8686', '858 5674 2324'),
(6, 'Toko Grosir Makmur', 'Budi Santoso', 'Jl. Merdeka No. 45', 'Jakarta', '10110', '021-12345678'),
(7, 'Toko Grosir Sejahtera', 'Ani Wijaya', 'Jl. Sudirman No. 12', 'Bandung', '40111', '022-87654321'),
(8, 'Toko Radit', 'Rudi Hartono', 'Jl. Gatot Subroto No. 30', 'Surabaya', '60234', '031-11223344'),
(9, 'Toko Grosir Sentosa', 'Siti Nurhaliza', 'Jl. Diponegoro No. 5', 'Medan', '20123', '061-33445566');

--
-- Triggers `customers`
--
DELIMITER $$
CREATE TRIGGER `after_customers_insert` AFTER INSERT ON `customers` FOR EACH ROW BEGIN
    INSERT INTO after_insert_customers (action, shop_name, contact_name, address, city, postal_code, phone)
    VALUES ('AFTER INSERT', NEW.shop_name, NEW.contact_name, NEW.address, NEW.city, NEW.postal_code, NEW.phone);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_customers_delete` BEFORE DELETE ON `customers` FOR EACH ROW BEGIN
    INSERT INTO before_delete_customers (action, customer_id, contact_name)
    VALUES ('BEFORE DELETE', OLD.customer_id, OLD.contact_name);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_customers_insert` AFTER UPDATE ON `customers` FOR EACH ROW BEGIN
    INSERT INTO after_update_customers (action, shop_name, contact_name, address, city, postal_code, phone)
    VALUES ('AFTER UPDATE', NEW.shop_name, NEW.contact_name, NEW.address, NEW.city, NEW.postal_code, NEW.phone);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventory_id`, `product_id`, `quantity`, `last_update`) VALUES
(6, 1, 150, '2024-07-21 13:12:09'),
(7, 2, 200, '2024-07-07 01:34:05'),
(8, 3, 150, '2024-07-07 01:34:05'),
(9, 4, 50, '2024-07-07 01:34:05'),
(10, 5, 120, '2024-07-07 01:34:05'),
(11, 6, 50, '2024-07-19 22:21:33'),
(12, 7, 100, '2024-07-19 22:21:33'),
(13, 8, 75, '2024-07-19 22:21:33'),
(14, 9, 150, '2024-07-19 22:21:33'),
(15, 10, 60, '2024-07-19 22:21:33');

--
-- Triggers `inventory`
--
DELIMITER $$
CREATE TRIGGER `before_inventory_update` BEFORE UPDATE ON `inventory` FOR EACH ROW BEGIN
    INSERT INTO before_update_inventory_log (action, product_id, old_quantity, new_quantity)
    VALUES ('BEFORE UPDATE', OLD.product_id, OLD.quantity, NEW.quantity);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_date` date NOT NULL,
  `shipped_date` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `shipped_date`, `status`) VALUES
(1, 1, '2024-07-10', '2024-07-15', 1),
(2, 2, '2024-07-13', '2024-07-15', 1),
(3, 3, '2024-07-12', '2024-07-17', 1),
(4, 4, '2024-07-10', '2024-07-14', 1),
(5, 5, '2024-07-07', '2024-07-10', 1),
(6, 6, '2024-07-20', '2024-07-23', 1),
(7, 7, '2024-07-21', '2024-07-25', 1),
(8, 8, '2024-07-28', '2024-07-28', 1),
(9, 9, '2024-07-22', '2024-07-24', 1),
(10, 10, '2024-07-25', '2024-07-27', 1);

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_detail_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `unit_price` decimal(10,0) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`order_detail_id`, `order_id`, `product_id`, `unit_price`, `quantity`) VALUES
(1, 1, 1, 500000, 2),
(2, 2, 2, 75000, 5),
(3, 3, 3, 300000, 3),
(4, 4, 4, 80000, 1),
(5, 5, 5, 90000, 4),
(6, 6, 6, 12000, 10),
(7, 7, 7, 2500, 50),
(8, 8, 8, 17000, 5),
(9, 9, 9, 8000, 20),
(10, 10, 10, 18000, 8);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `quantity_per_unit` varchar(255) DEFAULT NULL,
  `unit_price` decimal(10,0) NOT NULL,
  `units_in_stock` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `category`, `quantity_per_unit`, `unit_price`, `units_in_stock`, `supplier_id`) VALUES
(1, 'Beras Premium', 'Bahan Pokok', '50 kg', 500000, 100, 1),
(2, 'Minyak Goreng', 'Bahan Pokok', '5 liter', 75000, 200, 2),
(3, 'Gula Pasir', 'Bahan Pokok', '25 kg', 300000, 150, 3),
(4, 'Kopi Bubuk', 'Minuman', '1 kg', 80000, 90, 4),
(5, 'Tepung Terigu', 'Bahan Pokok', '10 kg', 90000, 120, 5),
(6, 'Susu Kental Manis', 'Minuman', '397 gram', 12000, 90, 6),
(7, 'Mie Instan', 'Makanan Instan', '1 bungkus', 2500, 500, 7),
(8, 'Kecap Manis', 'Bumbu Dapur', '600 ml', 17000, 75, 8),
(10, 'Margarin', 'Bahan Roti', '200 gram', 18000, 105, 10),
(14, 'Susu Dancow Sachet', 'Minuman', '500 gram', 5000, 90, NULL);

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `after_products_delete` AFTER DELETE ON `products` FOR EACH ROW BEGIN
    INSERT INTO after_delete_products (action, product_name, category, quantity_per_unit, unit_price, units_in_stock)
    VALUES ('AFTER DELETE', OLD.product_name, OLD.category, OLD.quantity_per_unit, OLD.unit_price, OLD.units_in_stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_product` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
    IF NEW.unit_price <= 0 THEN
        SET NEW.unit_price = 5000;
    END IF;
    INSERT INTO before_insert_log (action, product_name, category, quantity_per_unit, unit_price, units_in_stock)
    VALUES ('BEFORE INSERT', NEW.product_name, NEW.category, NEW.quantity_per_unit, NEW.unit_price, NEW.units_in_stock);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_index`
--

CREATE TABLE `product_index` (
  `product_index_id` int(11) NOT NULL,
  `product_name_index` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_index`
--

INSERT INTO `product_index` (`product_index_id`, `product_name_index`) VALUES
(1, 'Beras Premium'),
(3, 'Gula Pasir'),
(5, 'Kopi Bubuk'),
(2, 'Minyak Goreng'),
(4, 'Tepung Terigu');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `purchases_id` int(11) NOT NULL,
  `order_detail_id` int(11) DEFAULT NULL,
  `purchases_date` date DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`purchases_id`, `order_detail_id`, `purchases_date`, `total_amount`) VALUES
(1, 1, '2024-07-15', 1000000.00),
(2, 2, '2024-07-15', 375000.00),
(3, 3, '2024-07-17', 900000.00),
(4, 4, '2024-07-14', 80000.00),
(5, 5, '2024-07-10', 360000.00),
(6, 6, '2024-07-01', 120000.00),
(7, 7, '2024-07-02', 125000.00),
(8, 8, '2024-07-03', 85000.00),
(9, 9, '2024-07-04', 160000.00),
(10, 10, '2024-07-05', 144000.00);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `contact_name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `company_name`, `contact_name`, `address`, `city`, `postal_code`, `phone`) VALUES
(1, 'PT Sumber Makmur', 'Rina Wijaya', 'Jl. Raya No. 50', 'Jakarta', '10120', '081234567891'),
(2, 'CV Berkah Abadi', 'Hadi Santoso', 'Jl. Sudirman No. 30', 'Bandung', '40130', '082345678902'),
(3, 'UD Jaya Sentosa', 'Siti Nurhaliza', 'Jl. Gatot Subroto No. 45', 'Surabaya', '60240', '083456789023'),
(4, 'PT Amanah Sejahtera', 'Ridwan Kamil', 'Jl. Diponegoro No. 60', 'Yogyakarta', '55230', '084567890234'),
(5, 'CV Tunas Harapan', 'Agus Susanto', 'Jl. Imam Bonjol No. 70', 'Medan', '20130', '085678901345'),
(6, 'PT Sumber Jaya', 'Hendra Gunawan', 'Jl. Pahlawan No. 10', 'Jakarta', '10120', '021-33445566'),
(7, 'CV Karya Utama', 'Lisa Mulyani', 'Jl. Kenanga No. 15', 'Bandung', '40122', '022-99887766'),
(8, 'UD Makmur Sentosa', 'Asep Riyadi', 'Jl. Melati No. 18', 'Surabaya', '60244', '031-66778899'),
(9, 'PT Tunas Baru', 'Bambang Suharto', 'Jl. Srikandi No. 25', 'Medan', '20145', '061-77889900'),
(10, 'CV Maju Jaya', 'Tina Marlina', 'Jl. Anggrek No. 30', 'Yogyakarta', '55232', '0274-44332211'),
(11, 'PT Melati', 'Hendra Gunawan', 'Jl. Pahlawan No. 10', 'Jakarta', '10120', NULL),
(12, 'PT Jaya Esport', 'Lisa Mulyani', 'Jl. Kenanga No. 15', 'Bandung', '40122', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_suppliers`
-- (See below for the actual view)
--
CREATE TABLE `v_suppliers` (
`supplier_id` int(11)
,`company_name` varchar(255)
,`contact_name` varchar(255)
,`address` varchar(255)
,`city` varchar(255)
,`postal_code` varchar(255)
,`phone` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_supplier_limit`
-- (See below for the actual view)
--
CREATE TABLE `v_supplier_limit` (
`company_name` varchar(255)
,`contact_name` varchar(255)
,`address` varchar(255)
,`phone` varchar(255)
);

-- --------------------------------------------------------

--
-- Structure for view `v_suppliers`
--
DROP TABLE IF EXISTS `v_suppliers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_suppliers`  AS SELECT `suppliers`.`supplier_id` AS `supplier_id`, `suppliers`.`company_name` AS `company_name`, `suppliers`.`contact_name` AS `contact_name`, `suppliers`.`address` AS `address`, `suppliers`.`city` AS `city`, `suppliers`.`postal_code` AS `postal_code`, `suppliers`.`phone` AS `phone` FROM `suppliers` WHERE `suppliers`.`supplier_id` in (1,2,3) ;

-- --------------------------------------------------------

--
-- Structure for view `v_supplier_limit`
--
DROP TABLE IF EXISTS `v_supplier_limit`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_supplier_limit`  AS SELECT `suppliers`.`company_name` AS `company_name`, `suppliers`.`contact_name` AS `contact_name`, `suppliers`.`address` AS `address`, `suppliers`.`phone` AS `phone` FROM `suppliers` WHERE `suppliers`.`supplier_id` in (4,5,6) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `after_delete_products`
--
ALTER TABLE `after_delete_products`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `after_insert_customers`
--
ALTER TABLE `after_insert_customers`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `after_update_customers`
--
ALTER TABLE `after_update_customers`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `before_delete_customers`
--
ALTER TABLE `before_delete_customers`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `before_insert_log`
--
ALTER TABLE `before_insert_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `before_update_inventory_log`
--
ALTER TABLE `before_update_inventory_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_detail_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `index_order` (`order_detail_id`,`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `supplier_id` (`supplier_id`),
  ADD KEY `index_products_name` (`product_name`,`product_id`);

--
-- Indexes for table `product_index`
--
ALTER TABLE `product_index`
  ADD PRIMARY KEY (`product_index_id`),
  ADD KEY `index_product_name` (`product_name_index`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`purchases_id`),
  ADD KEY `order_detail_id` (`order_detail_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `after_delete_products`
--
ALTER TABLE `after_delete_products`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `after_insert_customers`
--
ALTER TABLE `after_insert_customers`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `after_update_customers`
--
ALTER TABLE `after_update_customers`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `before_delete_customers`
--
ALTER TABLE `before_delete_customers`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `before_insert_log`
--
ALTER TABLE `before_insert_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `before_update_inventory_log`
--
ALTER TABLE `before_update_inventory_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `order_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `product_index`
--
ALTER TABLE `product_index`
  MODIFY `product_index_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `purchases_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
