-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 26, 2025 at 02:51 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sidarah`
--

-- --------------------------------------------------------

--
-- Table structure for table `pengeluaran_darah`
--

CREATE TABLE `pengeluaran_darah` (
  `id` int(11) NOT NULL,
  `stok_id` int(11) DEFAULT NULL,
  `golongan_darah` varchar(5) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tanggal_pengeluaran` date NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengeluaran_darah`
--

INSERT INTO `pengeluaran_darah` (`id`, `stok_id`, `golongan_darah`, `jumlah`, `tanggal_pengeluaran`, `created_at`, `updated_at`) VALUES
(4, NULL, 'A', 5, '2025-11-26', '2025-11-26 04:06:21', '2025-11-26 04:06:21'),
(5, NULL, 'A', 1, '2025-11-26', '2025-11-26 04:17:04', '2025-11-26 04:17:04'),
(7, NULL, 'B', 3, '2025-11-26', '2025-11-26 04:28:26', '2025-11-26 04:28:26'),
(8, NULL, 'A', 2, '2025-11-26', '2025-11-26 06:02:33', '2025-11-26 06:02:33');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pengeluaran_darah`
--
ALTER TABLE `pengeluaran_darah`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pengeluaran_stok` (`stok_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pengeluaran_darah`
--
ALTER TABLE `pengeluaran_darah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pengeluaran_darah`
--
ALTER TABLE `pengeluaran_darah`
  ADD CONSTRAINT `fk_pengeluaran_stok` FOREIGN KEY (`stok_id`) REFERENCES `stok_darah` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
