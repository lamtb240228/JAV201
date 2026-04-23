-- --------------------------------------------------------
-- Host:                         yeumedevs.space
-- Server version:               10.6.23-MariaDB-cll-lve - MariaDB Server
-- Server OS:                    Linux
-- HeidiSQL Version:             12.14.0.7165
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for yeumeent_jav201_assignment
CREATE DATABASE IF NOT EXISTS `yeumeent_jav201_assignment` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `yeumeent_jav201_assignment`;

-- Dumping structure for table yeumeent_jav201_assignment.favorites
CREATE TABLE IF NOT EXISTS `favorites` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `VideoId` varchar(50) NOT NULL,
  `LikeDate` date NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UserId` (`UserId`,`VideoId`),
  KEY `VideoId` (`VideoId`),
  CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`UserId`) ON DELETE CASCADE,
  CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`VideoId`) REFERENCES `videos` (`VideoId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table yeumeent_jav201_assignment.favorites: ~2 rows (approximately)
INSERT INTO `favorites` (`Id`, `UserId`, `VideoId`, `LikeDate`) VALUES
	(5, 6, 'VID60', '2026-02-04'),
	(6, 4, 'VID60', '2026-02-04');

-- Dumping structure for table yeumeent_jav201_assignment.shares
CREATE TABLE IF NOT EXISTS `shares` (
  `Id` bigint(20) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `VideoId` varchar(50) NOT NULL,
  `Emails` varchar(255) NOT NULL,
  `ShareDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`Id`),
  KEY `VideoId` (`VideoId`),
  KEY `shares_ibfk_1` (`UserId`),
  CONSTRAINT `shares_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`UserId`) ON DELETE CASCADE,
  CONSTRAINT `shares_ibfk_2` FOREIGN KEY (`VideoId`) REFERENCES `videos` (`VideoId`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table yeumeent_jav201_assignment.shares: ~4 rows (approximately)
INSERT INTO `shares` (`Id`, `UserId`, `VideoId`, `Emails`, `ShareDate`) VALUES
	(1, 6, 'VID60', 'lamtbts02316@gmail.com', '2026-02-03 10:06:53'),
	(2, 6, 'VID60', 'lamtbts02316@gmail.com', '2026-02-03 10:49:52'),
	(3, 4, 'VID60', 'baondgts02278@gmail.com', '2026-02-03 21:07:05'),
	(4, 6, 'VID60', 'anh.huynhleduc@gmail.com', '2026-02-04 00:28:42');

-- Dumping structure for table yeumeent_jav201_assignment.users
CREATE TABLE IF NOT EXISTS `users` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `Password` varchar(50) NOT NULL,
  `Fullname` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Admin` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`UserId`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `UserId_UNIQUE` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table yeumeent_jav201_assignment.users: ~8 rows (approximately)
INSERT INTO `users` (`UserId`, `Password`, `Fullname`, `Email`, `Admin`) VALUES
	(1, '1234', 'Bùi Nhật Quốc Anh', 'buinhatquocanh@gmail.com', 0),
	(2, '123', 'Trần Hải Nam', 'nam200@gmail.com', 0),
	(3, 'sqSbrkuJb43@iuf', 'Bùi Đức Trí', 'chez1s.dev@gmail.com', 1),
	(4, '12345', 'Nguyen Dinh Gia Bao', 'baondgts02278@gmail.com', 0),
	(5, 'lequocminh@123', 'Le Quoc Minh', 'minhlqts02392@gmail.com', 0),
	(6, '123456789', 'Trần Bá Lãm', 'lamtbts02316@gmail.com', 0),
	(7, 'Hau123@Aa', 'Nguyễn Vủ Hậu', 'hau87899@gmail.com', 0),
	(8, 'nguginoi123', 'Burger Zinger', 'thanh273@gmail.com', 0);

-- Dumping structure for table yeumeent_jav201_assignment.videos
CREATE TABLE IF NOT EXISTS `videos` (
  `VideoId` varchar(50) NOT NULL,
  `Title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Poster` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Active` tinyint(1) NOT NULL,
  `Views` int(11) DEFAULT 0,
  `UserId` int(11) NOT NULL,
  PRIMARY KEY (`VideoId`),
  KEY `idx_video_views` (`Views`),
  KEY `idx_video_views_desc` (`Views`),
  KEY `videos_ibfk_1_idx` (`UserId`),
  CONSTRAINT `fk_videos_userid` FOREIGN KEY (`UserId`) REFERENCES `users` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Dumping data for table yeumeent_jav201_assignment.videos: ~60 rows (approximately)
INSERT INTO `videos` (`VideoId`, `Title`, `Poster`, `Description`, `Active`, `Views`, `UserId`) VALUES
	('VID001', 'Giới thiệu ngành Công nghệ Thông tin', 'https://www.youtube.com/embed/6F3Ma2GrYmo', 'Tổng quan về ngành CNTT và cơ hội nghề nghiệp', 1, 15230, 1),
	('VID002', 'Lộ trình học lập trình cho người mới', 'laptrinh_beginner.jpg', 'Hướng dẫn học lập trình từ con số 0', 1, 28450, 1),
	('VID003', 'So sánh Frontend và Backend', 'S', 'Phân biệt Frontend và Backend Developer', 1, 19870, 1),
	('VID004', 'Top 5 ngôn ngữ lập trình phổ biến 2025', 'top_languages.jpg', 'Xu hướng ngôn ngữ lập trình hiện nay', 1, 32540, 2),
	('VID005', 'Giới thiệu trí tuệ nhân tạo AI', 'ai_intro.jpg', 'AI là gì và được ứng dụng như thế nào', 1, 41200, 2),
	('VID006', 'Machine Learning hoạt động ra sao', 'machine_learning.jpg', 'Cách Machine Learning học từ dữ liệu', 1, 26780, 2),
	('VID007', 'Học Java cơ bản trong 30 phút', 'java_basic.jpg', 'Kiến thức Java căn bản cho sinh viên', 1, 18990, 3),
	('VID008', 'Hướng dẫn lập trình Web với HTML CSS', 'html_css.jpg', 'Xây dựng giao diện web cơ bản', 1, 22110, 3),
	('VID009', 'JavaScript căn bản cho Web Developer', 'javascript_basic.jpg', 'Những kiến thức JS không thể bỏ qua', 1, 30560, 3),
	('VID010', 'Framework là gì', 'framework.jpg', 'Giới thiệu các framework phổ biến', 1, 17400, 4),
	('VID011', 'So sánh React và Angular', 'react_angular.jpg', 'Nên chọn React hay Angular', 1, 23890, 4),
	('VID012', 'Backend với Spring Boot', 'spring_boot.jpg', 'Xây dựng API với Spring Boot', 1, 19230, 4),
	('VID013', 'Cơ sở dữ liệu SQL cho người mới', 'sql_basic.jpg', 'Nhập môn cơ sở dữ liệu SQL', 1, 26040, 4),
	('VID014', 'NoSQL là gì', 'nosql.jpg', 'So sánh SQL và NoSQL', 1, 15470, 5),
	('VID015', 'An toàn thông tin và bảo mật mạng', 'security.jpg', 'Những kiến thức cơ bản về bảo mật', 1, 21090, 5),
	('VID016', 'Hacker mũ trắng là ai', 'white_hat.jpg', 'Giới thiệu nghề Ethical Hacker', 1, 28760, 5),
	('VID017', 'Điện toán đám mây Cloud Computing', 'cloud.jpg', 'Tổng quan về Cloud Computing', 1, 33210, 5),
	('VID018', 'DevOps là gì', 'devops.jpg', 'Quy trình DevOps trong doanh nghiệp', 1, 19840, 6),
	('VID019', 'Làm sao để trở thành Software Engineer', 'software_engineer.jpg', 'Con đường trở thành kỹ sư phần mềm', 1, 35490, 6),
	('VID020', 'Cơ hội việc làm ngành CNTT tại Việt Nam', 'it_jobs.jpg', 'Thị trường việc làm CNTT hiện nay', 1, 40120, 7),
	('VID21', 'Video 21', 'poster21.jpg', 'Mo ta video 21', 1, 120, 7),
	('VID22', 'Video 22', 'poster22.jpg', 'Mo ta video 22', 1, 85, 7),
	('VID23', 'Video 23', 'poster23.jpg', 'Mo ta video 23', 1, 230, 7),
	('VID24', 'Video 24', 'poster24.jpg', 'Mo ta video 24', 1, 45, 7),
	('VID25', 'Video 25', 'poster25.jpg', 'Mo ta video 25', 1, 67, 7),
	('VID26', 'Video 26', 'poster26.jpg', 'Mo ta video 26', 1, 310, 3),
	('VID27', 'Video 27', 'poster27.jpg', 'Mo ta video 27', 0, 15, 3),
	('VID28', 'Video 28', 'poster28.jpg', 'Mo ta video 28', 1, 98, 3),
	('VID29', 'Video 29', 'poster29.jpg', 'Mo ta video 29', 1, 176, 3),
	('VID30', 'Video 30', 'poster30.jpg', 'Mo ta video 30', 1, 54, 3),
	('VID31', 'Video 31', 'poster31.jpg', 'Mo ta video 31', 1, 200, 3),
	('VID32', 'Video 32', 'poster32.jpg', 'Mo ta video 32', 1, 89, 3),
	('VID33', 'Video 33', 'poster33.jpg', 'Mo ta video 33', 1, 142, 3),
	('VID34', 'Video 34', 'poster34.jpg', 'Mo ta video 34', 0, 20, 1),
	('VID35', 'Video 35', 'poster35.jpg', 'Mo ta video 35', 1, 305, 1),
	('VID36', 'Video 36', 'poster36.jpg', 'Mo ta video 36', 1, 77, 1),
	('VID37', 'Video 37', 'poster37.jpg', 'Mo ta video 37', 1, 188, 1),
	('VID38', 'Video 38', 'poster38.jpg', 'Mo ta video 38', 1, 66, 1),
	('VID39', 'Video 39', 'poster39.jpg', 'Mo ta video 39', 1, 412, 1),
	('VID40', 'Video 40', 'poster40.jpg', 'Mo ta video 40', 1, 95, 1),
	('VID41', 'Video 41', 'poster41.jpg', 'Mo ta video 41', 1, 134, 1),
	('VID42', 'Video 42', 'poster42.jpg', 'Mo ta video 42', 1, 58, 2),
	('VID43', 'Video 43', 'poster43.jpg', 'Mo ta video 43', 1, 276, 2),
	('VID44', 'Video 44', 'poster44.jpg', 'Mo ta video 44', 0, 33, 2),
	('VID45', 'Video 45', 'poster45.jpg', 'Mo ta video 45', 1, 149, 2),
	('VID46', 'Video 46', 'poster46.jpg', 'Mo ta video 46', 1, 221, 2),
	('VID47', 'Video 47', 'poster47.jpg', 'Mo ta video 47', 1, 64, 2),
	('VID48', 'Video 48', 'poster48.jpg', 'Mo ta video 48', 1, 187, 3),
	('VID49', 'Video 49', 'poster49.jpg', 'Mo ta video 49', 1, 390, 3),
	('VID50', 'Video 50', 'poster50.jpg', 'Mo ta video 50', 1, 112, 3),
	('VID51', 'Video 51', 'poster51.jpg', 'Mo ta video 51', 1, 80, 3),
	('VID52', 'Video 52', 'poster52.jpg', 'Mo ta video 52', 1, 60, 3),
	('VID53', 'Video 53', 'poster53.jpg', 'Mo ta video 53', 1, 145, 3),
	('VID54', 'Video 54', 'poster54.jpg', 'Mo ta video 54', 0, 22, 3),
	('VID55', 'Video 55', 'poster55.jpg', 'Mo ta video 55', 1, 275, 5),
	('VID56', 'Video 56', 'poster56.jpg', 'Mo ta video 56', 1, 98, 5),
	('VID57', 'Video 57', 'poster57.jpg', 'Mo ta video 57', 1, 164, 5),
	('VID58', 'Video 58', 'poster58.jpg', 'Mo ta video 58', 1, 53, 5),
	('VID59', 'Video 59', 'poster59.jpg', 'Mo ta video 59', 1, 410, 5),
	('VID60', 'video mới nhất', 'https://www.youtube.com/watch?v=ENtSGP6MDMY', '#spidermanmaidinh #peterpaker #github', 0, 129, 5);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
