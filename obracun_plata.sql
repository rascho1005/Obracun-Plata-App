-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 03, 2024 at 10:11 PM
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
-- Database: `obracun plata`
--

-- --------------------------------------------------------

--
-- Table structure for table `direktor`
--

CREATE TABLE `direktor` (
  `direktor_id` int(11) NOT NULL,
  `direktor_ime_prezime` varchar(50) NOT NULL,
  `korisnicko_ime` varchar(30) NOT NULL,
  `lozinka` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `direktor`
--

INSERT INTO `direktor` (`direktor_id`, `direktor_ime_prezime`, `korisnicko_ime`, `lozinka`) VALUES
(1, 'Petar Nesovanovic', 'petar22', 'petar123');

-- --------------------------------------------------------

--
-- Table structure for table `isplata`
--

CREATE TABLE `isplata` (
  `isplata_id` int(11) NOT NULL,
  `radnik_id` int(11) NOT NULL,
  `datum_isplate` date NOT NULL DEFAULT current_timestamp(),
  `suma` int(11) NOT NULL,
  `direktor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `isplata`
--

INSERT INTO `isplata` (`isplata_id`, `radnik_id`, `datum_isplate`, `suma`, `direktor_id`) VALUES
(2, 3, '2024-07-03', 300, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pozicija`
--

CREATE TABLE `pozicija` (
  `pozicija_id` int(11) NOT NULL,
  `ime_pozicije` varchar(30) NOT NULL,
  `satnica` int(11) NOT NULL,
  `direktor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `pozicija`
--

INSERT INTO `pozicija` (`pozicija_id`, `ime_pozicije`, `satnica`, `direktor_id`) VALUES
(1, 'Majstor', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `radnik`
--

CREATE TABLE `radnik` (
  `radnik_id` int(11) NOT NULL,
  `ime` varchar(30) NOT NULL,
  `prezime` varchar(30) NOT NULL,
  `godine` int(100) NOT NULL,
  `naziv_slike` varchar(50) NOT NULL,
  `datum_zaposljenja` date NOT NULL DEFAULT current_timestamp(),
  `opis` varchar(300) NOT NULL DEFAULT 'Nema opisa.',
  `ukupan_br_radnih_sati` int(11) NOT NULL DEFAULT 0,
  `ukupno_zaradjeno` int(11) NOT NULL DEFAULT 0,
  `trenutan_br_radnih_sati` int(11) NOT NULL DEFAULT 0,
  `trenutno_zaradjeno` int(11) NOT NULL DEFAULT 0,
  `korisnicko_ime` varchar(15) NOT NULL,
  `lozinka` varchar(20) NOT NULL,
  `ime_pozicije_id` int(11) NOT NULL,
  `satnica_id` int(11) NOT NULL,
  `direktor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `radnik`
--

INSERT INTO `radnik` (`radnik_id`, `ime`, `prezime`, `godine`, `naziv_slike`, `datum_zaposljenja`, `opis`, `ukupan_br_radnih_sati`, `ukupno_zaradjeno`, `trenutan_br_radnih_sati`, `trenutno_zaradjeno`, `korisnicko_ime`, `lozinka`, `ime_pozicije_id`, `satnica_id`, `direktor_id`) VALUES
(3, 'Milan', 'Nesovanovic', 49, 'Milan_Nesovanovic_milan22.jpg', '2024-07-02', 'Majstor vec 5 godina', 0, 0, 10, 40, 'milan22', 'milan123', 1, 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `direktor`
--
ALTER TABLE `direktor`
  ADD PRIMARY KEY (`direktor_id`);

--
-- Indexes for table `isplata`
--
ALTER TABLE `isplata`
  ADD PRIMARY KEY (`isplata_id`),
  ADD KEY `radnik_id` (`radnik_id`),
  ADD KEY `direktor_id` (`direktor_id`);

--
-- Indexes for table `pozicija`
--
ALTER TABLE `pozicija`
  ADD PRIMARY KEY (`pozicija_id`),
  ADD KEY `direktor_id` (`direktor_id`);

--
-- Indexes for table `radnik`
--
ALTER TABLE `radnik`
  ADD PRIMARY KEY (`radnik_id`),
  ADD KEY `ime_pozicije_id` (`ime_pozicije_id`),
  ADD KEY `satnica_id` (`satnica_id`),
  ADD KEY `direktor_id` (`direktor_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `direktor`
--
ALTER TABLE `direktor`
  MODIFY `direktor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `isplata`
--
ALTER TABLE `isplata`
  MODIFY `isplata_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `pozicija`
--
ALTER TABLE `pozicija`
  MODIFY `pozicija_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `radnik`
--
ALTER TABLE `radnik`
  MODIFY `radnik_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `isplata`
--
ALTER TABLE `isplata`
  ADD CONSTRAINT `isplata_ibfk_1` FOREIGN KEY (`radnik_id`) REFERENCES `radnik` (`radnik_id`),
  ADD CONSTRAINT `isplata_ibfk_2` FOREIGN KEY (`direktor_id`) REFERENCES `direktor` (`direktor_id`);

--
-- Constraints for table `pozicija`
--
ALTER TABLE `pozicija`
  ADD CONSTRAINT `pozicija_ibfk_1` FOREIGN KEY (`direktor_id`) REFERENCES `direktor` (`direktor_id`);

--
-- Constraints for table `radnik`
--
ALTER TABLE `radnik`
  ADD CONSTRAINT `radnik_ibfk_1` FOREIGN KEY (`ime_pozicije_id`) REFERENCES `pozicija` (`pozicija_id`),
  ADD CONSTRAINT `radnik_ibfk_2` FOREIGN KEY (`satnica_id`) REFERENCES `pozicija` (`pozicija_id`),
  ADD CONSTRAINT `radnik_ibfk_3` FOREIGN KEY (`direktor_id`) REFERENCES `direktor` (`direktor_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
