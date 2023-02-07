-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 26 Okt 2022 pada 11.48
-- Versi server: 10.4.19-MariaDB
-- Versi PHP: 8.0.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `web_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `clusterbangunan`
--

CREATE TABLE `clusterbangunan` (
  `id_bangunan` int(11) NOT NULL,
  `kode_aset` text NOT NULL,
  `nama` varchar(256) NOT NULL,
  `hasil` text NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `clusterbangunan`
--

INSERT INTO `clusterbangunan` (`id_bangunan`, `kode_aset`, `nama`, `hasil`, `keterangan`) VALUES
(1, '01.02.04.02.001', 'Masjid', 'Produktif', 'Telah Dimanfaatkan'),
(2, '01.02.04.02.001', 'Masjid', 'Produktif', 'Telah Dimanfaatkan'),
(3, '01.02.04.02.001', 'Masjid', 'Produktif', 'Telah Dimanfaatkan'),
(4, '01.02.04.02.001', 'Masjid', 'Produktif', 'Telah Dimanfaatkan'),
(5, '01.02.04.02.001', 'Masjid', 'Produktif', 'Telah Dimanfaatkan'),
(6, '01.02.04.02.001', 'Masjid', 'Produktif', 'Telah Dimanfaatkan'),
(7, '01.02.01.02.001', 'Kantor Pimpinan Wilayah Muhammadiyah DIY', 'Produktif', 'Telah Dimanfaatkan'),
(8, '01.02.01.02.001', 'Kantor Pimpinan Wilayah Muhammadiyah DIY', 'Produktif', 'Telah Dimanfaatkan'),
(9, '01.02.01.02.001', 'Kantor Pimpinan Wilayah Muhammadiyah DIY', 'Produktif', 'Telah Dimanfaatkan'),
(10, '01.02.01.02.001', 'Kantor Pimpinan Wilayah Muhammadiyah DIY', 'Produktif', 'Telah Dimanfaatkan'),
(11, '01.02.01.02.001', 'Kantor Pimpinan Wilayah Muhammadiyah DIY', 'Produktif', 'Telah Dimanfaatkan'),
(12, '01.02.01.02.001', 'Kantor Pimpinan Wilayah Muhammadiyah DIY', 'Produktif', 'Telah Dimanfaatkan'),
(13, '01.02.01.02.003', 'Gedung PWM Lantai 1', 'Produktif', 'Telah Dimanfaatkan'),
(14, '01.02.01.02.003', 'Gedung PWM Lantai 2', 'Produktif', 'Telah Dimanfaatkan'),
(15, '01.02.01.02.004', 'Gedung Grha TR', 'Produktif', 'Telah Dimanfaatkan'),
(16, '01.02.01.02.004', 'Gedung Grha TR', 'Produktif', 'Telah Dimanfaatkan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `clusterbarang`
--

CREATE TABLE `clusterbarang` (
  `id_barang` int(11) NOT NULL,
  `kode_aset` text NOT NULL,
  `jenis` varchar(256) NOT NULL,
  `hasil` text NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `clusterbarang`
--

INSERT INTO `clusterbarang` (`id_barang`, `kode_aset`, `jenis`, `hasil`, `keterangan`) VALUES
(1, '03.01.01.01.001-239', 'Kursi Spon', 'Produktif', 'Termanfaatkan'),
(2, '03.01.01.02.001-046', 'Kursi Sofa kayu', 'Produktif', 'Termanfaatkan'),
(3, '03.01.01.03.001-004', 'Kursi Sofa', 'Produktif', 'Termanfaatkan'),
(4, '03.01.01.04.001-043', 'Kursi putar', 'Produktif', 'Termanfaatkan'),
(5, '03.01.02.01.001-029', 'Meja Kerja', 'Produktif', 'Termanfaatkan'),
(6, '03.01.02.02.001-005', 'Meja Rapat', 'Produktif', 'Termanfaatkan'),
(7, '03.01.02.03.001-052', 'Meja Sidang', 'Produktif', 'Termanfaatkan'),
(8, '03.01.02.04.001-009', 'Meja Rangka Besi Kecil', 'Produktif', 'Termanfaatkan'),
(9, '03.01.02.05.001-004', 'Meja Rangka Besi besar', 'Produktif', 'Termanfaatkan'),
(10, '03.01.02.06.001-005', 'Meja Komputer', 'Produktif', 'Termanfaatkan'),
(11, '03.01.02.07.001-003', 'Meja Mimbar', 'Produktif', 'Termanfaatkan'),
(12, '03.01.02.09.001-002', 'Meja Kayu Kaca', 'Produktif', 'Termanfaatkan'),
(13, '03.01.02.10.001-004', 'Meja Kayu', 'Produktif', 'Termanfaatkan'),
(14, '03.01.03.01.001-006', 'Almari 3 pintu', 'Produktif', 'Termanfaatkan'),
(15, '03.01.03.02.001-008', 'Almari 2 pintu', 'Produktif', 'Termanfaatkan'),
(16, '03.01.03.03.001', 'Almari + Rak', 'Produktif', 'Termanfaatkan'),
(17, '03.01.03.04.001-008', 'Filling Cabinet Besar', 'Produktif', 'Termanfaatkan'),
(18, '03.01.03.05.001-004', 'Filling Cabinet Kecil', 'Produktif', 'Termanfaatkan'),
(19, '03.01.03.06.001-005', 'Rak Buku Besar', 'Produktif', 'Termanfaatkan'),
(20, '03.01.03.07.001-003', 'Rak Buku Kecil', 'Produktif', 'Termanfaatkan'),
(21, '03.01.03.08.001-010', 'Etalase', 'Produktif', 'Termanfaatkan'),
(22, '03.01.03.09.001-003', 'Almari Kaca 1 Pintu', 'Produktif', 'Termanfaatkan'),
(23, '03.01.03.10.001-002', 'Almari Plastik', 'Produktif', 'Termanfaatkan'),
(24, '03.01.04.01.001', 'White Board Besar', 'Produktif', 'Termanfaatkan'),
(25, '03.01.04.02.001-002', 'White Board Kecil', 'Produktif', 'Termanfaatkan'),
(26, '03.02.01.01.001-009', 'Monitor Flat', 'Produktif', 'Termanfaatkan'),
(27, '03.02.01.02.001-003', 'Monitor Tabung', 'Produktif', 'Termanfaatkan'),
(28, '03.02.01.03.001-013', 'CPU', 'Produktif', 'Termanfaatkan'),
(29, '03.02.01.04.001-011', 'Keyboard', 'Produktif', 'Termanfaatkan'),
(30, '03.02.01.05.001-011', 'Mouse', 'Produktif', 'Termanfaatkan'),
(31, '03.02.01.06.001-004', 'Laptop/netbook', 'Produktif', 'Termanfaatkan'),
(32, '03.02.01.07.001-013', 'Printer/Scanner', 'Tidak Produktif', 'Terdapat barang dengan kondisi rusak berat atau hilang'),
(33, '03.02.01.08.001-008', 'Speaker komputer', 'Produktif', 'Termanfaatkan'),
(34, '03.02.01.09.001', 'Power Supply', 'Produktif', 'Termanfaatkan'),
(35, '03.02.01.10.001-002', 'Stabilizer', 'Produktif', 'Termanfaatkan'),
(36, '03.02.02.01.001-004', 'Microfon', 'Produktif', 'Termanfaatkan'),
(37, '03.02.02.02.001-002', 'TOA Pengeras Suara', 'Produktif', 'Termanfaatkan'),
(38, '03.02.02.03.001-002', 'Ampli', 'Produktif', 'Termanfaatkan'),
(39, '03.02.02.04.001-006', 'Sound', 'Produktif', 'Termanfaatkan'),
(40, '03.02.02.05.001-002', 'Tape/Radio', 'Produktif', 'Termanfaatkan'),
(41, '03.02.02.06.001-008', 'Stand Mic', 'Produktif', 'Termanfaatkan'),
(42, '03.02.02.07.001-002', 'Wirelees', 'Produktif', 'Termanfaatkan'),
(43, '03.02.02.08.001-008', 'Kamera CCTV', 'Produktif', 'Termanfaatkan'),
(44, '03.02.03.01.001-026', 'AC', 'Produktif', 'Termanfaatkan'),
(45, '03.02.03.02.001-011', 'Kipas Angin', 'Tidak Produktif', 'Terdapat barang dengan kondisi rusak berat atau hilang'),
(46, '03.02.03.03.001-005', 'Proyektor', 'Produktif', 'Termanfaatkan'),
(47, '03.02.03.04.001-005', 'Dispenser', 'Produktif', 'Termanfaatkan'),
(48, '03.02.03.05.001-006', 'Kabel Rol', 'Produktif', 'Termanfaatkan'),
(49, '03.02.03.06.001-002', 'Vacum Cleaner', 'Produktif', 'Termanfaatkan'),
(50, '03.02.03.07.001-009', 'LED TV', 'Produktif', 'Termanfaatkan'),
(51, '03.02.03.08.001', 'Screen', 'Produktif', 'Termanfaatkan'),
(52, '03.02.03.09.001-002', 'Receiver', 'Produktif', 'Termanfaatkan'),
(53, '03.02.03.10.001', 'Alat Penghitung Uang', 'Produktif', 'Termanfaatkan'),
(54, '03.02.03.12.001-008', 'Blower', 'Produktif', 'Termanfaatkan'),
(55, '03.02.03.13.001', 'Fingerspot', 'Produktif', 'Termanfaatkan'),
(56, '03.02.03.14.001', 'Kamera', 'Produktif', 'Termanfaatkan'),
(57, '03.02.04.01.001-009', 'Telephone', 'Produktif', 'Termanfaatkan'),
(58, '03.02.04.02.001-003', 'HP', 'Produktif', 'Termanfaatkan'),
(59, '03.03.01.01.001-002', 'Kompor', 'Produktif', 'Termanfaatkan'),
(60, '03.03.01.02.001-002', 'Tabung Gas', 'Produktif', 'Termanfaatkan'),
(61, '03.03.01.03.001-004', 'Galon', 'Produktif', 'Termanfaatkan'),
(62, '03.03.01.04.001-007', 'Panci/Soblok/Rantang', 'Produktif', 'Termanfaatkan'),
(63, '03.03.01.06.001-604', 'Piring', 'Produktif', 'Termanfaatkan'),
(64, '03.03.01.07.001-332', 'Gelas', 'Produktif', 'Termanfaatkan'),
(65, '03.03.01.08.001-292', 'Sendok', 'Produktif', 'Termanfaatkan'),
(66, '03.03.01.09.001-047', 'Mangkok', 'Produktif', 'Termanfaatkan'),
(67, '03.03.01.10.001-136', 'Tutup Gelas', 'Produktif', 'Termanfaatkan'),
(68, '03.03.01.11.001-017', 'Ceret/Teko/Jumbo', 'Produktif', 'Termanfaatkan'),
(69, '03.03.01.12.001-008', 'Nampan', 'Produktif', 'Termanfaatkan'),
(70, '03.03.01.13.001-014', 'Krat Gelas/Piring', 'Produktif', 'Termanfaatkan'),
(71, '03.03.01.14.001-008', 'Pisau', 'Produktif', 'Termanfaatkan'),
(72, '03.03.01.15.001', 'Blender', 'Produktif', 'Termanfaatkan'),
(73, '03.03.01.16.001', 'Tempat Nasi', 'Produktif', 'Termanfaatkan'),
(74, '03.03.01.17.001-005', 'Toples', 'Produktif', 'Termanfaatkan'),
(75, '03.03.02.02.001-016', 'Kasur', 'Produktif', 'Termanfaatkan'),
(76, '03.03.02.05.001-008', 'Sprei', 'Produktif', 'Termanfaatkan'),
(77, '03.03.03.04.001-006', 'Jam Dinding', 'Produktif', 'Termanfaatkan'),
(78, '03.03.03.05.001-004', 'Pembatas Ruangan', 'Produktif', 'Termanfaatkan'),
(79, '03.03.03.06.001-002', 'Miniatur PWM', 'Produktif', 'Termanfaatkan'),
(80, '03.03.03.09.001-003', 'Cermin', 'Produktif', 'Termanfaatkan'),
(81, '03.03.03.10.001-005', 'Tiang Berndera', 'Produktif', 'Termanfaatkan'),
(82, '03.03.03.11.001', 'Rak Sepatu', 'Produktif', 'Termanfaatkan'),
(83, '03.03.03.12.001', 'Kotak Amal', 'Produktif', 'Termanfaatkan'),
(84, '03.03.03.13.001-017', 'Karpet', 'Produktif', 'Termanfaatkan'),
(85, '03.03.03.14.001-002', 'Tikar', 'Produktif', 'Termanfaatkan'),
(86, '03.03.03.15.001-010', 'Mukena', 'Tidak Diketahui', 'Jumlah barang dengan kondisi baik = 0'),
(87, '03.03.03.16.001-003', 'Sajadah', 'Produktif', 'Termanfaatkan'),
(88, '03.03.03.17.001-003', 'Sarung', 'Produktif', 'Termanfaatkan'),
(89, '03.01.01.05.001-241', 'Kursi Lipat', 'Produktif', 'Termanfaatkan'),
(90, '03.01.01.06.001-003', 'Kursi Kayu Besar/Panjang', 'Produktif', 'Termanfaatkan'),
(91, '03.02.03.15.001', 'Mesin Ketik', 'Produktif', 'Termanfaatkan'),
(92, '03.02.03.16.001', 'Mesin Bor dan Matabor', 'Produktif', 'Termanfaatkan'),
(93, '03.02.03.17.001', 'Penyangga TV', 'Produktif', 'Termanfaatkan'),
(94, '03.03.03.18.001', 'Timbangan', 'Produktif', 'Termanfaatkan'),
(95, '03.03.02.01.001-012', 'Dipan', 'Produktif', 'Termanfaatkan'),
(96, '03.01.03.11.001', 'Rak Koran', 'Produktif', 'Termanfaatkan'),
(97, '03.01.03.16.001', 'Brangkas', 'Produktif', 'Termanfaatkan'),
(98, '03.02.01.16.001', 'D Link Des', 'Produktif', 'Termanfaatkan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `clusterkendaraan`
--

CREATE TABLE `clusterkendaraan` (
  `id_kendaraan` int(11) NOT NULL,
  `kode_aset` text NOT NULL,
  `kendaraan` varchar(256) NOT NULL,
  `hasil` text NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `clusterkendaraan`
--

INSERT INTO `clusterkendaraan` (`id_kendaraan`, `kode_aset`, `kendaraan`, `hasil`, `keterangan`) VALUES
(1, '02.01.01.01.001', 'Kijang Innova', 'Produktif', 'Telah Dimanfaatkan'),
(2, '02.01.01.01.001', 'Kijang Innova', 'Produktif', 'Telah Dimanfaatkan'),
(3, '02.01.01.01.001', 'Kijang Innova', 'Produktif', 'Telah Dimanfaatkan'),
(4, '02.01.01.01.001', 'Kijang Innova', 'Produktif', 'Telah Dimanfaatkan'),
(5, '02.01.01.01.001', 'Kijang Innova', 'Produktif', 'Telah Dimanfaatkan'),
(6, '02.01.01.01.002', 'Kijang Innova', 'Produktif', 'Telah Dimanfaatkan'),
(7, '02.01.01.01.002', 'Kijang Innova', 'Produktif', 'Telah Dimanfaatkan'),
(8, '02.01.01.01.002', 'Kijang Innova', 'Produktif', 'Telah Dimanfaatkan'),
(9, '02.01.01.01.002', 'Kijang Innova', 'Produktif', 'Telah Dimanfaatkan'),
(10, '02.01.01.01.002', 'Kijang Innova', 'Produktif', 'Telah Dimanfaatkan'),
(11, '02.01.01.01.002', 'Kijang Innova', 'Produktif', 'Telah Dimanfaatkan'),
(12, '02.01.01.02.001', 'Avanza', 'Produktif', 'Telah Dimanfaatkan'),
(13, '02.01.01.02.001', 'Avanza', 'Produktif', 'Telah Dimanfaatkan'),
(14, '02.01.01.02.001', 'Avanza', 'Produktif', 'Telah Dimanfaatkan'),
(15, '02.01.01.02.001', 'Avanza', 'Produktif', 'Telah Dimanfaatkan'),
(16, '02.01.01.02.001', 'Avanza', 'Produktif', 'Telah Dimanfaatkan'),
(17, '02.01.01.02.001', 'Avanza', 'Produktif', 'Telah Dimanfaatkan'),
(18, '02.01.01.02.002', 'Avanza', 'Produktif', 'Telah Dimanfaatkan'),
(19, '02.01.01.02.002', 'Avanza', 'Produktif', 'Telah Dimanfaatkan'),
(20, '02.01.01.02.002', 'Avanza', 'Produktif', 'Telah Dimanfaatkan'),
(21, '02.01.01.02.002', 'Avanza', 'Produktif', 'Telah Dimanfaatkan'),
(22, '02.01.01.02.002', 'Avanza', 'Produktif', 'Telah Dimanfaatkan'),
(23, '02.01.01.02.002', 'Avanza', 'Produktif', 'Telah Dimanfaatkan'),
(24, '02.01.01.02.003', 'AVANZA 225', 'Tidak Diketahui', 'Harga Taksir = 0'),
(25, '02.01.01.02.003', 'AVANZA 225', 'Tidak Diketahui', 'Harga Taksir = 0'),
(26, '02.01.01.02.003', 'AVANZA 225', 'Tidak Diketahui', 'Harga Taksir = 0'),
(27, '02.01.04.06.001', 'Futura Box', 'Tidak Produktif', 'Usia Kendaraan lebih dari 20 tahun'),
(28, '02.01.04.06.001', 'Futura Box', 'Tidak Produktif', 'Usia Kendaraan lebih dari 20 tahun'),
(29, '02.01.04.06.001', 'Futura Box', 'Tidak Produktif', 'Usia Kendaraan lebih dari 20 tahun'),
(30, '02.01.04.06.001', 'Futura Box', 'Tidak Produktif', 'Usia Kendaraan lebih dari 20 tahun'),
(31, '02.01.04.06.001', 'Futura Box', 'Tidak Produktif', 'Usia Kendaraan lebih dari 20 tahun'),
(32, '02.01.04.06.001', 'Futura Box', 'Tidak Produktif', 'Usia Kendaraan lebih dari 20 tahun'),
(33, '02.02.01.04.001', 'Supra X 125', 'Tidak Produktif', 'Usia Kendaraan lebih dari 20 tahun'),
(34, '02.02.01.04.001', 'Supra X 125', 'Tidak Produktif', 'Usia Kendaraan lebih dari 20 tahun'),
(35, '02.02.01.04.001', 'Supra X 125', 'Tidak Produktif', 'Usia Kendaraan lebih dari 20 tahun'),
(36, '02.02.01.04.001', 'Supra X 125', 'Tidak Produktif', 'Usia Kendaraan lebih dari 20 tahun'),
(37, '02.02.01.04.001', 'Supra X 125', 'Tidak Produktif', 'Usia Kendaraan lebih dari 20 tahun'),
(38, '02.02.01.04.006', 'Supra X 125', 'Tidak Produktif', 'Usia Kendaraan lebih dari 20 tahun'),
(39, '02.02.01.05.001', 'Revo', 'Produktif', 'Telah Dimanfaatkan'),
(40, '02.02.01.05.001', 'Revo', 'Produktif', 'Telah Dimanfaatkan'),
(41, '02.02.01.05.001', 'Revo', 'Produktif', 'Telah Dimanfaatkan'),
(42, '02.02.01.05.001', 'Revo', 'Produktif', 'Telah Dimanfaatkan'),
(43, '02.02.01.05.001', 'Revo', 'Produktif', 'Telah Dimanfaatkan'),
(44, '02.02.01.05.001', 'Revo', 'Produktif', 'Telah Dimanfaatkan'),
(45, '02.02.01.06.001', 'Astrea Prima', 'Produktif', 'Telah Dimanfaatkan'),
(46, '02.02.01.06.001', 'Astrea Prima', 'Produktif', 'Telah Dimanfaatkan'),
(47, '02.02.01.06.001', 'Astrea Prima', 'Produktif', 'Telah Dimanfaatkan'),
(48, '02.02.01.06.001', 'Astrea Prima', 'Produktif', 'Telah Dimanfaatkan'),
(49, '02.02.01.06.001', 'Astrea Prima', 'Produktif', 'Telah Dimanfaatkan'),
(50, '02.02.01.06.001', 'Astrea Prima', 'Produktif', 'Telah Dimanfaatkan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `clustertanah`
--

CREATE TABLE `clustertanah` (
  `id_tanah` int(11) NOT NULL,
  `kode_aset` text NOT NULL,
  `status_tanah` varchar(256) NOT NULL,
  `hasil` text NOT NULL,
  `keterangan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `clustertanah`
--

INSERT INTO `clustertanah` (`id_tanah`, `kode_aset`, `status_tanah`, `hasil`, `keterangan`) VALUES
(1, '01.01.01.01.001', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(2, '01.01.02.01.001', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(3, '01.01.02.01.002', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(4, '01.01.02.01.003', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(5, '01.01.02.01.004', 'Pekarangan', 'Tidak Diketahui', 'Belum Diverifikasi'),
(6, '01.01.02.01.005', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(7, '01.01.01.01.002', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(8, '01.01.02.01.001', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(9, '01.01.02.01.007', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(10, '01.01.01.01.001', 'Pekarangan', 'Tidak Produktif', 'Belum Termanfaatkan Oleh Pihak PWM'),
(11, '01.01.01.01.001', 'Pekarangan', 'Tidak Produktif', 'Belum Termanfaatkan Oleh Pihak PWM'),
(12, '01.01.01.01.002', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(13, '01.01.01.01.003', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(14, '01.01.02.01.001', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(15, '01.01.02.01.001', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(16, '01.01.02.01.001', 'Pekarangan', 'Tidak Produktif', 'Belum Termanfaatkan Oleh Pihak PWM'),
(17, '01.01.04.01.001', 'Pekarangan', 'Tidak Diketahui', 'Belum Diverifikasi'),
(18, '01.01.03.01.001', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(19, '01.01.03.01.002', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(20, '01.01.01.01.003', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(21, '01.01.01.01.004', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(22, '01.01.01.01.005', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(23, '01.01.01.01.006', 'Pekarangan', 'Produktif', 'Telah Dimanfaatkan'),
(24, '01.01.01.03.001', 'Sawah', 'Produktif', 'Telah Dimanfaatkan'),
(25, '01.01.01.03.001', 'Sawah', 'Produktif', 'Telah Dimanfaatkan'),
(26, '01.01.01.03.001', 'Sawah', 'Produktif', 'Telah Dimanfaatkan'),
(27, '01.01.01.03.001', 'Sawah', 'Produktif', 'Telah Dimanfaatkan'),
(28, '01.01.02.03.001', 'Sawah', 'Produktif', 'Telah Dimanfaatkan'),
(29, '01.01.02.03.002', 'Sawah', 'Produktif', 'Telah Dimanfaatkan'),
(30, '01.01.02.03.001', 'Sawah', 'Tidak Diketahui', 'Belum Diverifikasi'),
(31, '01.01.01.02.001', 'Tegalan', 'Produktif', 'Telah Dimanfaatkan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nama` varchar(200) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `level` enum('Admin Super','Admin Daerah','Pimpinan') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `nama`, `username`, `password`, `email`, `level`) VALUES
(12, 'Pimpinan', 'pimpinan', 'pbkdf2:sha256:260000$5GmHrDuKqQRGscau$656267a82e3814f0544fcd466d463ea2753215f665be03c216c2c9bd1bc9c93e', 'cindymayezaputri1@gmail.com', 'Pimpinan'),
(15, 'Admin Daerah', 'admin_daerah', 'pbkdf2:sha256:150000$oUTeFXLb$e7576e54ac2d76cbea308ed8ea1b874ba34382777ae9ac74e562a1f4e1a07088', 'admindaerah@gmail.com', 'Admin Daerah'),
(17, 'admin super', 'admin super', 'pbkdf2:sha256:260000$SJvP2EdNju9D7YJL$fd1cfa3f525364172a71e0d037ddfdeaf5b1aad336eb24753a06c1115e51eec7', 'adminsuper@gmail.com', 'Admin Super');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `clusterbangunan`
--
ALTER TABLE `clusterbangunan`
  ADD PRIMARY KEY (`id_bangunan`);

--
-- Indeks untuk tabel `clusterbarang`
--
ALTER TABLE `clusterbarang`
  ADD PRIMARY KEY (`id_barang`);

--
-- Indeks untuk tabel `clusterkendaraan`
--
ALTER TABLE `clusterkendaraan`
  ADD PRIMARY KEY (`id_kendaraan`);

--
-- Indeks untuk tabel `clustertanah`
--
ALTER TABLE `clustertanah`
  ADD PRIMARY KEY (`id_tanah`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `clusterbangunan`
--
ALTER TABLE `clusterbangunan`
  MODIFY `id_bangunan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `clusterbarang`
--
ALTER TABLE `clusterbarang`
  MODIFY `id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT untuk tabel `clusterkendaraan`
--
ALTER TABLE `clusterkendaraan`
  MODIFY `id_kendaraan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT untuk tabel `clustertanah`
--
ALTER TABLE `clustertanah`
  MODIFY `id_tanah` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
