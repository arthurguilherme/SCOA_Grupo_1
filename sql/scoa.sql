-- MySQL dump 10.13  Distrib 5.7.26, for Linux (x86_64)
--
-- Host: localhost    Database: scoa
-- ------------------------------------------------------
-- Server version	5.7.26-0ubuntu0.18.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aluno`
--

DROP TABLE IF EXISTS `aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno` (
  `matricula` int(11) NOT NULL AUTO_INCREMENT,
  `cpf` char(11) NOT NULL,
  `curso` char(2) NOT NULL,
  PRIMARY KEY (`matricula`),
  KEY `aluno_FK` (`cpf`),
  CONSTRAINT `aluno_FK` FOREIGN KEY (`cpf`) REFERENCES `pessoa` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluno`
--

LOCK TABLES `aluno` WRITE;
/*!40000 ALTER TABLE `aluno` DISABLE KEYS */;
/*!40000 ALTER TABLE `aluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aluno_turma`
--

DROP TABLE IF EXISTS `aluno_turma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno_turma` (
  `cod_turma` int(11) NOT NULL,
  `matricula_aluno` int(11) NOT NULL,
  `faltas` int(11) NOT NULL DEFAULT '0',
  `grau` int(11) DEFAULT '0',
  `situacao` char(2) DEFAULT NULL,
  PRIMARY KEY (`cod_turma`,`matricula_aluno`),
  KEY `presenca_FK_1` (`matricula_aluno`),
  CONSTRAINT `presenca_FK` FOREIGN KEY (`cod_turma`) REFERENCES `turma` (`codigo`),
  CONSTRAINT `presenca_FK_1` FOREIGN KEY (`matricula_aluno`) REFERENCES `aluno` (`matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluno_turma`
--

LOCK TABLES `aluno_turma` WRITE;
/*!40000 ALTER TABLE `aluno_turma` DISABLE KEYS */;
/*!40000 ALTER TABLE `aluno_turma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliacao`
--

DROP TABLE IF EXISTS `avaliacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avaliacao` (
  `codigo` varchar(2) NOT NULL,
  `cod_turma` int(11) NOT NULL,
  PRIMARY KEY (`codigo`,`cod_turma`),
  KEY `avaliacao_FK` (`cod_turma`),
  CONSTRAINT `avaliacao_FK` FOREIGN KEY (`cod_turma`) REFERENCES `turma` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacao`
--

LOCK TABLES `avaliacao` WRITE;
/*!40000 ALTER TABLE `avaliacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disciplina`
--

DROP TABLE IF EXISTS `disciplina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disciplina` (
  `codigo` char(6) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `carga` int(11) NOT NULL,
  `curso` char(2) NOT NULL,
  `periodo` int(11) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disciplina`
--

LOCK TABLES `disciplina` WRITE;
/*!40000 ALTER TABLE `disciplina` DISABLE KEYS */;
/*!40000 ALTER TABLE `disciplina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `espera`
--

DROP TABLE IF EXISTS `espera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `espera` (
  `cod_turma` int(11) NOT NULL,
  `cod_disciplina` char(6) NOT NULL,
  `matricula` int(11) NOT NULL,
  PRIMARY KEY (`cod_turma`,`cod_disciplina`,`matricula`),
  KEY `espera_FK` (`matricula`),
  KEY `espera_FK_1` (`cod_disciplina`),
  CONSTRAINT `espera_FK` FOREIGN KEY (`matricula`) REFERENCES `aluno` (`matricula`),
  CONSTRAINT `espera_FK_1` FOREIGN KEY (`cod_disciplina`) REFERENCES `disciplina` (`codigo`),
  CONSTRAINT `espera_FK_2` FOREIGN KEY (`cod_turma`) REFERENCES `turma` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `espera`
--

LOCK TABLES `espera` WRITE;
/*!40000 ALTER TABLE `espera` DISABLE KEYS */;
/*!40000 ALTER TABLE `espera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_disciplina`
--

DROP TABLE IF EXISTS `historico_disciplina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historico_disciplina` (
  `matricula` int(11) NOT NULL,
  `cod_disciplina` char(6) NOT NULL,
  `presenca` int(11) NOT NULL,
  `grau` int(11) NOT NULL,
  PRIMARY KEY (`matricula`,`cod_disciplina`),
  KEY `historico_disciplina_FK_1` (`cod_disciplina`),
  CONSTRAINT `historico_disciplina_FK` FOREIGN KEY (`matricula`) REFERENCES `aluno` (`matricula`),
  CONSTRAINT `historico_disciplina_FK_1` FOREIGN KEY (`cod_disciplina`) REFERENCES `disciplina` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_disciplina`
--

LOCK TABLES `historico_disciplina` WRITE;
/*!40000 ALTER TABLE `historico_disciplina` DISABLE KEYS */;
/*!40000 ALTER TABLE `historico_disciplina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nota_avaliacao`
--

DROP TABLE IF EXISTS `nota_avaliacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nota_avaliacao` (
  `cod_avaliacao` varchar(2) NOT NULL,
  `cod_turma` int(11) NOT NULL,
  `matricula` int(11) NOT NULL,
  `nota` int(11) NOT NULL,
  PRIMARY KEY (`cod_avaliacao`,`cod_turma`,`matricula`),
  KEY `nota_avaliacao_FK` (`matricula`),
  CONSTRAINT `nota_avaliacao_FK` FOREIGN KEY (`matricula`) REFERENCES `aluno` (`matricula`),
  CONSTRAINT `nota_avaliacao_FK_1` FOREIGN KEY (`cod_avaliacao`, `cod_turma`) REFERENCES `avaliacao` (`codigo`, `cod_turma`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nota_avaliacao`
--

LOCK TABLES `nota_avaliacao` WRITE;
/*!40000 ALTER TABLE `nota_avaliacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `nota_avaliacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pessoa` (
  `cpf` char(11) NOT NULL,
  `rg` varchar(15) NOT NULL,
  `nome` varchar(200) NOT NULL,
  PRIMARY KEY (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `professor` (
  `cpf` char(11) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `matricula` int(11) NOT NULL,
  PRIMARY KEY (`matricula`),
  KEY `professor_FK` (`cpf`),
  CONSTRAINT `professor_FK` FOREIGN KEY (`cpf`) REFERENCES `pessoa` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requisitos`
--

DROP TABLE IF EXISTS `requisitos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requisitos` (
  `codigo` char(6) NOT NULL,
  `requisito` char(6) NOT NULL,
  `tipo` char(1) NOT NULL,
  PRIMARY KEY (`codigo`,`requisito`),
  CONSTRAINT `requisitos_FK` FOREIGN KEY (`codigo`) REFERENCES `disciplina` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requisitos`
--

LOCK TABLES `requisitos` WRITE;
/*!40000 ALTER TABLE `requisitos` DISABLE KEYS */;
/*!40000 ALTER TABLE `requisitos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sala`
--

DROP TABLE IF EXISTS `sala`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sala` (
  `codigo` varchar(10) NOT NULL,
  `campus` char(2) NOT NULL,
  `instituto` char(3) NOT NULL,
  `capacidade` int(11) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sala`
--

LOCK TABLES `sala` WRITE;
/*!40000 ALTER TABLE `sala` DISABLE KEYS */;
/*!40000 ALTER TABLE `sala` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefone`
--

DROP TABLE IF EXISTS `telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telefone` (
  `cpf` char(11) NOT NULL,
  `tel` varchar(11) NOT NULL,
  PRIMARY KEY (`cpf`,`tel`),
  CONSTRAINT `telefone_FK` FOREIGN KEY (`cpf`) REFERENCES `pessoa` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefone`
--

LOCK TABLES `telefone` WRITE;
/*!40000 ALTER TABLE `telefone` DISABLE KEYS */;
/*!40000 ALTER TABLE `telefone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turma`
--

DROP TABLE IF EXISTS `turma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turma` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `cod_disciplina` char(6) NOT NULL,
  `vagas` int(11) NOT NULL,
  `matricula_professor` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `turma_FK` (`cod_disciplina`),
  KEY `turma_FK_1` (`matricula_professor`),
  CONSTRAINT `turma_FK` FOREIGN KEY (`cod_disciplina`) REFERENCES `disciplina` (`codigo`),
  CONSTRAINT `turma_FK_1` FOREIGN KEY (`matricula_professor`) REFERENCES `professor` (`matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turma`
--

LOCK TABLES `turma` WRITE;
/*!40000 ALTER TABLE `turma` DISABLE KEYS */;
/*!40000 ALTER TABLE `turma` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turma_sala_horario`
--

DROP TABLE IF EXISTS `turma_sala_horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `turma_sala_horario` (
  `codigo_sala` varchar(10) NOT NULL,
  `codigo_turma` int(11) NOT NULL,
  `horario` int(11) NOT NULL,
  `dia` varchar(3) NOT NULL,
  PRIMARY KEY (`horario`,`dia`),
  KEY `turma_sala_horario_FK` (`codigo_sala`),
  KEY `turma_sala_horario_FK_1` (`codigo_turma`),
  CONSTRAINT `turma_sala_horario_FK` FOREIGN KEY (`codigo_sala`) REFERENCES `sala` (`codigo`),
  CONSTRAINT `turma_sala_horario_FK_1` FOREIGN KEY (`codigo_turma`) REFERENCES `turma` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turma_sala_horario`
--

LOCK TABLES `turma_sala_horario` WRITE;
/*!40000 ALTER TABLE `turma_sala_horario` DISABLE KEYS */;
/*!40000 ALTER TABLE `turma_sala_horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'scoa'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-23  9:24:25
