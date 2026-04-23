/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE IF NOT EXISTS `users` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `Password` varchar(50) NOT NULL,
  `Fullname` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Admin` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`UserId`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `UserId_new` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

CREATE TABLE IF NOT EXISTS `videos` (
  `VideoId` varchar(50) NOT NULL,
  `Title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Poster` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Description` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Active` tinyint(1) NOT NULL,
  `Views` int(11) DEFAULT 0,
  PRIMARY KEY (`VideoId`),
  KEY `idx_video_views` (`Views`),
  KEY `idx_video_views_desc` (`Views`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
