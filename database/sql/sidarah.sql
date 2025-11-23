-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 23, 2025 at 12:55 PM
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
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-0021079e1dee5a35ab211d1dde082a66', 'i:1;', 1763897885),
('laravel-cache-0021079e1dee5a35ab211d1dde082a66:timer', 'i:1763897885;', 1763897885),
('laravel-cache-a75f3f172bfb296f2e10cbfc6dfc1883', 'i:1;', 1763898200),
('laravel-cache-a75f3f172bfb296f2e10cbfc6dfc1883:timer', 'i:1763898200;', 1763898200),
('laravel-cache-a9f3049f1c20173919936bff7fbfe200', 'i:1;', 1763898745),
('laravel-cache-a9f3049f1c20173919936bff7fbfe200:timer', 'i:1763898745;', 1763898745),
('laravel-cache-f1f70ec40aaa556905d4a030501c0ba4', 'i:2;', 1763898924),
('laravel-cache-f1f70ec40aaa556905d4a030501c0ba4:timer', 'i:1763898924;', 1763898924);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_11_23_021801_create_personal_access_tokens_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(5, 'App\\Models\\User', 3, 'api_token', '1e64b5c9077fe8367f58914d317c5195d8176a5704b85f53baaa8005d0768c25', '[\"*\"]', NULL, NULL, '2025-11-22 23:01:38', '2025-11-22 23:01:38'),
(6, 'App\\Models\\User', 4, 'api_token', '1041bc0b3ecd773ae045d4d1f551a4d903b26a42ed082a7de0b6a2dc5c8b5378', '[\"*\"]', NULL, NULL, '2025-11-22 23:06:28', '2025-11-22 23:06:28'),
(15, 'App\\Models\\User', 5, 'api_token', 'aa313504e169026af91bae4e2cf7f75b65ddf1d6de72f302e513becf8d510890', '[\"*\"]', NULL, NULL, '2025-11-23 00:39:27', '2025-11-23 00:39:27'),
(19, 'App\\Models\\User', 7, 'api_token', '34913e2bae42a95b206c8bb4e480886a2d42850ed643b090243e3be3e6db77da', '[\"*\"]', NULL, NULL, '2025-11-23 00:42:03', '2025-11-23 00:42:03'),
(20, 'App\\Models\\User', 8, 'api_token', '0ca3c880120742cec55985394843e6480ea0f70c1af11fb9fe60c47aa4607e29', '[\"*\"]', NULL, NULL, '2025-11-23 00:43:17', '2025-11-23 00:43:17'),
(25, 'App\\Models\\User', 2, 'api_token', '27c04181fa068aeb330b5ca60d42bb0986de62afac23bad262214859b523048b', '[\"*\"]', NULL, NULL, '2025-11-23 04:18:02', '2025-11-23 04:18:02'),
(27, 'App\\Models\\User', 9, 'api_token', 'b304d6f9f42c0c124e36278fe0b01a86175897ecd62a6ef2515b6768a53c7276', '[\"*\"]', NULL, NULL, '2025-11-23 04:23:14', '2025-11-23 04:23:14'),
(30, 'App\\Models\\User', 1, 'api_token', '027df10391aa43c5305a7c1fca95f420595a758aae31a4b9152b28e4118d2596', '[\"*\"]', '2025-11-23 04:54:42', NULL, '2025-11-23 04:42:21', '2025-11-23 04:54:42'),
(31, 'App\\Models\\User', 6, 'api_token', '87774adb6b56b9b7fc37cfca611c00d93a3d3695ba3c83fd49c7f812748fe372', '[\"*\"]', NULL, NULL, '2025-11-23 04:51:25', '2025-11-23 04:51:25');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('1L1Lu2rTXIPiiqQQqiE86QheUWtb3q12CVst1aFu', 5, '192.168.0.180', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoickxOZXVZT0VMbWJxeURmSVRGWngzQUZlSWFOMnRzQXdQYWlDak1sNCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMC9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6NTt9', 1763883629),
('1QexBDZ4euiOPfEYLEpHM0cTlwIj71ibpKIwHDmN', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidjBqaFRybUxHSnZhSjliWXRrNHlibUszSVpoMnhpbVlDbWlpVU1nYiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1763863051),
('2WgWz9x6LuFWYoMBaYcAaKkaRRdVKrNsZxJrgqeI', NULL, '192.168.0.180', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaVd4b0tIQ1VaWHJjMHlzeHVsZ0pOcklMUUE5dHdKMEFUMWs4dERwbyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMC9yZWdpc3RlciI7czo1OiJyb3V0ZSI7czo4OiJyZWdpc3RlciI7fX0=', 1763872041),
('4uJKBqVbB4RMERxW3tZxVmCCf4lgA0j7OSgjSuv1', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicGx0N0loTTZ2QnlYTEpVekd5U2NIVG1wQ1ZjNFZIcVhlNUF1S3V3VyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjk6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9wcm9maWxlIjtzOjU6InJvdXRlIjtzOjEyOiJwcm9maWxlLmVkaXQiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1763828082),
('bvU3pfwU5wllvxAW0gS73xTRXZWQQyGWTWubD7c3', NULL, '192.168.0.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaTNsYWxpN2RUMmdmZ2ZRMDcwVjkxSEw1Q0xHQ3FaWUZrY0JrS09HSSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763875388),
('dmYSYnEPjRn9pfiA6Ix06Cai7qLR5FnLWIDdLd1a', NULL, '192.168.0.230', 'okhttp/3.14.9', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSVprRXlScmN3VG9qem5CR3dxNlEzcEY3Q3Y0M2JGbFo0bW9oMnVWYSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763875801),
('fPEVMpkB7bqIcZRBGHHPo6W7Xvn464O7OJ9RqIHX', NULL, '192.168.0.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36 Edg/142.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVldtRW9DNVdtdWJic0hkYzdSeURqbGs0Mlc0dE5OYmdMUXlwYzFmUiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763884401),
('h6bQ74NWFXe6fBuvlhfDuMUF12ntxHqB5KmbE9RK', NULL, '192.168.0.230', 'okhttp/3.14.9', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVkVjSTNlUTJGVnNnaGF6MU1VUE1QYngwTzdmZG94OUtGNFZEM0F6SSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763875804),
('iY3EMl6iDyoFwaMk22f6T2lHx3wkx0CS9fcibera', NULL, '192.168.0.230', 'okhttp/3.14.9', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY2dzNnB1d29LS2dVUDhXeDVPMlVNdVNvdzc3Q1lEbnpWVHVMMUY3byI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763875603),
('IzZErPMuZioNXpKYASqYSVagvCO4OUM2d4IlJ4cD', NULL, '192.168.0.230', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMGdmbVFnNktCYktIRHU2TkRXUXRwSXBVcnp6WVVoTTVOcDFCb0xqeiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763875464),
('NRXMXdm3KZmBK2Q2HM3ckYhB77gimMWbeSasSrME', NULL, '192.168.0.230', 'okhttp/3.14.9', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib0FZYkcxVnZWYVVKTFlCeFNKWkhwdVM2M0VkUkRFU05qNGs4aFg5TiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763875804),
('RVrejbH2YIJ38NlodJ213yncZBFmiqT63svUlcJB', NULL, '192.168.0.121', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTnNtaTl6QWJmOVNsODBEWFJlZ3FNYUx6NWhjNmJKUGtKVk9YOFpGUyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763865190),
('t9BBwJ6EV50EBBmOQjj31E4B2KU9kFRcwUXDLcGV', NULL, '192.168.0.230', 'okhttp/3.14.9', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNmhpTXR6TXJwbkYwMEc5NVc5MXdpQ2ltSHRNcWh6WjBpZmtNUUswdiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763875590),
('TlL5lY7CPon3te25MESzadOEjRkQoJbVgiFQhLob', NULL, '127.0.0.1', 'PostmanRuntime/7.49.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNVRXWFVjcmQwcmhnUGdzNWFXd2VDRmhtaUliYlZkS25WOWVKSU9ZQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1763898519),
('UMexQmyz8PY39YedV373H3FYC1CB5rc3wHeJwXSv', NULL, '192.168.0.230', 'okhttp/3.14.9', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZm50Q2pwZDlpN0dFbEZNcWxLenU1a0RWblhvZExZRTFwSGw2ejZTbyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763875687),
('UNz1cn8XW3h2Z8aNhg1EgmM3Y7RbfvXlTByjB4Pf', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNnJaYU85Ymg5cTJnUEZwckR5MU15YWtERlRyUktnOHRRYWE0QUFyViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763896834),
('uZ5FoMxpDnYsS63CRUhibxDnvl4QIT47gfJ7AzJ6', NULL, '192.168.0.230', 'okhttp/3.14.9', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRHRkOVZxYjB1dW1sY0lIZTBDMU5Tbm1aYUVvWWRKM1I0UmxIM2l2aSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763875805),
('vIQWtLT8uZQnjqohmtEEtRtiEhhokzTrHTDfiixI', NULL, '192.168.0.230', 'okhttp/3.14.9', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoib1RCNk1CTld3UnNSZWYzZ0hPMXM3amx3aUtmWkVPbXpnRUhxWmR6ciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763875635),
('vrRAhIg8c6AC7Bsk7rMyEjHQyVXVEIoortqdWS0j', NULL, '127.0.0.1', 'PostmanRuntime/7.49.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYzEzRmgzWTNlbDJ1VjU1SVVLaEJPblMyb3lySjJxTnhmcTl2ZGhmaCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1763878608),
('YeSiGuPJN7IfE2cCivtthQgNKPXugiTiQpM9GBUy', NULL, '192.168.0.230', 'okhttp/3.14.9', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidVNJNGNMNWdjaGZ1b3F4ZVo2NjBWN1F6ZnVUdmJRZHltOXZyenJrTiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763875804),
('YlLuwXt9f5aOdscvZH2Poq19XwBSHqUrMwejrQGR', NULL, '192.168.0.230', 'okhttp/3.14.9', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQjBmM1djcmUwZUQ1ZzJoWmh5Nkc5THNic3RZblJqdEVBaTRYd0VONSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjQ6Imh0dHA6Ly8xOTIuMTY4LjAuMzI6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1763875804),
('yrpDUcc6l8NjYiVKMSOf0i6uc0AzW4MhWBsIQ1sr', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoic2RVejk5THBER1lwRTVrNjVpWUlUdUxWQmliWUFKR2ZiaU9lU2U1SCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9kYXNoYm9hcmQiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9', 1763875860);

-- --------------------------------------------------------

--
-- Table structure for table `stok_darah`
--

CREATE TABLE `stok_darah` (
  `id` int(11) NOT NULL,
  `golongan_darah` varchar(50) NOT NULL,
  `jumlah` int(10) NOT NULL,
  `tanggal` date NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stok_darah`
--

INSERT INTO `stok_darah` (`id`, `golongan_darah`, `jumlah`, `tanggal`, `created_at`, `updated_at`) VALUES
(1, 'A+', 50, '2025-11-23', '2025-11-23 11:45:25', '2025-11-23 11:45:25'),
(3, 'O+', 50, '2025-11-23', '2025-11-23 11:54:24', '2025-11-23 11:54:24');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Aji Putra Prayogi', 'ajiputraprayogi@gmail.com', NULL, '$2y$12$lN0D1UTp/PQ749A/uT/Gy.69dQE8z1E/BBIeNdSP.pe.SXcVYH7yK', NULL, '2025-11-22 09:08:10', '2025-11-22 09:08:10'),
(2, 'Rizky Andi Putra', 'r@gmail.com', NULL, '$2y$12$c0uMMJR9d2tK45SR3vN8kutEoCpjcnJW/2YJihvbKZ2FCyxkCsjnu', NULL, '2025-11-22 22:30:59', '2025-11-22 22:30:59'),
(3, 'Api User', 'api@email.com', NULL, '$2y$12$T4DG5QoF3gZlQ87MS6ZAUueu.88Pghuq9U3O4jLzp9MNI/NyDePGi', NULL, '2025-11-22 23:01:37', '2025-11-22 23:01:37'),
(4, 'Api User', 'apis@email.com', NULL, '$2y$12$MRMcWaK5KXVQMVLRgxXGbOAJmN7pQ7ySffh1MQADNk/SQgycXeI0W', NULL, '2025-11-22 23:06:28', '2025-11-22 23:06:28'),
(5, 'bagas', 'bagas@gmail.com', NULL, '$2y$12$UzupU0W7KsmW2KwkUQZ/PuzFBy6jC7HNSB1C//oBCpnto4zrm6uii', NULL, '2025-11-23 00:39:27', '2025-11-23 00:39:27'),
(6, 'bagas', 'bagas2@gmail.com', NULL, '$2y$12$DKXD.c.tdDg.TcptGRdsTutMutAFCgWYThujl/t8H41E37wHI0g8e', NULL, '2025-11-23 00:40:51', '2025-11-23 00:40:51'),
(7, 'chilmi', 'chilmi@gmail.com', NULL, '$2y$12$xXEpJrLc3Cro3j6nRrC5vOk11.UjGm9Z7IYGH1rDQmDRkxFlHysom', NULL, '2025-11-23 00:41:47', '2025-11-23 00:41:47'),
(8, 'aji', 'aji2@gmail.com', NULL, '$2y$12$QxxIXjG7LfiEdo0BM.9MJeUEGcN1rPcYOd72LnObbYWZbj0Ql7VlC', NULL, '2025-11-23 00:43:17', '2025-11-23 00:43:17'),
(9, 'iky', 'iky@gmail.com', NULL, '$2y$12$4wyU5xpKtLDbysUFS802xOssuUVzmwiNvNEYLybMFeMFg89PemwZm', NULL, '2025-11-23 04:22:31', '2025-11-23 04:22:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `stok_darah`
--
ALTER TABLE `stok_darah`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `stok_darah`
--
ALTER TABLE `stok_darah`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
