-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: scoa
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.19.04.1

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
  `cpf_pessoa` char(11) NOT NULL,
  `curso` char(2) NOT NULL,
  PRIMARY KEY (`matricula`),
  KEY `aluno_FK` (`cpf_pessoa`),
  KEY `fk_aluno_1_idx` (`curso`),
  CONSTRAINT `aluno_FK` FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoa` (`cpf`),
  CONSTRAINT `fk_aluno_1` FOREIGN KEY (`curso`) REFERENCES `curso` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluno`
--

LOCK TABLES `aluno` WRITE;
/*!40000 ALTER TABLE `aluno` DISABLE KEYS */;
INSERT INTO `aluno` VALUES (1,'22157353452','CC'),(2,'22227705021','CC'),(3,'22583770420','CC'),(4,'23132556262','CC'),(5,'24196693921','CC'),(6,'24823873696','CC'),(7,'24897310220','CC'),(8,'25092631743','CC'),(9,'25188399727','CC'),(10,'25256691169','CC'),(11,'25929183554','CC'),(12,'26737969658','CC'),(13,'27593223502','CC'),(14,'28063163575','CC'),(15,'28103375807','CC'),(16,'19181818181','CC');
/*!40000 ALTER TABLE `aluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aluno_turma`
--

DROP TABLE IF EXISTS `aluno_turma`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluno_turma` (
  `codigo_turma` int(11) NOT NULL,
  `matricula_aluno` int(11) NOT NULL,
  `faltas` int(11) NOT NULL DEFAULT '0',
  `grau` int(11) DEFAULT '0',
  `situacao` char(2) DEFAULT NULL,
  PRIMARY KEY (`codigo_turma`,`matricula_aluno`),
  KEY `presenca_FK_1` (`matricula_aluno`),
  CONSTRAINT `presenca_FK` FOREIGN KEY (`codigo_turma`) REFERENCES `turma` (`codigo`),
  CONSTRAINT `presenca_FK_1` FOREIGN KEY (`matricula_aluno`) REFERENCES `aluno` (`matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluno_turma`
--

LOCK TABLES `aluno_turma` WRITE;
/*!40000 ALTER TABLE `aluno_turma` DISABLE KEYS */;
INSERT INTO `aluno_turma` VALUES (1,1,5,65,'AP'),(1,3,0,0,NULL),(1,6,0,0,NULL),(1,7,0,0,NULL),(1,8,0,0,NULL);
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
  `codigo_turma` int(11) NOT NULL,
  PRIMARY KEY (`codigo`,`codigo_turma`),
  KEY `avaliacao_FK` (`codigo_turma`),
  CONSTRAINT `avaliacao_FK` FOREIGN KEY (`codigo_turma`) REFERENCES `turma` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacao`
--

LOCK TABLES `avaliacao` WRITE;
/*!40000 ALTER TABLE `avaliacao` DISABLE KEYS */;
INSERT INTO `avaliacao` VALUES ('P1',1);
/*!40000 ALTER TABLE `avaliacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curso` (
  `codigo` char(2) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES ('CC'),('EC');
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
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
  `codigo_curso` char(2) NOT NULL,
  `periodo` int(11) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_disciplina_1_idx` (`codigo_curso`),
  CONSTRAINT `fk_disciplina_1` FOREIGN KEY (`codigo_curso`) REFERENCES `curso` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disciplina`
--

LOCK TABLES `disciplina` WRITE;
/*!40000 ALTER TABLE `disciplina` DISABLE KEYS */;
INSERT INTO `disciplina` VALUES ('CC0001','TEORIA DOS NUMEROS',90,'CC',1),('CC0002','CALCULO 1',90,'CC',1),('CC0003','TEORIA GERAL DA COMPUTACAO',90,'CC',2),('CC0004','TEORIA DOS GRAFOS',90,'CC',2);
/*!40000 ALTER TABLE `disciplina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `espera`
--

DROP TABLE IF EXISTS `espera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `espera` (
  `codigo_turma` int(11) NOT NULL,
  `matricula_aluno` int(11) NOT NULL,
  PRIMARY KEY (`codigo_turma`,`matricula_aluno`),
  KEY `espera_FK` (`matricula_aluno`),
  CONSTRAINT `espera_FK` FOREIGN KEY (`matricula_aluno`) REFERENCES `aluno` (`matricula`),
  CONSTRAINT `espera_FK_2` FOREIGN KEY (`codigo_turma`) REFERENCES `turma` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `espera`
--

LOCK TABLES `espera` WRITE;
/*!40000 ALTER TABLE `espera` DISABLE KEYS */;
INSERT INTO `espera` VALUES (1,2),(1,10),(1,15);
/*!40000 ALTER TABLE `espera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico_disciplina`
--

DROP TABLE IF EXISTS `historico_disciplina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historico_disciplina` (
  `matricula_aluno` int(11) NOT NULL,
  `codigo_disciplina` char(6) NOT NULL,
  `presenca` float NOT NULL,
  `grau` int(11) NOT NULL,
  PRIMARY KEY (`matricula_aluno`,`codigo_disciplina`),
  KEY `historico_disciplina_FK_1` (`codigo_disciplina`),
  CONSTRAINT `historico_disciplina_FK` FOREIGN KEY (`matricula_aluno`) REFERENCES `aluno` (`matricula`),
  CONSTRAINT `historico_disciplina_FK_1` FOREIGN KEY (`codigo_disciplina`) REFERENCES `disciplina` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico_disciplina`
--

LOCK TABLES `historico_disciplina` WRITE;
/*!40000 ALTER TABLE `historico_disciplina` DISABLE KEYS */;
INSERT INTO `historico_disciplina` VALUES (1,'CC0001',0.8,65);
/*!40000 ALTER TABLE `historico_disciplina` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nota_avaliacao`
--

DROP TABLE IF EXISTS `nota_avaliacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nota_avaliacao` (
  `codigo_avaliacao` varchar(2) NOT NULL,
  `codigo_turma` int(11) NOT NULL,
  `matricula_aluno` int(11) NOT NULL,
  `nota` int(11) NOT NULL,
  PRIMARY KEY (`codigo_avaliacao`,`codigo_turma`,`matricula_aluno`),
  KEY `nota_avaliacao_FK` (`matricula_aluno`),
  CONSTRAINT `nota_avaliacao_FK` FOREIGN KEY (`matricula_aluno`) REFERENCES `aluno` (`matricula`),
  CONSTRAINT `nota_avaliacao_FK_1` FOREIGN KEY (`codigo_avaliacao`, `codigo_turma`) REFERENCES `avaliacao` (`codigo`, `codigo_turma`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nota_avaliacao`
--

LOCK TABLES `nota_avaliacao` WRITE;
/*!40000 ALTER TABLE `nota_avaliacao` DISABLE KEYS */;
INSERT INTO `nota_avaliacao` VALUES ('P1',1,1,75);
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
  `login` varchar(45) DEFAULT NULL,
  `senha` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE KEY `login_UNIQUE` (`login`),
  UNIQUE KEY `senha_UNIQUE` (`senha`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES ('12074098777','560665988758102','Camren',NULL,NULL),('12263212932','212398437760873','Richmond',NULL,NULL),('12377553101','438099690590881','Issac',NULL,NULL),('12815545913','435230492393796','Noah',NULL,NULL),('14127583263','590014817620524','Modesta',NULL,NULL),('14146246843','580495932198957','Scarlett',NULL,NULL),('14701686344','907946350001730','Jamil',NULL,NULL),('14721922948','587798522360002','Andrew',NULL,NULL),('15027945405','835112123488345','Bridie',NULL,NULL),('17169596420','115570661157059','Pat',NULL,NULL),('17787407131','557493880024800','Thad',NULL,NULL),('19072102258','184124888066305','Lelah',NULL,NULL),('19181818181','292929292','Fulano da Silva',NULL,NULL),('19184512562','171155182020738','Bartholome',NULL,NULL),('19563652450','118790353644742','Vidal',NULL,NULL),('19751383943','50338623051324','Grover',NULL,NULL),('20083994335','902373463895896','Arnaldo',NULL,NULL),('20155217001','275311611262667','Clovis',NULL,NULL),('20395362335','414569578238555','Corrine',NULL,NULL),('20820724922','797598677023520','Camryn',NULL,NULL),('22157353452','634133267262433','Brandyn',NULL,NULL),('22227705021','966778935734700','Shirley',NULL,NULL),('22583770420','12716516649039','Courtney',NULL,NULL),('23132556262','478206392828788','Wendy',NULL,NULL),('24196693921','788270408031530','Branson',NULL,NULL),('24823873696','748159550198146','Timmy',NULL,NULL),('24897310220','393127021878026','Jadon',NULL,NULL),('25092631743','614591767917801','Andreanne',NULL,NULL),('25188399727','856184821618307','Dejon',NULL,NULL),('25256691169','810706050309559','Christiana',NULL,NULL),('25929183554','881831593550224','Audreanne',NULL,NULL),('26737969658','119804851530740','Shanelle',NULL,NULL),('27593223502','413368212517557','Verona',NULL,NULL),('28063163575','353419024233913','Don',NULL,NULL),('28103375807','823535261039829','Joany',NULL,NULL),('28525845002','147138619866842','Ona',NULL,NULL),('28538543151','87252682779087','Una',NULL,NULL),('29521784641','77427798731045','Rodrick',NULL,NULL),('30592526412','543312952789581','Leola',NULL,NULL),('32709441830','126518424872515','Nola',NULL,NULL),('33333333333','44444444','Cicrano Pereira',NULL,NULL),('34082483169','630906079911316','Mathias',NULL,NULL),('34957679402','328983034395819','Elza',NULL,NULL),('35321450854','149019454287158','Kieran',NULL,NULL),('35481900887','402076748868243','Bennie',NULL,NULL),('35901307397','261977624992012','Madge',NULL,NULL),('37330874924','66573655455787','Jasper',NULL,NULL),('38118755320','345263753697896','Bonita',NULL,NULL),('39256294237','687404817360349','Reagan',NULL,NULL),('39379835170','666132871125721','Krystel',NULL,NULL),('41827069512','969824721156619','Granville',NULL,NULL),('42238581097','20045720482658','Henriette',NULL,NULL),('42495135838','606901167751186','Wilma',NULL,NULL),('43212005578','618484466395651','Dusty',NULL,NULL),('43856517308','566334162379821','Reed',NULL,NULL),('43932114086','407714887218963','Gisselle',NULL,NULL),('44908801341','431057816833878','Bryana',NULL,NULL),('44932501431','428705679092349','Jared',NULL,NULL),('45361577471','70574849675305','Edmond',NULL,NULL),('45418748632','251017641946673','Lauren',NULL,NULL),('45950314609','757764345834859','Holly',NULL,NULL),('46797447154','23541428421934','Nikki',NULL,NULL),('47786186055','694237901051011','Lourdes',NULL,NULL),('48001376870','682416645027697','Missouri',NULL,NULL),('48192715437','836032460436949','Immanuel',NULL,NULL),('49368551704','316369480651078','Millie',NULL,NULL),('49455457718','513570986640536','Liana',NULL,NULL),('50779383960','532019644379615','Madeline',NULL,NULL),('50854770839','369488630075938','Filomena',NULL,NULL),('51473583777','6632308102626','Garland',NULL,NULL),('51993723544','510671689912883','Misty',NULL,NULL),('53611699077','551389846115683','Bennie',NULL,NULL),('53727233409','644518838541375','Jaydon',NULL,NULL),('54350182538','410226621409464','David',NULL,NULL),('55420597808','284331491253752','Amelie',NULL,NULL),('55744585601','840247152444078','Lempi',NULL,NULL),('56208534207','244574422790254','Horacio',NULL,NULL),('57018867631','447344146236363','Dan',NULL,NULL),('57213477873','904929284889044','Talon',NULL,NULL),('59253494813','982847643383882','Laurel',NULL,NULL),('60052132233','874132524974023','Deontae',NULL,NULL),('60156531590','459119303709723','Christine',NULL,NULL),('60219813924','192621582122002','Leta',NULL,NULL),('60818600613','433063659138667','Nora',NULL,NULL),('61391398724','884654186655663','Everardo',NULL,NULL),('61893430227','336071003911913','Zelma',NULL,NULL),('62471508441','260536707378923','Abigayle',NULL,NULL),('62643340229','279992452331611','Audra',NULL,NULL),('62721576044','347475744051755','Casper',NULL,NULL),('62977357332','442586447582580','Trycia',NULL,NULL),('63602080278','33018872779276','Tomasa',NULL,NULL),('63927119804','718547340587505','Teagan',NULL,NULL),('64531608091','32969854521151','Avis',NULL,NULL),('65229722029','45404635795081','Maureen',NULL,NULL),('65378960097','93010544049449','Johanna',NULL,NULL),('66105188801','767628100562012','Enola',NULL,NULL),('66384868116','499645621084815','Octavia',NULL,NULL),('66619992752','986850148378871','Jazmin',NULL,NULL),('66818515749','190651286112972','Weldon',NULL,NULL),('68404467776','974142393229218','Rigoberto',NULL,NULL),('69514595013','721275019687600','Maverick',NULL,NULL),('70000769653','661830019002469','Delaney',NULL,NULL),('70028395371','534877647958799','Teagan',NULL,NULL),('70038462595','739922518065302','Orin',NULL,NULL),('71128881184','29472667889462','Billie',NULL,NULL),('71464740567','663201893448001','Cecilia',NULL,NULL),('73186993847','998421259788382','Emilia',NULL,NULL),('74320104097','561330771004367','Angelita',NULL,NULL),('74766544128','609180174640690','Beryl',NULL,NULL),('74925184498','924874114683415','Vida',NULL,NULL),('76099714222','270174396595814','Mckayla',NULL,NULL),('76428835507','430334598561231','Irwin',NULL,NULL),('77007315721','290251006769637','Paige',NULL,NULL),('78050205442','675181676089349','Jarrett',NULL,NULL),('78308031004','787755489098425','Heber',NULL,NULL),('78483879152','331820170224851','Asia',NULL,NULL),('79793206188','207800275087356','Sidney',NULL,NULL),('80350334321','998272543054901','Howell',NULL,NULL),('81074320400','764807116389274','Carlos',NULL,NULL),('82273858620','304744631168432','Scottie',NULL,NULL),('82340173216','457242989092547','Zella',NULL,NULL),('82998505193','943956622135204','Thea',NULL,NULL),('83258767384','289449712700313','Rusty',NULL,NULL),('83963830520','718032526311775','Therese',NULL,NULL),('84215764908','759758276735018','Lurline',NULL,NULL),('84746231138','919550912233793','Wilbert',NULL,NULL),('85261496156','927102635320689','Levi',NULL,NULL),('85610488098','585738008903443','Noah',NULL,NULL),('86588657316','495673240668450','Adaline',NULL,NULL),('86959979393','527125171096478','Freddie',NULL,NULL),('87548700223','994984777224664','Dejah',NULL,NULL),('87705701548','454070433355971','Shakira',NULL,NULL),('89072099328','816905712685030','Justen',NULL,NULL),('89258943001','771372497214728','Chanel',NULL,NULL),('90100047778','443913156556793','Rita',NULL,NULL),('90804178971','68809728169192','Angela',NULL,NULL),('91340827403','937171699442486','Jadyn',NULL,NULL),('91827751613','380827398393303','Dameon',NULL,NULL),('91936588535','363475792742230','Lucy',NULL,NULL),('92280213534','318082453945858','Reid',NULL,NULL),('93063115204','174455965367766','Christy',NULL,NULL),('93693691574','733177677751518','Fatima',NULL,NULL),('95434308590','936939817773074','Myrtle',NULL,NULL),('95572847624','368404287579469','Moshe',NULL,NULL),('96388268098','360460424009296','Gerhard',NULL,NULL),('96759557641','151174178451506','Katrine',NULL,NULL),('96811692333','976898014452825','Green',NULL,NULL),('96867451154','826339437703395','Oleta',NULL,NULL),('97196880355','804190893395183','Margarita',NULL,NULL),('97917767862','527920878787731','Albert',NULL,NULL),('98947435865','286949818747428','Carolina',NULL,NULL),('99127612056','28246705824923','Royce',NULL,NULL);
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professor`
--

DROP TABLE IF EXISTS `professor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `professor` (
  `cpf_pessoa` char(11) NOT NULL,
  `matricula` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`matricula`),
  KEY `professor_FK` (`cpf_pessoa`),
  CONSTRAINT `professor_FK` FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoa` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professor`
--

LOCK TABLES `professor` WRITE;
/*!40000 ALTER TABLE `professor` DISABLE KEYS */;
INSERT INTO `professor` VALUES ('12074098777',8),('12263212932',9),('12377553101',10),('12815545913',11),('14127583263',12),('14146246843',13),('14701686344',14),('33333333333',15);
/*!40000 ALTER TABLE `professor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requisitos`
--

DROP TABLE IF EXISTS `requisitos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `requisitos` (
  `codigo_disciplina` char(6) NOT NULL,
  `codigo_discplina_requisito` char(6) NOT NULL,
  `tipo` char(1) NOT NULL,
  PRIMARY KEY (`codigo_disciplina`,`codigo_discplina_requisito`),
  CONSTRAINT `requisitos_FK` FOREIGN KEY (`codigo_disciplina`) REFERENCES `disciplina` (`codigo`)
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
  `capacidade` int(11) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sala`
--

LOCK TABLES `sala` WRITE;
/*!40000 ALTER TABLE `sala` DISABLE KEYS */;
INSERT INTO `sala` VALUES ('F206','FU',80),('F208','FU',80),('F301','FU',80),('F302','FU',80);
/*!40000 ALTER TABLE `sala` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefone`
--

DROP TABLE IF EXISTS `telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telefone` (
  `cpf_pessoa` char(11) NOT NULL,
  `tel` varchar(11) NOT NULL,
  PRIMARY KEY (`cpf_pessoa`,`tel`),
  CONSTRAINT `telefone_FK` FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoa` (`cpf`)
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
  `codigo_disciplina` char(6) NOT NULL,
  `vagas` int(11) NOT NULL,
  `matricula_professor` int(11) NOT NULL,
  `qtd_aulas` int(11) DEFAULT '25',
  PRIMARY KEY (`codigo`),
  KEY `turma_FK` (`codigo_disciplina`),
  KEY `fk_turma_1_idx` (`matricula_professor`),
  CONSTRAINT `fk_turma_1` FOREIGN KEY (`matricula_professor`) REFERENCES `professor` (`matricula`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `turma_FK` FOREIGN KEY (`codigo_disciplina`) REFERENCES `disciplina` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turma`
--

LOCK TABLES `turma` WRITE;
/*!40000 ALTER TABLE `turma` DISABLE KEYS */;
INSERT INTO `turma` VALUES (1,'CC0001',5,8,25);
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
INSERT INTO `turma_sala_horario` VALUES ('F206',1,2,'QUA'),('F206',1,2,'SEG'),('F206',1,3,'QUA'),('F206',1,3,'SEG');
/*!40000 ALTER TABLE `turma_sala_horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'scoa'
--
/*!50003 DROP PROCEDURE IF EXISTS `alocar_aluno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `alocar_aluno`(matr_aluno INT, cod_turma INT)
BEGIN
	IF EXISTS(
		SELECT * FROM espera
        WHERE codigo_turma = cod_turma AND matricula_aluno = matr_aluno
    )
    THEN
		DELETE FROM espera
        WHERE codigo_turma = cod_turma AND matricula_aluno = matr_aluno;
        INSERT INTO aluno_turma (codigo_turma, matricula_aluno)
        VALUES (cod_turma, matr_aluno);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `dar_nota_aval` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `dar_nota_aval`(
cod_aval VARCHAR(2),
cod_turma INT,
matr_aluno INT,
nota INT
)
BEGIN
	IF (SELECT codigo FROM avaliacao
			WHERE codigo = cod_aval
            AND codigo_turma = cod_turma
		) IS NOT NULL
	AND (SELECT codigo_turma FROM aluno_turma
			WHERE codigo_turma = cod_turma
            AND matricula_aluno = matr_aluno
    )	IS NOT NULL
    THEN
		INSERT INTO nota_avaliacao
		VALUES (cod_aval, cod_turma, matr_aluno, nota);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `excluir_aluno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `excluir_aluno`(cpf CHAR(11))
BEGIN
	DELETE FROM aluno WHERE cpf_pessoa = cpf;
    IF (
		SELECT cpf FROM professor WHERE cpf_pessoa = cpf
		) IS NULL
	THEN
    DELETE FROM pessoa WHERE cpf = cpf;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `excluir_professor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `excluir_professor`(cpf CHAR(11))
BEGIN
	DELETE FROM professor WHERE cpf_pessoa = cpf;
    IF (
		SELECT cpf FROM aluno WHERE cpf_pessoa = cpf
		) IS NULL
	THEN
    DELETE FROM pessoa WHERE cpf = cpf;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inserir_aluno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `inserir_aluno`(
cpf  CHAR(11),
rg  VARCHAR(15),
nome  VARCHAR(200),
curso  CHAR(2)
)
BEGIN
	INSERT INTO pessoa VALUES(cpf, rg, nome);
    INSERT INTO aluno (cpf_pessoa, curso) VALUES (cpf, curso);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inserir_avaliacao` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `inserir_avaliacao`(codigo VARCHAR(2), cod_turma INT)
BEGIN
	INSERT INTO avaliacao VALUES (codigo, cod_turma);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inserir_disciplina` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `inserir_disciplina`(
codigo CHAR(6),
campus CHAR(2),
carga_horaria INT,
cod_curso CHAR(2),
periodo INT
)
BEGIN
	INSERT INTO disciplina VALUES(codigo, campus, carga_horaria, cod_curso, periodo);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inserir_espera` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `inserir_espera`(cod_turma INT, mat_aluno INT)
BEGIN
	INSERT INTO espera VALUES (cod_turma, mat_aluno);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inserir_professor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `inserir_professor`(cpf CHAR(11), rg VARCHAR(15), nome VARCHAR(200))
BEGIN
	INSERT INTO pessoa VALUES (cpf, rg, nome);
    INSERT INTO professor(cpf_pessoa) VALUES (cpf);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inserir_sala` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `inserir_sala`(codigo VARCHAR(10), campus CHAR(2), capacidade INT )
BEGIN
	INSERT INTO sala VALUES(codigo, campus, capacidade);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inserir_tel` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `inserir_tel`(cpf CHAR(11), telefone VARCHAR(11))
BEGIN
	INSERT INTO telefone VALUES(cpf, telefone);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inserir_turma` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `inserir_turma`(cod_disc CHAR(6), vagas INT, mat_prof INT)
BEGIN
	INSERT INTO turma (codigo_disciplina, vagas, matricula_professor)
    VALUES (cod_disc, vagas, mat_prof);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `lancar_grau` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `lancar_grau`(matr_aluno INT, cod_turma INT)
BEGIN
	DECLARE quant_aulas INT DEFAULT 0;
    DECLARE faltas_aluno INT DEFAULT 0;
    DECLARE grau_aluno INT DEFAULT 0;
	DECLARE presenca FLOAT DEFAULT 0.0;
    DECLARE cod_disciplina  CHAR(6) DEFAULT 0;
    SET cod_disciplina = (
		SELECT codigo_disciplina FROM turma
		WHERE codigo = cod_turma
    );
    SELECT concat('coddisc:: ', cod_disciplina);
	SET faltas_aluno = (
		SELECT faltas FROM aluno_turma
        WHERE
		matricula_aluno = matr_aluno AND
		codigo_turma = cod_turma AND
		situacao IS NOT NULL
	);
    IF faltas_aluno IS NOT NULL
	THEN
		SET quant_aulas = (SELECT qtd_aulas FROM turma
        WHERE codigo = cod_turma);
        SET presenca = 1 - faltas_aluno/ quant_aulas;
        SET grau_aluno = (
			SELECT grau FROM aluno_turma
			WHERE
			matricula_aluno = matr_aluno AND
			codigo_turma = cod_turma
        );
        INSERT INTO historico_disciplina
        VALUES (matr_aluno, cod_disciplina, presenca, grau_aluno);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-03 16:45:24
