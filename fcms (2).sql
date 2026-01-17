-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 17, 2026 at 11:01 AM
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
-- Database: `fcms`
--

-- --------------------------------------------------------

--
-- Table structure for table `club`
--

CREATE TABLE `club` (
  `ClubID` int(11) NOT NULL,
  `ClubName` varchar(255) NOT NULL,
  `ClubDescription` text DEFAULT NULL,
  `FacultyID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `club`
--

INSERT INTO `club` (`ClubID`, `ClubName`, `ClubDescription`, `FacultyID`) VALUES
(1, 'compass', 'club for computer science', 1);

-- --------------------------------------------------------

--
-- Table structure for table `clubeventapplication`
--

CREATE TABLE `clubeventapplication` (
  `CEAppID` int(11) NOT NULL,
  `CEAppStatus` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `ClubID` int(11) DEFAULT NULL,
  `ApproverID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `EventID` int(11) NOT NULL,
  `EventName` varchar(255) NOT NULL,
  `EventDate` date DEFAULT NULL,
  `EventTime` time DEFAULT NULL,
  `EventVenue` varchar(255) DEFAULT NULL,
  `EventStatus` varchar(50) DEFAULT NULL,
  `EventAttendance` int(11) DEFAULT NULL,
  `ClubID` int(11) DEFAULT NULL,
  `CEAppID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`EventID`, `EventName`, `EventDate`, `EventTime`, `EventVenue`, `EventStatus`, `EventAttendance`, `ClubID`, `CEAppID`) VALUES
(1, 'HACKATHON INTERNATIONAL', '2026-05-12', '09:00:00', 'Dewan Agong', 'Upcoming', 0, 1, NULL),
(2, 'COMPASS FAMILY DAY', '2026-06-02', '08:00:00', 'UiTM Field', 'Upcoming', 0, 1, NULL),
(3, 'FEST-BAF 2026', '2026-08-12', '10:00:00', 'Lobby FSKM', 'Upcoming', 0, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `eventregistration`
--

CREATE TABLE `eventregistration` (
  `RegisID` int(11) NOT NULL,
  `RegisDate` date DEFAULT NULL,
  `EventID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `RegisStatus` enum('APPROVED','REJECTED','PENDING') DEFAULT 'PENDING'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `eventregistration`
--

INSERT INTO `eventregistration` (`RegisID`, `RegisDate`, `EventID`, `UserID`, `RegisStatus`) VALUES
(1, '2026-01-17', 1, 1001, 'APPROVED'),
(2, '2026-01-17', 2, 1001, 'REJECTED'),
(3, '2026-01-17', 3, 1001, 'PENDING');

-- --------------------------------------------------------

--
-- Table structure for table `faculty`
--

CREATE TABLE `faculty` (
  `FacultyID` int(11) NOT NULL,
  `FacultyName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `faculty`
--

INSERT INTO `faculty` (`FacultyID`, `FacultyName`) VALUES
(1, 'FSKM');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `ReportID` int(11) NOT NULL,
  `StudentQuantity` int(11) DEFAULT NULL,
  `EventPictures` blob DEFAULT NULL,
  `RegisID` int(11) DEFAULT NULL,
  `EventID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `UserID` int(11) NOT NULL,
  `UserName` varchar(255) NOT NULL,
  `UserEmail` varchar(255) DEFAULT NULL,
  `UserPhone` varchar(20) DEFAULT NULL,
  `UserSemester` int(11) DEFAULT NULL,
  `UserRole` enum('Student','Member','Advisor') NOT NULL,
  `UserPassword` varchar(255) DEFAULT NULL,
  `FacultyID` int(11) DEFAULT NULL,
  `ClubID` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`UserID`, `UserName`, `UserEmail`, `UserPhone`, `UserSemester`, `UserRole`, `UserPassword`, `FacultyID`, `ClubID`, `created_at`, `updated_at`) VALUES
(1, 'root', 'karikarim@gmail.com', '0138128420', NULL, '', '1234', 1, 1, '2026-01-17 00:39:51', '2026-01-17 00:39:51'),
(1001, 'zaim', 'zaim@uitm.edu.my', NULL, NULL, 'Advisor', 'zaim123', 1, NULL, '2026-01-17 00:39:51', '2026-01-17 00:39:51'),
(2001, 'Zaim Members', 'zaim@student.uitm.edu.my', NULL, 3, 'Member', 'member123', 1, 1, '2026-01-17 00:39:51', '2026-01-17 00:39:51'),
(3001, 'Zaim Normal', 'zaim@gmail.com', NULL, 1, 'Student', 'zaim123', 1, 1, '2026-01-17 00:39:51', '2026-01-17 00:39:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `club`
--
ALTER TABLE `club`
  ADD PRIMARY KEY (`ClubID`),
  ADD KEY `FacultyID` (`FacultyID`);

--
-- Indexes for table `clubeventapplication`
--
ALTER TABLE `clubeventapplication`
  ADD PRIMARY KEY (`CEAppID`),
  ADD KEY `ClubID` (`ClubID`),
  ADD KEY `ApproverID` (`ApproverID`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`EventID`),
  ADD KEY `fk_club_event` (`ClubID`),
  ADD KEY `event_ibfk_1` (`CEAppID`);

--
-- Indexes for table `eventregistration`
--
ALTER TABLE `eventregistration`
  ADD PRIMARY KEY (`RegisID`),
  ADD KEY `EventID` (`EventID`),
  ADD KEY `UserID` (`UserID`);

--
-- Indexes for table `faculty`
--
ALTER TABLE `faculty`
  ADD PRIMARY KEY (`FacultyID`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`ReportID`),
  ADD KEY `RegisID` (`RegisID`),
  ADD KEY `EventID` (`EventID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `UserEmail` (`UserEmail`),
  ADD KEY `FacultyID` (`FacultyID`),
  ADD KEY `ClubID` (`ClubID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `EventID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `eventregistration`
--
ALTER TABLE `eventregistration`
  MODIFY `RegisID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3002;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `club`
--
ALTER TABLE `club`
  ADD CONSTRAINT `club_ibfk_1` FOREIGN KEY (`FacultyID`) REFERENCES `faculty` (`FacultyID`);

--
-- Constraints for table `clubeventapplication`
--
ALTER TABLE `clubeventapplication`
  ADD CONSTRAINT `clubeventapplication_ibfk_1` FOREIGN KEY (`ClubID`) REFERENCES `club` (`ClubID`),
  ADD CONSTRAINT `clubeventapplication_ibfk_2` FOREIGN KEY (`ApproverID`) REFERENCES `user` (`UserID`);

--
-- Constraints for table `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `event_ibfk_1` FOREIGN KEY (`CEAppID`) REFERENCES `clubeventapplication` (`CEAppID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_club_event` FOREIGN KEY (`ClubID`) REFERENCES `club` (`ClubID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eventregistration`
--
ALTER TABLE `eventregistration`
  ADD CONSTRAINT `eventregistration_ibfk_1` FOREIGN KEY (`EventID`) REFERENCES `event` (`EventID`),
  ADD CONSTRAINT `eventregistration_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
