-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Oct 12, 2019 at 01:23 PM
-- Server version: 10.2.27-MariaDB
-- PHP Version: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u115800830_scoa`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `alocar_aluno` (IN `matricula_aluno` INT, IN `cod_turma` INT)  MODIFIES SQL DATA
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
END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `alterar_aluno` (IN `cpf_atual` CHAR(11), IN `novo_cpf` CHAR(11), IN `novo_rg` VARCHAR(15), IN `novo_nome` VARCHAR(200), IN `novo_curso` CHAR(2))  MODIFIES SQL DATA
BEGIN

DECLARE cpf_aux CHAR(11) DEFAULT cpf_atual;
IF novo_cpf IS NOT NULL THEN
	UPDATE pessoa SET cpf = novo_cpf WHERE cpf = cpf_atual;
	SET cpf_aux = novo_cpf;
END IF;

IF novo_curso IS NOT NULL THEN
	UPDATE  aluno SET curso = novo_curso WHERE cpf_pessoa = cpf_aux;
END IF;

IF novo_rg IS NOT NULL THEN
	UPDATE  pessoa SET rg = novo_rg WHERE cpf_pessoa = cpf_aux;
END IF;

IF novo_nome IS NOT NULL THEN
	UPDATE  pessoa SET nome = novo_nome WHERE cpf_pessoa = cpf_aux;
END IF;

END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `alterar_disciplina` (IN `cod_atual` CHAR(6), IN `novo_cod` CHAR(6), IN `novo_nome` VARCHAR(200), IN `novo_codcurso` CHAR(2), IN `novo_periodo` INT, IN `nova_carga` INT)  NO SQL
BEGIN

DECLARE codigo_aux CHAR(6) DEFAULT cod_atual;

IF novo_cod IS NOT NULL THEN
	UPDATE disciplina SET codigo = novo_cod
    WHERE codigo = cod_atual;
    SET codigo_aux = novo_cod;
END IF;

IF novo_nome IS NOT NULL THEN
	UPDATE disciplina SET nome = novo_nome
    WHERE codigo = codigo_aux;
END IF;
IF novo_codcurso IS NOT NULL THEN
	UPDATE disciplina SET codigo_curso = novo_codcurso
    WHERE codigo = codigo_aux;
END IF;
IF novo_periodo IS NOT NULL THEN
	UPDATE disciplina SET periodo = novo_periodo
    WHERE codigo = codigo_aux;
END IF;
IF nova_carga IS NOT NULL THEN
	UPDATE disciplina SET carga = nova_carga
    WHERE codigo = codigo_aux;
END IF;

END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `alterar_login` (IN `cpf_pessoa` CHAR(11), IN `login_pessoa` VARCHAR(45), IN `senha_pessoa` VARCHAR(50))  NO SQL
BEGIN
	UPDATE pessoa 
    SET login = login_pessoa, senha = SHA2(senha_pessoa, 256)
    WHERE cpf = cpf_pessoa;
END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `alterar_professor` (IN `cpf_atual` CHAR(11), IN `novo_cpf` CHAR(11), IN `novo_rg` VARCHAR(15), IN `novo_nome` VARCHAR(200))  MODIFIES SQL DATA
BEGIN

DECLARE cpf_aux CHAR(11) DEFAULT cpf_atual;

IF novo_cpf IS NOT NULL THEN
	UPDATE pessoa SET cpf = novo_cpf WHERE cpf = cpf_atual;
	SET cpf_aux = novo_cpf;
END IF;


IF novo_rg IS NOT NULL THEN
	UPDATE  pessoa SET rg = novo_rg WHERE cpf_pessoa = cpf_aux;
END IF;

IF novo_nome IS NOT NULL THEN
	UPDATE  pessoa SET nome = novo_nome WHERE cpf_pessoa = cpf_aux;
END IF;

END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `dar_nota_aval` (IN `cod_aval` VARCHAR(2), IN `cod_turma` INT, IN `matr_aluno` INT, IN `nota` INT)  BEGIN
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
END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `excluir_professor` (IN `cpf` CHAR(11))  MODIFIES SQL DATA
BEGIN
	DELETE FROM professor WHERE cpf_pessoa = cpf;
    IF (
		SELECT cpf FROM aluno WHERE cpf_pessoa = cpf
		) IS NULL
	THEN
    DELETE FROM pessoa WHERE cpf = cpf;
    END IF;
END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `inserir_aluno` (IN `cpf` CHAR(11), IN `rg` VARCHAR(15), IN `nome` VARCHAR(200), IN `curso` CHAR(2))  SQL SECURITY INVOKER
BEGIN
	INSERT INTO pessoa (cpf, rg, nome) VALUES(cpf, rg, nome);
    INSERT INTO aluno (cpf_pessoa, curso) VALUES (cpf, curso);
END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `inserir_avaliacao` (`codigo` VARCHAR(2), `cod_turma` INT)  BEGIN
	INSERT INTO avaliacao VALUES (codigo, cod_turma);
END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `inserir_disciplina` (`codigo` CHAR(6), `campus` CHAR(2), `carga_horaria` INT, `cod_curso` CHAR(2), `periodo` INT)  BEGIN
	INSERT INTO disciplina VALUES(codigo, campus, carga_horaria, cod_curso, periodo);
END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `inserir_espera` (`cod_turma` INT, `mat_aluno` INT)  BEGIN
	INSERT INTO espera VALUES (cod_turma, mat_aluno);
END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `inserir_professor` (`cpf` CHAR(11), `rg` VARCHAR(15), `nome` VARCHAR(200))  BEGIN
	INSERT INTO pessoa VALUES (cpf, rg, nome);
    INSERT INTO professor(cpf_pessoa) VALUES (cpf);
END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `inserir_sala` (`codigo` VARCHAR(10), `campus` CHAR(2), `capacidade` INT)  BEGIN
	INSERT INTO sala VALUES(codigo, campus, capacidade);
END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `inserir_tel` (`cpf` CHAR(11), `telefone` VARCHAR(11))  BEGIN
	INSERT INTO telefone VALUES(cpf, telefone);
END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `inserir_turma` (`cod_disc` CHAR(6), `vagas` INT, `mat_prof` INT)  BEGIN
	INSERT INTO turma (codigo_disciplina, vagas, matricula_professor)
    VALUES (cod_disc, vagas, mat_prof);
END$$

CREATE DEFINER=`u115800830_root`@`127.0.0.1` PROCEDURE `lancar_grau` (`matr_aluno` INT, `cod_turma` INT)  BEGIN
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
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `aluno`
--

CREATE TABLE `aluno` (
  `matricula` int(11) NOT NULL,
  `cpf_pessoa` char(11) NOT NULL,
  `curso` char(2) NOT NULL,
  `situacao` varchar(20) NOT NULL DEFAULT 'ATIVA'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `aluno`
--

INSERT INTO `aluno` (`matricula`, `cpf_pessoa`, `curso`, `situacao`) VALUES
(1, '22157353452', 'CC', 'ATIVA'),
(2, '22227705021', 'CC', 'ATIVA'),
(3, '22583770420', 'CC', 'ATIVA'),
(4, '23132556262', 'CC', 'ATIVA'),
(5, '24196693921', 'CC', 'ATIVA'),
(6, '24823873696', 'CC', 'ATIVA'),
(7, '24897310220', 'CC', 'ATIVA'),
(8, '25092631743', 'CC', 'ATIVA'),
(9, '25188399727', 'CC', 'ATIVA'),
(10, '25256691169', 'CC', 'ATIVA'),
(11, '25929183554', 'CC', 'ATIVA'),
(12, '26737969658', 'CC', 'ATIVA'),
(13, '27593223502', 'CC', 'ATIVA'),
(14, '28063163575', 'CC', 'ATIVA'),
(15, '28103375807', 'CC', 'ATIVA'),
(16, '19181818181', 'CC', 'ATIVA'),
(17, '123', 'CC', 'ATIVA'),
(18, '45446544564', 'CC', 'ATIVA'),
(19, '12761782712', 'EC', 'ATIVA'),
(20, '89898789898', 'EC', 'ATIVA'),
(21, '555555', 'EC', 'ATIVA');

-- --------------------------------------------------------

--
-- Table structure for table `aluno_turma`
--

CREATE TABLE `aluno_turma` (
  `codigo_turma` int(11) NOT NULL,
  `matricula_aluno` int(11) NOT NULL,
  `faltas` int(11) NOT NULL DEFAULT 0,
  `grau` int(11) DEFAULT 0,
  `situacao` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `aluno_turma`
--

INSERT INTO `aluno_turma` (`codigo_turma`, `matricula_aluno`, `faltas`, `grau`, `situacao`) VALUES
(1, 1, 5, 65, 'AP'),
(1, 3, 0, 0, NULL),
(1, 6, 0, 0, NULL),
(1, 7, 0, 0, NULL),
(1, 8, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `avaliacao`
--

CREATE TABLE `avaliacao` (
  `codigo` varchar(2) NOT NULL,
  `codigo_turma` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `avaliacao`
--

INSERT INTO `avaliacao` (`codigo`, `codigo_turma`) VALUES
('P1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `curso`
--

CREATE TABLE `curso` (
  `codigo` char(2) NOT NULL,
  `nome` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `curso`
--

INSERT INTO `curso` (`codigo`, `nome`) VALUES
('CC', 'CIENCIA DA COMPUTACAO'),
('EC', 'ENGENHARIA DE COMPUTACAO');

-- --------------------------------------------------------

--
-- Table structure for table `disciplina`
--

CREATE TABLE `disciplina` (
  `codigo` char(6) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `carga` int(11) NOT NULL,
  `codigo_curso` char(2) NOT NULL,
  `periodo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `disciplina`
--

INSERT INTO `disciplina` (`codigo`, `nome`, `carga`, `codigo_curso`, `periodo`) VALUES
('CC0001', 'TEORIA DOS NUMEROS', 90, 'CC', 1),
('CC0002', 'CALCULO 1', 90, 'CC', 1),
('CC0003', 'TEORIA GERAL DA COMPUTACAO', 90, 'CC', 2),
('CC0004', 'TEORIA DOS GRAFOS', 90, 'CC', 2);

-- --------------------------------------------------------

--
-- Table structure for table `espera`
--

CREATE TABLE `espera` (
  `codigo_turma` int(11) NOT NULL,
  `matricula_aluno` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `espera`
--

INSERT INTO `espera` (`codigo_turma`, `matricula_aluno`) VALUES
(1, 2),
(1, 10),
(1, 15);

-- --------------------------------------------------------

--
-- Table structure for table `historico_disciplina`
--

CREATE TABLE `historico_disciplina` (
  `matricula_aluno` int(11) NOT NULL,
  `codigo_disciplina` char(6) NOT NULL,
  `presenca` float NOT NULL,
  `grau` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `historico_disciplina`
--

INSERT INTO `historico_disciplina` (`matricula_aluno`, `codigo_disciplina`, `presenca`, `grau`) VALUES
(1, 'CC0001', 0.8, 65);

-- --------------------------------------------------------

--
-- Table structure for table `nota_avaliacao`
--

CREATE TABLE `nota_avaliacao` (
  `codigo_avaliacao` varchar(2) NOT NULL,
  `codigo_turma` int(11) NOT NULL,
  `matricula_aluno` int(11) NOT NULL,
  `nota` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `nota_avaliacao`
--

INSERT INTO `nota_avaliacao` (`codigo_avaliacao`, `codigo_turma`, `matricula_aluno`, `nota`) VALUES
('P1', 1, 1, 75);

-- --------------------------------------------------------

--
-- Table structure for table `pessoa`
--

CREATE TABLE `pessoa` (
  `cpf` char(11) NOT NULL,
  `rg` varchar(15) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `login` varchar(45) DEFAULT NULL,
  `senha` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pessoa`
--

INSERT INTO `pessoa` (`cpf`, `rg`, `nome`, `login`, `senha`) VALUES
('12074098777', '560665988758102', 'Camren', 'camren', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4'),
('12263212932', '212398437760873', 'Richmond', NULL, NULL),
('123', '123', 'Diego', NULL, NULL),
('12377553101', '438099690590881', 'Issac', NULL, NULL),
('12761782712', '7217821877812', 'Diego2', NULL, NULL),
('12815545913', '435230492393796', 'Noah', NULL, NULL),
('14127583263', '590014817620524', 'Modesta', NULL, NULL),
('14146246843', '580495932198957', 'Scarlett', NULL, NULL),
('14701686344', '907946350001730', 'Jamil', NULL, NULL),
('14721922948', '587798522360002', 'Andrew', NULL, NULL),
('15027945405', '835112123488345', 'Bridie', NULL, NULL),
('17169596420', '115570661157059', 'Pat', NULL, NULL),
('17787407131', '557493880024800', 'Thad', NULL, NULL),
('19072102258', '184124888066305', 'Lelah', NULL, NULL),
('19181818181', '292929292', 'Fulano da Silva', NULL, NULL),
('19184512562', '171155182020738', 'Bartholome', NULL, NULL),
('19563652450', '118790353644742', 'Vidal', NULL, NULL),
('19751383943', '50338623051324', 'Grover', NULL, NULL),
('20083994335', '902373463895896', 'Arnaldo', NULL, NULL),
('20155217001', '275311611262667', 'Clovis', NULL, NULL),
('20395362335', '414569578238555', 'Corrine', NULL, NULL),
('20820724922', '797598677023520', 'Camryn', NULL, NULL),
('22157353452', '634133267262433', 'Brandyn', NULL, NULL),
('22227705021', '966778935734700', 'Shirley', NULL, NULL),
('22583770420', '12716516649039', 'Courtney', NULL, NULL),
('23132556262', '478206392828788', 'Wendy', NULL, NULL),
('24196693921', '788270408031530', 'Branson', NULL, NULL),
('24823873696', '748159550198146', 'Timmy', NULL, NULL),
('24897310220', '393127021878026', 'Jadon', NULL, NULL),
('25092631743', '614591767917801', 'Andreanne', NULL, NULL),
('25188399727', '856184821618307', 'Dejon', NULL, NULL),
('25256691169', '810706050309559', 'Christiana', NULL, NULL),
('25929183554', '881831593550224', 'Audreanne', NULL, NULL),
('26737969658', '119804851530740', 'Shanelle', NULL, NULL),
('27593223502', '413368212517557', 'Verona', NULL, NULL),
('28063163575', '353419024233913', 'Don', NULL, NULL),
('28103375807', '823535261039829', 'Joany', NULL, NULL),
('28525845002', '147138619866842', 'Ona', NULL, NULL),
('28538543151', '87252682779087', 'Una', NULL, NULL),
('29521784641', '77427798731045', 'Rodrick', NULL, NULL),
('30592526412', '543312952789581', 'Leola', NULL, NULL),
('32709441830', '126518424872515', 'Nola', NULL, NULL),
('33333333333', '44444444', 'Cicrano Pereira', NULL, NULL),
('34082483169', '630906079911316', 'Mathias', NULL, NULL),
('34957679402', '328983034395819', 'Elza', NULL, NULL),
('35321450854', '149019454287158', 'Kieran', NULL, NULL),
('35481900887', '402076748868243', 'Bennie', NULL, NULL),
('35901307397', '261977624992012', 'Madge', NULL, NULL),
('37330874924', '66573655455787', 'Jasper', NULL, NULL),
('38118755320', '345263753697896', 'Bonita', NULL, NULL),
('39256294237', '687404817360349', 'Reagan', NULL, NULL),
('39379835170', '666132871125721', 'Krystel', NULL, NULL),
('41827069512', '969824721156619', 'Granville', NULL, NULL),
('42238581097', '20045720482658', 'Henriette', NULL, NULL),
('42495135838', '606901167751186', 'Wilma', NULL, NULL),
('43212005578', '618484466395651', 'Dusty', NULL, NULL),
('43856517308', '566334162379821', 'Reed', NULL, NULL),
('43932114086', '407714887218963', 'Gisselle', NULL, NULL),
('44908801341', '431057816833878', 'Bryana', NULL, NULL),
('44932501431', '428705679092349', 'Jared', NULL, NULL),
('45361577471', '70574849675305', 'Edmond', NULL, NULL),
('45418748632', '251017641946673', 'Lauren', NULL, NULL),
('45446544564', '45645646', 'dsaf', NULL, NULL),
('45950314609', '757764345834859', 'Holly', NULL, NULL),
('46797447154', '23541428421934', 'Nikki', NULL, NULL),
('47786186055', '694237901051011', 'Lourdes', NULL, NULL),
('48001376870', '682416645027697', 'Missouri', NULL, NULL),
('48192715437', '836032460436949', 'Immanuel', NULL, NULL),
('49368551704', '316369480651078', 'Millie', NULL, NULL),
('49455457718', '513570986640536', 'Liana', NULL, NULL),
('50779383960', '532019644379615', 'Madeline', NULL, NULL),
('50854770839', '369488630075938', 'Filomena', NULL, NULL),
('51473583777', '6632308102626', 'Garland', NULL, NULL),
('51993723544', '510671689912883', 'Misty', NULL, NULL),
('53611699077', '551389846115683', 'Bennie', NULL, NULL),
('53727233409', '644518838541375', 'Jaydon', NULL, NULL),
('54350182538', '410226621409464', 'David', NULL, NULL),
('55420597808', '284331491253752', 'Amelie', NULL, NULL),
('555555', '555555', 'Pedrinho', NULL, NULL),
('55744585601', '840247152444078', 'Lempi', NULL, NULL),
('56208534207', '244574422790254', 'Horacio', NULL, NULL),
('57018867631', '447344146236363', 'Dan', NULL, NULL),
('57213477873', '904929284889044', 'Talon', NULL, NULL),
('59253494813', '982847643383882', 'Laurel', NULL, NULL),
('60052132233', '874132524974023', 'Deontae', NULL, NULL),
('60156531590', '459119303709723', 'Christine', NULL, NULL),
('60219813924', '192621582122002', 'Leta', NULL, NULL),
('60818600613', '433063659138667', 'Nora', NULL, NULL),
('61391398724', '884654186655663', 'Everardo', NULL, NULL),
('61893430227', '336071003911913', 'Zelma', NULL, NULL),
('62471508441', '260536707378923', 'Abigayle', NULL, NULL),
('62643340229', '279992452331611', 'Audra', NULL, NULL),
('62721576044', '347475744051755', 'Casper', NULL, NULL),
('62977357332', '442586447582580', 'Trycia', NULL, NULL),
('63602080278', '33018872779276', 'Tomasa', NULL, NULL),
('63927119804', '718547340587505', 'Teagan', NULL, NULL),
('64531608091', '32969854521151', 'Avis', NULL, NULL),
('65229722029', '45404635795081', 'Maureen', NULL, NULL),
('65378960097', '93010544049449', 'Johanna', NULL, NULL),
('66105188801', '767628100562012', 'Enola', NULL, NULL),
('66384868116', '499645621084815', 'Octavia', NULL, NULL),
('66619992752', '986850148378871', 'Jazmin', NULL, NULL),
('66818515749', '190651286112972', 'Weldon', NULL, NULL),
('68404467776', '974142393229218', 'Rigoberto', NULL, NULL),
('69514595013', '721275019687600', 'Maverick', NULL, NULL),
('70000769653', '661830019002469', 'Delaney', NULL, NULL),
('70028395371', '534877647958799', 'Teagan', NULL, NULL),
('70038462595', '739922518065302', 'Orin', NULL, NULL),
('71128881184', '29472667889462', 'Billie', NULL, NULL),
('71464740567', '663201893448001', 'Cecilia', NULL, NULL),
('73186993847', '998421259788382', 'Emilia', NULL, NULL),
('74320104097', '561330771004367', 'Angelita', NULL, NULL),
('74766544128', '609180174640690', 'Beryl', NULL, NULL),
('74925184498', '924874114683415', 'Vida', NULL, NULL),
('76099714222', '270174396595814', 'Mckayla', NULL, NULL),
('76428835507', '430334598561231', 'Irwin', NULL, NULL),
('77007315721', '290251006769637', 'Paige', NULL, NULL),
('78050205442', '675181676089349', 'Jarrett', NULL, NULL),
('78308031004', '787755489098425', 'Heber', NULL, NULL),
('78483879152', '331820170224851', 'Asia', NULL, NULL),
('79793206188', '207800275087356', 'Sidney', NULL, NULL),
('80350334321', '998272543054901', 'Howell', NULL, NULL),
('81074320400', '764807116389274', 'Carlos', NULL, NULL),
('82273858620', '304744631168432', 'Scottie', NULL, NULL),
('82340173216', '457242989092547', 'Zella', NULL, NULL),
('82998505193', '943956622135204', 'Thea', NULL, NULL),
('83258767384', '289449712700313', 'Rusty', NULL, NULL),
('83963830520', '718032526311775', 'Therese', NULL, NULL),
('84215764908', '759758276735018', 'Lurline', NULL, NULL),
('84746231138', '919550912233793', 'Wilbert', NULL, NULL),
('85261496156', '927102635320689', 'Levi', NULL, NULL),
('85610488098', '585738008903443', 'Noah', NULL, NULL),
('86588657316', '495673240668450', 'Adaline', NULL, NULL),
('86959979393', '527125171096478', 'Freddie', NULL, NULL),
('87548700223', '994984777224664', 'Dejah', NULL, NULL),
('87705701548', '454070433355971', 'Shakira', NULL, NULL),
('89072099328', '816905712685030', 'Justen', NULL, NULL),
('89258943001', '771372497214728', 'Chanel', NULL, NULL),
('89898789898', '898989897989', 'Joao da Silva', NULL, NULL),
('90100047778', '443913156556793', 'Rita', NULL, NULL),
('90804178971', '68809728169192', 'Angela', NULL, NULL),
('91340827403', '937171699442486', 'Jadyn', NULL, NULL),
('91827751613', '380827398393303', 'Dameon', NULL, NULL),
('91936588535', '363475792742230', 'Lucy', NULL, NULL),
('92280213534', '318082453945858', 'Reid', NULL, NULL),
('93063115204', '174455965367766', 'Christy', NULL, NULL),
('93693691574', '733177677751518', 'Fatima', NULL, NULL),
('95434308590', '936939817773074', 'Myrtle', NULL, NULL),
('95572847624', '368404287579469', 'Moshe', NULL, NULL),
('96388268098', '360460424009296', 'Gerhard', NULL, NULL),
('96759557641', '151174178451506', 'Katrine', NULL, NULL),
('96811692333', '976898014452825', 'Green', NULL, NULL),
('96867451154', '826339437703395', 'Oleta', NULL, NULL),
('97196880355', '804190893395183', 'Margarita', NULL, NULL),
('97917767862', '527920878787731', 'Albert', NULL, NULL),
('98947435865', '286949818747428', 'Carolina', NULL, NULL),
('99127612056', '28246705824923', 'Royce', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `professor`
--

CREATE TABLE `professor` (
  `cpf_pessoa` char(11) NOT NULL,
  `matricula` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `professor`
--

INSERT INTO `professor` (`cpf_pessoa`, `matricula`) VALUES
('12074098777', 8),
('12263212932', 9),
('12377553101', 10),
('12815545913', 11),
('14127583263', 12),
('14146246843', 13),
('14701686344', 14),
('33333333333', 15);

-- --------------------------------------------------------

--
-- Table structure for table `requisitos`
--

CREATE TABLE `requisitos` (
  `codigo_disciplina` char(6) NOT NULL,
  `codigo_discplina_requisito` char(6) NOT NULL,
  `tipo` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sala`
--

CREATE TABLE `sala` (
  `codigo` varchar(10) NOT NULL,
  `campus` char(2) NOT NULL,
  `capacidade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sala`
--

INSERT INTO `sala` (`codigo`, `campus`, `capacidade`) VALUES
('F206', 'FU', 80),
('F208', 'FU', 80),
('F301', 'FU', 80),
('F302', 'FU', 80);

-- --------------------------------------------------------

--
-- Table structure for table `telefone`
--

CREATE TABLE `telefone` (
  `cpf_pessoa` char(11) NOT NULL,
  `tel` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `turma`
--

CREATE TABLE `turma` (
  `codigo` int(11) NOT NULL,
  `codigo_disciplina` char(6) NOT NULL,
  `vagas` int(11) NOT NULL,
  `matricula_professor` int(11) NOT NULL,
  `qtd_aulas` int(11) DEFAULT 25
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `turma`
--

INSERT INTO `turma` (`codigo`, `codigo_disciplina`, `vagas`, `matricula_professor`, `qtd_aulas`) VALUES
(1, 'CC0001', 5, 8, 25);

-- --------------------------------------------------------

--
-- Table structure for table `turma_sala_horario`
--

CREATE TABLE `turma_sala_horario` (
  `codigo_sala` varchar(10) NOT NULL,
  `codigo_turma` int(11) NOT NULL,
  `horario` int(11) NOT NULL,
  `dia` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `turma_sala_horario`
--

INSERT INTO `turma_sala_horario` (`codigo_sala`, `codigo_turma`, `horario`, `dia`) VALUES
('F206', 1, 2, 'QUA'),
('F206', 1, 2, 'SEG'),
('F206', 1, 3, 'QUA'),
('F206', 1, 3, 'SEG');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aluno`
--
ALTER TABLE `aluno`
  ADD PRIMARY KEY (`matricula`),
  ADD KEY `aluno_FK` (`cpf_pessoa`),
  ADD KEY `fk_aluno_1_idx` (`curso`);

--
-- Indexes for table `aluno_turma`
--
ALTER TABLE `aluno_turma`
  ADD PRIMARY KEY (`codigo_turma`,`matricula_aluno`),
  ADD KEY `presenca_FK_1` (`matricula_aluno`);

--
-- Indexes for table `avaliacao`
--
ALTER TABLE `avaliacao`
  ADD PRIMARY KEY (`codigo`,`codigo_turma`),
  ADD KEY `avaliacao_FK` (`codigo_turma`);

--
-- Indexes for table `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`codigo`);

--
-- Indexes for table `disciplina`
--
ALTER TABLE `disciplina`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `fk_disciplina_1_idx` (`codigo_curso`);

--
-- Indexes for table `espera`
--
ALTER TABLE `espera`
  ADD PRIMARY KEY (`codigo_turma`,`matricula_aluno`),
  ADD KEY `espera_FK` (`matricula_aluno`);

--
-- Indexes for table `historico_disciplina`
--
ALTER TABLE `historico_disciplina`
  ADD PRIMARY KEY (`matricula_aluno`,`codigo_disciplina`),
  ADD KEY `historico_disciplina_FK_1` (`codigo_disciplina`);

--
-- Indexes for table `nota_avaliacao`
--
ALTER TABLE `nota_avaliacao`
  ADD PRIMARY KEY (`codigo_avaliacao`,`codigo_turma`,`matricula_aluno`),
  ADD KEY `nota_avaliacao_FK` (`matricula_aluno`);

--
-- Indexes for table `pessoa`
--
ALTER TABLE `pessoa`
  ADD PRIMARY KEY (`cpf`),
  ADD UNIQUE KEY `login_UNIQUE` (`login`),
  ADD UNIQUE KEY `senha_UNIQUE` (`senha`);

--
-- Indexes for table `professor`
--
ALTER TABLE `professor`
  ADD PRIMARY KEY (`matricula`),
  ADD KEY `professor_FK` (`cpf_pessoa`);

--
-- Indexes for table `requisitos`
--
ALTER TABLE `requisitos`
  ADD PRIMARY KEY (`codigo_disciplina`,`codigo_discplina_requisito`);

--
-- Indexes for table `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`codigo`);

--
-- Indexes for table `telefone`
--
ALTER TABLE `telefone`
  ADD PRIMARY KEY (`cpf_pessoa`,`tel`);

--
-- Indexes for table `turma`
--
ALTER TABLE `turma`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `turma_FK` (`codigo_disciplina`),
  ADD KEY `fk_turma_1_idx` (`matricula_professor`);

--
-- Indexes for table `turma_sala_horario`
--
ALTER TABLE `turma_sala_horario`
  ADD PRIMARY KEY (`horario`,`dia`),
  ADD KEY `turma_sala_horario_FK` (`codigo_sala`),
  ADD KEY `turma_sala_horario_FK_1` (`codigo_turma`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aluno`
--
ALTER TABLE `aluno`
  MODIFY `matricula` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `professor`
--
ALTER TABLE `professor`
  MODIFY `matricula` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `turma`
--
ALTER TABLE `turma`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `aluno`
--
ALTER TABLE `aluno`
  ADD CONSTRAINT `aluno_FK` FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoa` (`cpf`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_aluno_1` FOREIGN KEY (`curso`) REFERENCES `curso` (`codigo`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `aluno_turma`
--
ALTER TABLE `aluno_turma`
  ADD CONSTRAINT `presenca_FK` FOREIGN KEY (`codigo_turma`) REFERENCES `turma` (`codigo`) ON UPDATE CASCADE,
  ADD CONSTRAINT `presenca_FK_1` FOREIGN KEY (`matricula_aluno`) REFERENCES `aluno` (`matricula`) ON UPDATE CASCADE;

--
-- Constraints for table `avaliacao`
--
ALTER TABLE `avaliacao`
  ADD CONSTRAINT `avaliacao_FK` FOREIGN KEY (`codigo_turma`) REFERENCES `turma` (`codigo`) ON UPDATE CASCADE;

--
-- Constraints for table `disciplina`
--
ALTER TABLE `disciplina`
  ADD CONSTRAINT `fk_disciplina_1` FOREIGN KEY (`codigo_curso`) REFERENCES `curso` (`codigo`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `espera`
--
ALTER TABLE `espera`
  ADD CONSTRAINT `espera_FK` FOREIGN KEY (`matricula_aluno`) REFERENCES `aluno` (`matricula`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `espera_FK_2` FOREIGN KEY (`codigo_turma`) REFERENCES `turma` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `historico_disciplina`
--
ALTER TABLE `historico_disciplina`
  ADD CONSTRAINT `historico_disciplina_FK` FOREIGN KEY (`matricula_aluno`) REFERENCES `aluno` (`matricula`),
  ADD CONSTRAINT `historico_disciplina_FK_1` FOREIGN KEY (`codigo_disciplina`) REFERENCES `disciplina` (`codigo`);

--
-- Constraints for table `nota_avaliacao`
--
ALTER TABLE `nota_avaliacao`
  ADD CONSTRAINT `nota_avaliacao_FK` FOREIGN KEY (`matricula_aluno`) REFERENCES `aluno` (`matricula`) ON UPDATE CASCADE,
  ADD CONSTRAINT `nota_avaliacao_FK_1` FOREIGN KEY (`codigo_avaliacao`,`codigo_turma`) REFERENCES `avaliacao` (`codigo`, `codigo_turma`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `professor`
--
ALTER TABLE `professor`
  ADD CONSTRAINT `professor_FK` FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoa` (`cpf`) ON UPDATE CASCADE;

--
-- Constraints for table `requisitos`
--
ALTER TABLE `requisitos`
  ADD CONSTRAINT `requisitos_FK` FOREIGN KEY (`codigo_disciplina`) REFERENCES `disciplina` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `telefone`
--
ALTER TABLE `telefone`
  ADD CONSTRAINT `telefone_FK` FOREIGN KEY (`cpf_pessoa`) REFERENCES `pessoa` (`cpf`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `turma`
--
ALTER TABLE `turma`
  ADD CONSTRAINT `fk_turma_1` FOREIGN KEY (`matricula_professor`) REFERENCES `professor` (`matricula`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `turma_FK` FOREIGN KEY (`codigo_disciplina`) REFERENCES `disciplina` (`codigo`) ON UPDATE CASCADE;

--
-- Constraints for table `turma_sala_horario`
--
ALTER TABLE `turma_sala_horario`
  ADD CONSTRAINT `turma_sala_horario_FK` FOREIGN KEY (`codigo_sala`) REFERENCES `sala` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `turma_sala_horario_FK_1` FOREIGN KEY (`codigo_turma`) REFERENCES `turma` (`codigo`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
