-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 18, 2026 at 10:17 PM
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
-- Database: `klinik_binasehat`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `datalaporan`
-- (See below for the actual view)
--
CREATE TABLE `datalaporan` (
`id_rekam` int(11)
,`tanggal` date
,`nama_pasien` varchar(100)
,`nama_dokter` varchar(100)
,`diagnosa` text
);

-- --------------------------------------------------------

--
-- Table structure for table `detail_pembayaran`
--

CREATE TABLE `detail_pembayaran` (
  `id_detail` int(11) NOT NULL,
  `id_pembayaran` int(11) DEFAULT NULL,
  `id_obat` int(11) DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `subtotal` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_pembayaran`
--

INSERT INTO `detail_pembayaran` (`id_detail`, `id_pembayaran`, `id_obat`, `jumlah`, `subtotal`) VALUES
(1, 1, 1, 10, 20000.00),
(2, 1, 3, 25, 50000.00),
(3, 2, 2, 10, 50000.00),
(4, 2, 4, 15, 75000.00),
(5, 3, 5, 4, 24000.00),
(6, 4, 4, 10, 25000.00),
(7, 4, 1, 5, 30000.00),
(8, 5, 3, 20, 30000.00),
(9, 5, 4, 10, 25000.00);

--
-- Triggers `detail_pembayaran`
--
DELIMITER $$
CREATE TRIGGER `UPD_TOTAL_PEMBAYARAN` AFTER INSERT ON `detail_pembayaran` FOR EACH ROW BEGIN
    UPDATE Pembayaran
    SET total_biaya = total_biaya + NEW.subtotal
    WHERE id_pembayaran = NEW.id_pembayaran;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_rawat_inap`
--

CREATE TABLE `detail_rawat_inap` (
  `id_detail_rawat` int(11) NOT NULL,
  `id_rawat` int(11) DEFAULT NULL,
  `id_dokter` int(11) DEFAULT NULL,
  `id_perawat` int(11) DEFAULT NULL,
  `tgl_mulai` date DEFAULT NULL,
  `tgl_selesai` date DEFAULT NULL,
  `catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_rawat_inap`
--

INSERT INTO `detail_rawat_inap` (`id_detail_rawat`, `id_rawat`, `id_dokter`, `id_perawat`, `tgl_mulai`, `tgl_selesai`, `catatan`) VALUES
(1, 1, 1, 1, '2025-12-01', '2025-12-03', 'Pasien stabil, demam turun setelah obat.'),
(2, 2, 2, 2, '2025-12-02', '2025-12-06', 'Batuk berkurang, kondisi membaik.'),
(3, 3, 3, 3, '2025-12-03', NULL, 'Perawatan gusi sedang berjalan.'),
(4, 4, 4, 4, '2025-12-04', NULL, 'Ruam perlahan memudar.'),
(5, 5, 5, 5, '2025-12-05', '2025-12-07', 'Pasien membaik, diperbolehkan pulang.');

-- --------------------------------------------------------

--
-- Table structure for table `dokter`
--

CREATE TABLE `dokter` (
  `id_dokter` int(11) NOT NULL,
  `nama_dokter` varchar(100) DEFAULT NULL,
  `spesialisasi` varchar(100) DEFAULT NULL,
  `no_telp` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dokter`
--

INSERT INTO `dokter` (`id_dokter`, `nama_dokter`, `spesialisasi`, `no_telp`) VALUES
(1, 'Shirakaami Fubuki', 'Dokter Umum', '082123456789'),
(2, 'Hutaoo', 'Dokter Bedah', '082234567890'),
(3, 'Exusiai', 'Dokter Anak', '082345678901'),
(4, 'Lucia', 'Dokter Gigi', '082456789012'),
(5, 'Evlyn', 'Dokter Kulit', '082567890123');

-- --------------------------------------------------------

--
-- Table structure for table `log_perubahan_pasien`
--

CREATE TABLE `log_perubahan_pasien` (
  `id_log` int(11) NOT NULL,
  `id_pasien` int(11) DEFAULT NULL,
  `nama_lama` varchar(100) DEFAULT NULL,
  `nama_baru` varchar(100) DEFAULT NULL,
  `alamat_lama` varchar(255) DEFAULT NULL,
  `alamat_baru` varchar(255) DEFAULT NULL,
  `telp_lama` varchar(20) DEFAULT NULL,
  `telp_baru` varchar(20) DEFAULT NULL,
  `waktu_perubahan` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_perubahan_pasien`
--

INSERT INTO `log_perubahan_pasien` (`id_log`, `id_pasien`, `nama_lama`, `nama_baru`, `alamat_lama`, `alamat_baru`, `telp_lama`, `telp_baru`, `waktu_perubahan`) VALUES
(1, 3, 'Ellen Joe', 'Ellen Joe', 'Jl. Kutilang No. 3, Surabaya', 'Jl. Kutilang No. 3, Surabaya', '081456789012', '085965911133', '2025-12-08 04:56:33'),
(2, 5, 'Saba Sameeko', 'Saba Sameko', 'Jl. Elang No. 5, Yogyakarta', 'Jl. Elang No. 5, Yogyakarta', '081678901234', '081678901234', '2026-01-18 11:36:09');

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `id_obat` int(11) NOT NULL,
  `nama_obat` varchar(100) DEFAULT NULL,
  `jenis` varchar(50) DEFAULT NULL,
  `harga_satuan` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`id_obat`, `nama_obat`, `jenis`, `harga_satuan`) VALUES
(1, 'Paracetamol', 'Analgesik', 2000.00),
(2, 'Amoxicillin', 'Antibiotik', 5000.00),
(3, 'Vitamin C', 'Vitamin', 1500.00),
(4, 'Obat Flu', 'Dekongestan', 2500.00),
(5, 'Salep Luka', 'Topikal', 3000.00);

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `id_pasien` int(11) NOT NULL,
  `nama_pasien` varchar(100) DEFAULT NULL,
  `nik` varchar(20) DEFAULT NULL,
  `jenis_kelamin` enum('L','P') DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `no_telp` varchar(15) DEFAULT NULL,
  `gol_darah` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pasien`
--

INSERT INTO `pasien` (`id_pasien`, `nama_pasien`, `nik`, `jenis_kelamin`, `alamat`, `no_telp`, `gol_darah`) VALUES
(1, 'Ourin', '1234567890123456', 'L', 'Jl. Merpati No. 1, Jakarta', '081234567890', 'A'),
(2, 'Aiko', '2345678901234567', 'P', 'Jl. Kenari No. 2, Bandung', '081345678901', 'B'),
(3, 'Ellen Joe', '3456789012345678', 'P', 'Jl. Kutilang No. 3, Surabaya', '085965911133', 'O'),
(4, 'Gawr Gura', '4567890123456789', 'P', 'Jl. Rajawali No. 4, Semarang', '081567890123', 'AB'),
(5, 'Saba Sameko', '5678901234567890', 'P', 'Jl. Elang No. 5, Yogyakarta', '081678901234', 'A');

--
-- Triggers `pasien`
--
DELIMITER $$
CREATE TRIGGER `log_update_pasien` AFTER UPDATE ON `pasien` FOR EACH ROW BEGIN
    INSERT INTO log_perubahan_pasien 
    (id_pasien, nama_lama, nama_baru, alamat_lama, alamat_baru, telp_lama, telp_baru, waktu_perubahan)
    VALUES
    (OLD.id_pasien, OLD.nama_pasien, NEW.nama_pasien, OLD.alamat, NEW.alamat, OLD.no_telp, NEW.no_telp, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(11) NOT NULL,
  `id_pasien` int(11) DEFAULT NULL,
  `id_rekam` int(11) DEFAULT NULL,
  `total_biaya` decimal(12,2) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_pasien`, `id_rekam`, `total_biaya`, `status`) VALUES
(1, 1, 1, 70000.00, 'Lunas'),
(2, 2, 2, 125000.00, 'Lunas'),
(3, 3, 3, 24000.00, 'Lunas'),
(4, 4, 4, 55000.00, 'Belum Lunas'),
(5, 5, 5, 55000.00, 'Lunas');

-- --------------------------------------------------------

--
-- Table structure for table `perawat`
--

CREATE TABLE `perawat` (
  `id_perawat` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `no_telp` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `perawat`
--

INSERT INTO `perawat` (`id_perawat`, `nama`, `no_telp`) VALUES
(1, 'Furina', '083123456789'),
(2, 'Keqing', '083234567890'),
(3, 'Ourin', '083345678901'),
(4, 'Aiko', '083456789012'),
(5, 'Ellen Joe', '083567890123');

-- --------------------------------------------------------

--
-- Table structure for table `rawat_inap`
--

CREATE TABLE `rawat_inap` (
  `id_rawat_inap` int(11) NOT NULL,
  `kamar` varchar(10) DEFAULT NULL,
  `kelas` varchar(20) DEFAULT NULL,
  `tanggal_masuk` date DEFAULT NULL,
  `tanggal_keluar` date DEFAULT NULL,
  `status_rawat` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rawat_inap`
--

INSERT INTO `rawat_inap` (`id_rawat_inap`, `kamar`, `kelas`, `tanggal_masuk`, `tanggal_keluar`, `status_rawat`) VALUES
(1, 'A101', 'VIP', '2025-12-01', '2025-12-03', 'Selesai'),
(2, 'B202', 'Kelas 1', '2025-12-02', '2025-12-06', 'Selesai'),
(3, 'C303', 'Kelas 2', '2025-12-03', NULL, 'Masih Dirawat'),
(4, 'D404', 'VIP', '2025-12-04', NULL, 'Masih Dirawat'),
(5, 'E505', 'Kelas 3', '2025-12-05', '2025-12-07', 'Selesai');

-- --------------------------------------------------------

--
-- Table structure for table `rekam_medis`
--

CREATE TABLE `rekam_medis` (
  `id_rekam` int(11) NOT NULL,
  `id_pasien` int(11) DEFAULT NULL,
  `id_dokter` int(11) DEFAULT NULL,
  `keluhan` text DEFAULT NULL,
  `diagnosa` text DEFAULT NULL,
  `tindakan` text DEFAULT NULL,
  `tanggal` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rekam_medis`
--

INSERT INTO `rekam_medis` (`id_rekam`, `id_pasien`, `id_dokter`, `keluhan`, `diagnosa`, `tindakan`, `tanggal`) VALUES
(1, 1, 1, 'Sakit kepala dan demam', 'Flu biasa', 'Pemberian Paracetamol', '2025-12-01'),
(2, 2, 2, 'Batuk dan pilek', 'Infeksi saluran pernapasan', 'Amoxicillin 500mg 3x sehari', '2025-12-02'),
(3, 3, 3, 'Gusi berdarah', 'Radang gusi', 'Pembersihan gigi + Salep Luka', '2025-12-03'),
(4, 4, 4, 'Ruam di kulit', 'Dermatitis', 'Salep Luka dioles 2x sehari', '2025-12-04'),
(5, 5, 5, 'Demam tinggi', 'Infeksi virus', 'Istirahat + Vitamin C', '2025-12-05');

-- --------------------------------------------------------

--
-- Structure for view `datalaporan`
--
DROP TABLE IF EXISTS `datalaporan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `datalaporan`  AS SELECT `rm`.`id_rekam` AS `id_rekam`, `rm`.`tanggal` AS `tanggal`, `p`.`nama_pasien` AS `nama_pasien`, `d`.`nama_dokter` AS `nama_dokter`, `rm`.`diagnosa` AS `diagnosa` FROM ((`rekam_medis` `rm` join `pasien` `p` on(`rm`.`id_pasien` = `p`.`id_pasien`)) join `dokter` `d` on(`rm`.`id_dokter` = `d`.`id_dokter`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_pembayaran`
--
ALTER TABLE `detail_pembayaran`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_pembayaran` (`id_pembayaran`),
  ADD KEY `id_obat` (`id_obat`);

--
-- Indexes for table `detail_rawat_inap`
--
ALTER TABLE `detail_rawat_inap`
  ADD PRIMARY KEY (`id_detail_rawat`),
  ADD KEY `id_rawat` (`id_rawat`),
  ADD KEY `id_dokter` (`id_dokter`),
  ADD KEY `id_perawat` (`id_perawat`);

--
-- Indexes for table `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id_dokter`);

--
-- Indexes for table `log_perubahan_pasien`
--
ALTER TABLE `log_perubahan_pasien`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id_obat`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id_pasien`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `id_pasien` (`id_pasien`),
  ADD KEY `id_rekam` (`id_rekam`);

--
-- Indexes for table `perawat`
--
ALTER TABLE `perawat`
  ADD PRIMARY KEY (`id_perawat`);

--
-- Indexes for table `rawat_inap`
--
ALTER TABLE `rawat_inap`
  ADD PRIMARY KEY (`id_rawat_inap`);

--
-- Indexes for table `rekam_medis`
--
ALTER TABLE `rekam_medis`
  ADD PRIMARY KEY (`id_rekam`),
  ADD KEY `id_pasien` (`id_pasien`),
  ADD KEY `id_dokter` (`id_dokter`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_pembayaran`
--
ALTER TABLE `detail_pembayaran`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `detail_rawat_inap`
--
ALTER TABLE `detail_rawat_inap`
  MODIFY `id_detail_rawat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id_dokter` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `log_perubahan_pasien`
--
ALTER TABLE `log_perubahan_pasien`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `id_obat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id_pasien` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `perawat`
--
ALTER TABLE `perawat`
  MODIFY `id_perawat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `rawat_inap`
--
ALTER TABLE `rawat_inap`
  MODIFY `id_rawat_inap` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `rekam_medis`
--
ALTER TABLE `rekam_medis`
  MODIFY `id_rekam` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_pembayaran`
--
ALTER TABLE `detail_pembayaran`
  ADD CONSTRAINT `detail_pembayaran_ibfk_1` FOREIGN KEY (`id_pembayaran`) REFERENCES `pembayaran` (`id_pembayaran`),
  ADD CONSTRAINT `detail_pembayaran_ibfk_2` FOREIGN KEY (`id_obat`) REFERENCES `obat` (`id_obat`);

--
-- Constraints for table `detail_rawat_inap`
--
ALTER TABLE `detail_rawat_inap`
  ADD CONSTRAINT `detail_rawat_inap_ibfk_1` FOREIGN KEY (`id_rawat`) REFERENCES `rawat_inap` (`id_rawat_inap`),
  ADD CONSTRAINT `detail_rawat_inap_ibfk_2` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`),
  ADD CONSTRAINT `detail_rawat_inap_ibfk_3` FOREIGN KEY (`id_perawat`) REFERENCES `perawat` (`id_perawat`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`),
  ADD CONSTRAINT `pembayaran_ibfk_2` FOREIGN KEY (`id_rekam`) REFERENCES `rekam_medis` (`id_rekam`);

--
-- Constraints for table `rekam_medis`
--
ALTER TABLE `rekam_medis`
  ADD CONSTRAINT `rekam_medis_ibfk_1` FOREIGN KEY (`id_pasien`) REFERENCES `pasien` (`id_pasien`),
  ADD CONSTRAINT `rekam_medis_ibfk_2` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
