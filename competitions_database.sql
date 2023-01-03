-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 03, 2023 at 11:32 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `calisthenics_competitions`
--

-- --------------------------------------------------------

--
-- Table structure for table `Allenatore`
--

CREATE TABLE `Allenatore` (
  `IDAllenatore` varchar(16) NOT NULL,
  `nomePalestra` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Allenatore`
--

INSERT INTO `Allenatore` (`IDAllenatore`, `nomePalestra`) VALUES
('JRMFZC69T06L537B', 'MC Fit'),
('PRVBCL46S52G382G', 'Kayoka');

-- --------------------------------------------------------

--
-- Table structure for table `Atleta`
--

CREATE TABLE `Atleta` (
  `IDAtleta` varchar(16) NOT NULL,
  `IDAllenatore` varchar(16) DEFAULT NULL,
  `Genere` varchar(5) NOT NULL,
  `Età` int(2) NOT NULL,
  `Peso` int(3) NOT NULL,
  `Altezza` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Atleta`
--

INSERT INTO `Atleta` (`IDAtleta`, `IDAllenatore`, `Genere`, `Età`, `Peso`, `Altezza`) VALUES
('FMPCVD63A29L384Q', NULL, 'F', 33, 60, 171),
('LBHDRX82D44E892E', 'JRMFZC69T06L537B', 'M', 32, 82, 159),
('NRQLPB51D02Z600V', 'JRMFZC69T06L537B', 'M', 24, 67, 174),
('NVOYDS94R15G536D', 'PRVBCL46S52G382G', 'M', 27, 102, 176),
('RVRDFB70R08I381R', 'PRVBCL46S52G382G', 'F', 18, 53, 165),
('WQKJTF77A69B869L', 'JRMFZC69T06L537B', 'M', 24, 62, 175);

-- --------------------------------------------------------

--
-- Table structure for table `Categoria`
--

CREATE TABLE `Categoria` (
  `IDCategoria` int(20) NOT NULL,
  `nomeCategoria` varchar(20) NOT NULL,
  `pesoMin` int(5) NOT NULL,
  `pesoMax` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Categoria`
--

INSERT INTO `Categoria` (`IDCategoria`, `nomeCategoria`, `pesoMin`, `pesoMax`) VALUES
(1, 'Beginners', 50, 69),
(2, 'Beginners', 70, 89),
(3, 'Beginners ', 90, 109),
(4, 'Junior', 50, 69),
(5, 'Junior', 70, 89),
(6, 'Junior', 90, 109),
(7, 'Senior', 50, 69),
(8, 'Senior', 70, 89),
(9, 'Senior', 90, 109);

-- --------------------------------------------------------

--
-- Table structure for table `CategoriaAppartenenza`
--

CREATE TABLE `CategoriaAppartenenza` (
  `IDCategoria` int(20) NOT NULL,
  `IDAtleta` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `CategoriaAppartenenza`
--

INSERT INTO `CategoriaAppartenenza` (`IDCategoria`, `IDAtleta`) VALUES
(1, 'FMPCVD63A29L384Q'),
(4, 'NVOYDS94R15G536D'),
(5, 'RVRDFB70R08I381R'),
(7, 'LBHDRX82D44E892E'),
(7, 'WQKJTF77A69B869L'),
(9, 'NRQLPB51D02Z600V');

-- --------------------------------------------------------

--
-- Table structure for table `Competizione`
--

CREATE TABLE `Competizione` (
  `IDCompetizione` int(20) NOT NULL,
  `Data` date NOT NULL,
  `IDStruttura` int(20) NOT NULL,
  `numeroSpettatori` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Competizione`
--

INSERT INTO `Competizione` (`IDCompetizione`, `Data`, `IDStruttura`, `numeroSpettatori`) VALUES
(1, '2017-12-13', 1, 301),
(2, '2022-12-23', 2, 56),
(3, '2015-12-17', 3, 2101),
(4, '2018-10-17', 3, 780),
(5, '2014-04-23', 5, 120),
(6, '2020-08-21', 6, 670);

--
-- Triggers `Competizione`
--
DELIMITER $$
CREATE TRIGGER `cancellaCompetizioni` AFTER INSERT ON `Competizione` FOR EACH ROW BEGIN
  DECLARE numCompetizioni INT DEFAULT 0;
  SELECT COUNT(*) INTO numCompetizioni FROM Competizione
  WHERE IDStruttura = NEW.IDStruttura AND Data = NEW.Data AND IDCompetizione <> NEW.IDCompetizione;

  IF numCompetizioni > 0 THEN
    DELETE FROM Competizione WHERE IDCompetizione = NEW.IDCompetizione;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Gara`
--

CREATE TABLE `Gara` (
  `IDGara` int(20) NOT NULL,
  `IDCompetizione` int(20) NOT NULL,
  `IDTipologia` int(20) NOT NULL,
  `IDCategoria` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Gara`
--

INSERT INTO `Gara` (`IDGara`, `IDCompetizione`, `IDTipologia`, `IDCategoria`) VALUES
(3, 1, 1, 2),
(4, 1, 4, 6),
(5, 2, 3, 4),
(6, 3, 5, 6),
(7, 4, 4, 7),
(8, 3, 5, 8),
(9, 5, 2, 4),
(10, 3, 5, 6),
(11, 5, 3, 8),
(12, 6, 6, 4),
(13, 1, 2, 6),
(14, 6, 4, 3),
(15, 4, 1, 8);

-- --------------------------------------------------------

--
-- Table structure for table `GiudicaGara`
--

CREATE TABLE `GiudicaGara` (
  `IDGiudice` varchar(16) NOT NULL,
  `IDGara` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `GiudicaGara`
--

INSERT INTO `GiudicaGara` (`IDGiudice`, `IDGara`) VALUES
('DHYPGB66H08E707I', 4),
('DHYPGB66H08E707I', 14),
('SPSPNQ37M22G616K', 5),
('SPSPNQ37M22G616K', 12);

-- --------------------------------------------------------

--
-- Table structure for table `Giudice`
--

CREATE TABLE `Giudice` (
  `IDGiudice` varchar(16) NOT NULL,
  `Organizzazione` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Giudice`
--

INSERT INTO `Giudice` (`IDGiudice`, `Organizzazione`) VALUES
('DHYPGB66H08E707I', 'Burningate'),
('SPSPNQ37M22G616K', 'Movimento Calisthenics');

--
-- Triggers `Giudice`
--
DELIMITER $$
CREATE TRIGGER `verificaAllenatore` BEFORE INSERT ON `Giudice` FOR EACH ROW BEGIN
   DECLARE Allenatore INT;
   
   SELECT COUNT(*) INTO Allenatore
   FROM Allenatore
   WHERE IDAllenatore = NEW.IDGiudice;
   
   IF Allenatore > 0 THEN
      DELETE FROM Giudice
      WHERE IDGiudice = NEW.IDGiudice;
   END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Organizza`
--

CREATE TABLE `Organizza` (
  `IDOrganizzatore` varchar(16) NOT NULL,
  `IDCompetizione` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Organizza`
--

INSERT INTO `Organizza` (`IDOrganizzatore`, `IDCompetizione`) VALUES
('NDSHHS58A54D218L', 5),
('PNFSCH55P28B739N', 2),
('PNFSCH55P28B739N', 5),
('PNFSCH55P28B739N', 6);

-- --------------------------------------------------------

--
-- Table structure for table `OrganizzatoreEvento`
--

CREATE TABLE `OrganizzatoreEvento` (
  `IDOrganizzatore` varchar(16) NOT NULL,
  `Associazione` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `OrganizzatoreEvento`
--

INSERT INTO `OrganizzatoreEvento` (`IDOrganizzatore`, `Associazione`) VALUES
('NDSHHS58A54D218L', 'FIC'),
('PNFSCH55P28B739N', 'FIC');

-- --------------------------------------------------------

--
-- Table structure for table `Persona`
--

CREATE TABLE `Persona` (
  `CF` varchar(16) NOT NULL,
  `Nome` varchar(20) NOT NULL,
  `Cognome` varchar(20) NOT NULL,
  `Telefono` varchar(15) NOT NULL,
  `Residenza` varchar(40) NOT NULL,
  `CAP` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Persona`
--

INSERT INTO `Persona` (`CF`, `Nome`, `Cognome`, `Telefono`, `Residenza`, `CAP`) VALUES
('CDHVSM36H68D279F', 'Riccardo', 'Catania', '6372921977', 'Contrada Marini 95', 16249),
('DHYPGB66H08E707I', 'Samuele', 'Calanna', '4395538665', 'Via Davide 911', 58320),
('DXDFGD68L17F398P', 'Tino', 'Scardaci', '4631160981', 'Borgo Giacinta 142', 23569),
('FMPCVD63A29L384Q', 'Martina', 'Rodriguez', '3184263748', 'Rotonda Neri 189', 56289),
('GFQPDR63A59G459V', 'Valerio', 'Abbruscato', '3978223027', 'Rotonda Rizzi 77', 84769),
('GHBVBV46P22L217T', 'Francesca', 'Sapienza', '0432772808', 'Strada Lazzaro 838', 13222),
('HFLPCL63C62L673B', 'Raffaele', 'Cinquegrani', '5365555599', 'Piazza Loredana 782', 23757),
('HHTZCD57D61L554M', 'Rossana', 'Fourier', '2915230551', 'Via Armellina 24', 24704),
('JRMFZC69T06L537B', 'Patrizio', 'Pepe', '8871907941', 'Strada Ercole 025', 78000),
('LBHDRX82D44E892E', 'Giuseppe', 'Blanco', '8085202794', 'Via Orlando 444 Piano 4', 43218),
('NDSHHS58A54D218L', 'Marco', 'Pulvirenti', '0491671103', 'Via Amos 9', 46897),
('NRQLPB51D02Z600V', 'Gianluca', 'Di Stefano', '6287796171', 'Contrada Alan 11', 85200),
('NVOYDS94R15G536D', 'Alessandro', 'La Rosa', '6666545217', 'Strada Rocco 507 Piano 4', 75230),
('PNFSCH55P28B739N', 'Salvatore', 'Coglitoro', '0628839159', 'Strada Marieva 3', 27836),
('PRVBCL46S52G382G', 'Federico', 'Finocchiaro', '2023408146', 'Contrada Esposito 999', 12345),
('PZTYCZ72P16E468Q', 'Chiara', 'Arrivabene', '2104618368', 'Incrocio Barbieri 9', 74163),
('RVRDFB70R08I381R', 'Maya', 'Silva', '3673069696', 'Incrocio Galli 1 Piano 2', 12500),
('SPSPNQ37M22G616K', 'Teo', 'Ravenna', '4691886957', 'Contrada Ione 780', 55851),
('WQKJTF77A69B869L', 'Emanuele', 'Majeli', '3771314891', 'Rotonda Marina 279', 95012),
('YFGDYB83M08L696Z', 'Luca', 'Camiola', '4526352197', 'Via Grazia 8', 48216);

-- --------------------------------------------------------

--
-- Table structure for table `Posizionamento`
--

CREATE TABLE `Posizionamento` (
  `IDGara` int(20) NOT NULL,
  `IDAtleta` varchar(16) NOT NULL,
  `Posizione` int(5) NOT NULL,
  `Punteggio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Posizionamento`
--

INSERT INTO `Posizionamento` (`IDGara`, `IDAtleta`, `Posizione`, `Punteggio`) VALUES
(3, 'WQKJTF77A69B869L', 2, 12.8),
(4, 'FMPCVD63A29L384Q', 1, 27.9),
(5, 'NVOYDS94R15G536D', 6, 35.9),
(5, 'WQKJTF77A69B869L', 1, 52.7),
(6, 'LBHDRX82D44E892E', 8, 24),
(8, 'NVOYDS94R15G536D', 1, 59.1),
(9, 'RVRDFB70R08I381R', 5, 44.5),
(10, 'NRQLPB51D02Z600V', 6, 56.3),
(11, 'LBHDRX82D44E892E', 4, 38),
(14, 'FMPCVD63A29L384Q', 2, 27),
(14, 'RVRDFB70R08I381R', 1, 34.9),
(15, 'WQKJTF77A69B869L', 1, 60.9);

--
-- Triggers `Posizionamento`
--
DELIMITER $$
CREATE TRIGGER `eliminaAtletaPosizionamento` AFTER INSERT ON `Posizionamento` FOR EACH ROW BEGIN
   DECLARE numAtleti INT;
   
   SELECT COUNT(*) INTO numAtleti
   FROM Posizionamento
   WHERE IDGara = NEW.IDGara AND posizione = NEW.posizione AND IDAtleta <> NEW.IDAtleta;
   
   IF numAtleti > 0 THEN
      DELETE FROM Posizionamento
      WHERE IDGara = NEW.IDGara AND posizione = NEW.posizione AND IDAtleta = NEW.IDAtleta;
   END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `erratoPosizionamento` AFTER INSERT ON `Posizionamento` FOR EACH ROW BEGIN
    DECLARE genereAtleta VARCHAR(5) DEFAULT '';
    DECLARE genereTipologia VARCHAR(5) DEFAULT '';
    SELECT Genere INTO genereAtleta
    FROM Atleta
    WHERE IDAtleta = NEW.IDAtleta;
    
    SELECT TipologiaGara.Genere INTO genereTipologia
    FROM TipologiaGara, Gara
    WHERE TipologiaGara.IDTipologia = Gara.IDTipologia
    AND Gara.IDGara = NEW.IDGara;

    IF genereAtleta <> genereTipologia THEN
        DELETE FROM Posizionamento
        WHERE IDGara = NEW.IDGara AND IDAtleta = NEW.IDAtleta;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Regolamento`
--

CREATE TABLE `Regolamento` (
  `IDTipologia` int(20) NOT NULL,
  `IDCategoria` int(20) NOT NULL,
  `annoRegolamento` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Regolamento`
--

INSERT INTO `Regolamento` (`IDTipologia`, `IDCategoria`, `annoRegolamento`) VALUES
(1, 6, 2020),
(2, 1, 2019),
(3, 5, 2017),
(3, 5, 2018),
(3, 5, 2019),
(3, 5, 2021),
(3, 5, 2022),
(4, 6, 2020),
(5, 9, 2021),
(6, 9, 2019);

--
-- Triggers `Regolamento`
--
DELIMITER $$
CREATE TRIGGER `limitRegolamenti` AFTER INSERT ON `Regolamento` FOR EACH ROW BEGIN
   DECLARE numRegolamenti INT;
   
   SELECT COUNT(*) INTO numRegolamenti
   FROM Regolamento
   WHERE IDCategoria = NEW.IDCategoria AND IDTipologia = NEW.IDTipologia;
   
   IF numRegolamenti >= 5 THEN
      DELETE FROM Regolamento
      WHERE IDCategoria = NEW.IDCategoria AND IDTipologia = NEW.IDTipologia AND annoRegolamento <> NEW.annoRegolamento
      ORDER BY annoRegolamento ASC
      LIMIT 1;
   END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `SpettaCompetizione`
--

CREATE TABLE `SpettaCompetizione` (
  `IDSpettatore` varchar(16) NOT NULL,
  `IDCompetizione` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `SpettaCompetizione`
--

INSERT INTO `SpettaCompetizione` (`IDSpettatore`, `IDCompetizione`) VALUES
('CDHVSM36H68D279F', 1),
('GFQPDR63A59G459V', 1),
('GFQPDR63A59G459V', 3),
('GHBVBV46P22L217T', 1),
('GHBVBV46P22L217T', 5),
('HFLPCL63C62L673B', 4),
('HHTZCD57D61L554M', 4),
('PZTYCZ72P16E468Q', 6),
('YFGDYB83M08L696Z', 1),
('YFGDYB83M08L696Z', 5);

--
-- Triggers `SpettaCompetizione`
--
DELIMITER $$
CREATE TRIGGER `inserimentoSpettatore` AFTER INSERT ON `SpettaCompetizione` FOR EACH ROW BEGIN
   UPDATE Competizione
   SET numeroSpettatori = numeroSpettatori + 1
   WHERE IDCompetizione = NEW.IDCompetizione;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Spettatore`
--

CREATE TABLE `Spettatore` (
  `IDSpettatore` varchar(16) NOT NULL,
  `dataDiNascita` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Spettatore`
--

INSERT INTO `Spettatore` (`IDSpettatore`, `dataDiNascita`) VALUES
('CDHVSM36H68D279F', '2003-01-02'),
('GFQPDR63A59G459V', '1992-09-15'),
('GHBVBV46P22L217T', '1987-01-16'),
('HFLPCL63C62L673B', '2008-06-20'),
('HHTZCD57D61L554M', '2006-07-06'),
('PZTYCZ72P16E468Q', '1985-11-14'),
('YFGDYB83M08L696Z', '2005-04-14');

-- --------------------------------------------------------

--
-- Table structure for table `Struttura`
--

CREATE TABLE `Struttura` (
  `IDStruttura` int(20) NOT NULL,
  `Nome` varchar(30) NOT NULL,
  `Luogo` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Struttura`
--

INSERT INTO `Struttura` (`IDStruttura`, `Nome`, `Luogo`) VALUES
(1, 'Fitness And Fight', 'Acireale'),
(2, 'Stefano\'s gym', 'Acitrezza'),
(3, 'Tiger Club', 'Lamezia Terme'),
(4, 'Fitness World', 'Monte Sacro'),
(5, 'Athlon', 'San Gregorio'),
(6, 'Virgin', 'Cannizzaro');

-- --------------------------------------------------------

--
-- Table structure for table `TipologiaGara`
--

CREATE TABLE `TipologiaGara` (
  `IDTipologia` int(20) NOT NULL,
  `Genere` varchar(5) NOT NULL,
  `nomeTipologia` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `TipologiaGara`
--

INSERT INTO `TipologiaGara` (`IDTipologia`, `Genere`, `nomeTipologia`) VALUES
(1, 'M', 'Skills'),
(2, 'F', 'Skills'),
(3, 'M', 'Endurance'),
(4, 'F', 'Endurance'),
(5, 'M', 'Strength'),
(6, 'F', 'Strength');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Allenatore`
--
ALTER TABLE `Allenatore`
  ADD PRIMARY KEY (`IDAllenatore`) USING BTREE;

--
-- Indexes for table `Atleta`
--
ALTER TABLE `Atleta`
  ADD PRIMARY KEY (`IDAtleta`),
  ADD KEY `test1002` (`IDAllenatore`);

--
-- Indexes for table `Categoria`
--
ALTER TABLE `Categoria`
  ADD PRIMARY KEY (`IDCategoria`);

--
-- Indexes for table `CategoriaAppartenenza`
--
ALTER TABLE `CategoriaAppartenenza`
  ADD PRIMARY KEY (`IDCategoria`,`IDAtleta`),
  ADD KEY `testtt1` (`IDAtleta`);

--
-- Indexes for table `Competizione`
--
ALTER TABLE `Competizione`
  ADD PRIMARY KEY (`IDCompetizione`),
  ADD KEY `test` (`IDStruttura`);

--
-- Indexes for table `Gara`
--
ALTER TABLE `Gara`
  ADD PRIMARY KEY (`IDGara`),
  ADD KEY `testt1` (`IDCategoria`),
  ADD KEY `testt2` (`IDCompetizione`),
  ADD KEY `testt3` (`IDTipologia`);

--
-- Indexes for table `GiudicaGara`
--
ALTER TABLE `GiudicaGara`
  ADD PRIMARY KEY (`IDGiudice`,`IDGara`),
  ADD KEY `fk2` (`IDGara`);

--
-- Indexes for table `Giudice`
--
ALTER TABLE `Giudice`
  ADD PRIMARY KEY (`IDGiudice`) USING BTREE;

--
-- Indexes for table `Organizza`
--
ALTER TABLE `Organizza`
  ADD PRIMARY KEY (`IDOrganizzatore`,`IDCompetizione`),
  ADD KEY `fkcomp` (`IDCompetizione`);

--
-- Indexes for table `OrganizzatoreEvento`
--
ALTER TABLE `OrganizzatoreEvento`
  ADD PRIMARY KEY (`IDOrganizzatore`);

--
-- Indexes for table `Persona`
--
ALTER TABLE `Persona`
  ADD PRIMARY KEY (`CF`);

--
-- Indexes for table `Posizionamento`
--
ALTER TABLE `Posizionamento`
  ADD PRIMARY KEY (`IDGara`,`IDAtleta`),
  ADD KEY `t1` (`IDAtleta`);

--
-- Indexes for table `Regolamento`
--
ALTER TABLE `Regolamento`
  ADD PRIMARY KEY (`IDTipologia`,`IDCategoria`,`annoRegolamento`),
  ADD KEY `t11` (`IDCategoria`);

--
-- Indexes for table `SpettaCompetizione`
--
ALTER TABLE `SpettaCompetizione`
  ADD PRIMARY KEY (`IDSpettatore`,`IDCompetizione`),
  ADD KEY `fkcompetition` (`IDCompetizione`);

--
-- Indexes for table `Spettatore`
--
ALTER TABLE `Spettatore`
  ADD PRIMARY KEY (`IDSpettatore`);

--
-- Indexes for table `Struttura`
--
ALTER TABLE `Struttura`
  ADD PRIMARY KEY (`IDStruttura`);

--
-- Indexes for table `TipologiaGara`
--
ALTER TABLE `TipologiaGara`
  ADD PRIMARY KEY (`IDTipologia`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Categoria`
--
ALTER TABLE `Categoria`
  MODIFY `IDCategoria` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `Competizione`
--
ALTER TABLE `Competizione`
  MODIFY `IDCompetizione` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `Gara`
--
ALTER TABLE `Gara`
  MODIFY `IDGara` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `Struttura`
--
ALTER TABLE `Struttura`
  MODIFY `IDStruttura` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `TipologiaGara`
--
ALTER TABLE `TipologiaGara`
  MODIFY `IDTipologia` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Allenatore`
--
ALTER TABLE `Allenatore`
  ADD CONSTRAINT `Allenatore_ibfk_1` FOREIGN KEY (`IDAllenatore`) REFERENCES `Persona` (`CF`);

--
-- Constraints for table `Atleta`
--
ALTER TABLE `Atleta`
  ADD CONSTRAINT `test1002` FOREIGN KEY (`IDAllenatore`) REFERENCES `Allenatore` (`IDAllenatore`),
  ADD CONSTRAINT `test101` FOREIGN KEY (`IDAtleta`) REFERENCES `Persona` (`CF`);

--
-- Constraints for table `CategoriaAppartenenza`
--
ALTER TABLE `CategoriaAppartenenza`
  ADD CONSTRAINT `testtt1` FOREIGN KEY (`IDAtleta`) REFERENCES `Atleta` (`IDAtleta`),
  ADD CONSTRAINT `testtt2` FOREIGN KEY (`IDCategoria`) REFERENCES `Categoria` (`IDCategoria`);

--
-- Constraints for table `Competizione`
--
ALTER TABLE `Competizione`
  ADD CONSTRAINT `test` FOREIGN KEY (`IDStruttura`) REFERENCES `Struttura` (`IDStruttura`);

--
-- Constraints for table `Gara`
--
ALTER TABLE `Gara`
  ADD CONSTRAINT `testt1` FOREIGN KEY (`IDCategoria`) REFERENCES `Categoria` (`IDCategoria`),
  ADD CONSTRAINT `testt2` FOREIGN KEY (`IDCompetizione`) REFERENCES `Competizione` (`IDCompetizione`),
  ADD CONSTRAINT `testt3` FOREIGN KEY (`IDTipologia`) REFERENCES `TipologiaGara` (`IDTipologia`);

--
-- Constraints for table `GiudicaGara`
--
ALTER TABLE `GiudicaGara`
  ADD CONSTRAINT `fk1` FOREIGN KEY (`IDGiudice`) REFERENCES `Giudice` (`IDGiudice`),
  ADD CONSTRAINT `fk2` FOREIGN KEY (`IDGara`) REFERENCES `Gara` (`IDGara`);

--
-- Constraints for table `Giudice`
--
ALTER TABLE `Giudice`
  ADD CONSTRAINT `tt1` FOREIGN KEY (`IDGiudice`) REFERENCES `Persona` (`CF`);

--
-- Constraints for table `Organizza`
--
ALTER TABLE `Organizza`
  ADD CONSTRAINT `fkcomp` FOREIGN KEY (`IDCompetizione`) REFERENCES `Competizione` (`IDCompetizione`),
  ADD CONSTRAINT `fkorg` FOREIGN KEY (`IDOrganizzatore`) REFERENCES `OrganizzatoreEvento` (`IDOrganizzatore`);

--
-- Constraints for table `OrganizzatoreEvento`
--
ALTER TABLE `OrganizzatoreEvento`
  ADD CONSTRAINT `foreign_cf` FOREIGN KEY (`IDOrganizzatore`) REFERENCES `Persona` (`CF`);

--
-- Constraints for table `Posizionamento`
--
ALTER TABLE `Posizionamento`
  ADD CONSTRAINT `t1` FOREIGN KEY (`IDAtleta`) REFERENCES `Atleta` (`IDAtleta`),
  ADD CONSTRAINT `t2` FOREIGN KEY (`IDGara`) REFERENCES `Gara` (`IDGara`);

--
-- Constraints for table `Regolamento`
--
ALTER TABLE `Regolamento`
  ADD CONSTRAINT `t11` FOREIGN KEY (`IDCategoria`) REFERENCES `Categoria` (`IDCategoria`),
  ADD CONSTRAINT `t22` FOREIGN KEY (`IDTipologia`) REFERENCES `TipologiaGara` (`IDTipologia`);

--
-- Constraints for table `SpettaCompetizione`
--
ALTER TABLE `SpettaCompetizione`
  ADD CONSTRAINT `fkcompetition` FOREIGN KEY (`IDCompetizione`) REFERENCES `Competizione` (`IDCompetizione`),
  ADD CONSTRAINT `fkspet` FOREIGN KEY (`IDSpettatore`) REFERENCES `Spettatore` (`IDSpettatore`);

--
-- Constraints for table `Spettatore`
--
ALTER TABLE `Spettatore`
  ADD CONSTRAINT `fk_cf` FOREIGN KEY (`IDSpettatore`) REFERENCES `Persona` (`CF`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
