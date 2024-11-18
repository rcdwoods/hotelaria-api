-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (x86_64)
--
-- Host: 127.0.0.1    Database: hotelaria
-- ------------------------------------------------------
-- Server version	5.7.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acomodacao`
--

DROP TABLE IF EXISTS `acomodacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acomodacao` (
  `numero` bigint(20) NOT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `valor_diaria` decimal(10,2) NOT NULL,
  `tipo` varchar(60) NOT NULL,
  `capacidade` bigint(20) NOT NULL,
  PRIMARY KEY (`numero`,`hotel_id`),
  KEY `hotel_id` (`hotel_id`),
  CONSTRAINT `acomodacao_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acomodacao`
--

LOCK TABLES `acomodacao` WRITE;
/*!40000 ALTER TABLE `acomodacao` DISABLE KEYS */;
INSERT INTO `acomodacao` VALUES (1,1,150.00,'STANDARD',2),(1,2,140.00,'STANDARD',2),(1,3,130.00,'STANDARD',2),(1,4,160.00,'STANDARD',2),(2,1,160.00,'STANDARD_COM_VISTA',2),(2,2,150.00,'STANDARD_COM_VISTA',2),(2,3,140.00,'STANDARD_COM_VISTA',2),(2,4,170.00,'STANDARD_COM_VISTA',2),(3,1,200.00,'DELUXE',3),(3,2,190.00,'DELUXE',3),(3,3,180.00,'DELUXE',3),(3,4,210.00,'DELUXE',3),(4,1,210.00,'DELUXE_COM_VISTA',3),(4,2,200.00,'DELUXE_COM_VISTA',3),(4,3,190.00,'DELUXE_COM_VISTA',3),(4,4,220.00,'DELUXE_COM_VISTA',3),(5,1,250.00,'SUITE',4),(5,2,240.00,'SUITE',4),(5,3,230.00,'SUITE',4),(5,4,260.00,'SUITE',4),(6,1,260.00,'SUITE_COM_VISTA',4),(6,2,250.00,'SUITE_COM_VISTA',4),(6,3,240.00,'SUITE_COM_VISTA',4),(6,4,270.00,'SUITE_COM_VISTA',4),(7,1,300.00,'EXECUTIVE',4),(7,2,290.00,'EXECUTIVE',4),(7,3,280.00,'EXECUTIVE',4),(7,4,310.00,'EXECUTIVE',4),(8,1,350.00,'EXECUTIVE_COM_VISTA',5),(8,2,340.00,'EXECUTIVE_COM_VISTA',5),(8,3,330.00,'EXECUTIVE_COM_VISTA',5),(8,4,360.00,'EXECUTIVE_COM_VISTA',5),(9,1,400.00,'PRESIDENTIAL_SUITE',5),(9,2,390.00,'PRESIDENTIAL_SUITE',5),(9,3,380.00,'PRESIDENTIAL_SUITE',5),(9,4,410.00,'PRESIDENTIAL_SUITE',5),(10,1,450.00,'ROYAL_SUITE',6),(10,2,440.00,'ROYAL_SUITE',6),(10,3,430.00,'ROYAL_SUITE',6),(10,4,460.00,'ROYAL_SUITE',6);
/*!40000 ALTER TABLE `acomodacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acomodacao_manutencao`
--

DROP TABLE IF EXISTS `acomodacao_manutencao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acomodacao_manutencao` (
  `numero_acomodacao` bigint(20) NOT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `manutencao_id` bigint(20) NOT NULL,
  PRIMARY KEY (`numero_acomodacao`,`hotel_id`,`manutencao_id`),
  KEY `manutencao_id` (`manutencao_id`),
  CONSTRAINT `acomodacao_manutencao_ibfk_1` FOREIGN KEY (`numero_acomodacao`, `hotel_id`) REFERENCES `acomodacao` (`numero`, `hotel_id`),
  CONSTRAINT `acomodacao_manutencao_ibfk_2` FOREIGN KEY (`manutencao_id`) REFERENCES `manutencao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acomodacao_manutencao`
--

LOCK TABLES `acomodacao_manutencao` WRITE;
/*!40000 ALTER TABLE `acomodacao_manutencao` DISABLE KEYS */;
INSERT INTO `acomodacao_manutencao` VALUES (1,1,1),(2,1,2),(1,2,3),(1,3,4),(1,4,5);
/*!40000 ALTER TABLE `acomodacao_manutencao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acomodacao_politica_de_uso`
--

DROP TABLE IF EXISTS `acomodacao_politica_de_uso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acomodacao_politica_de_uso` (
  `numero_acomodacao` bigint(20) NOT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `politica_de_uso_id` bigint(20) NOT NULL,
  PRIMARY KEY (`numero_acomodacao`,`hotel_id`,`politica_de_uso_id`),
  KEY `politica_de_uso_id` (`politica_de_uso_id`),
  CONSTRAINT `acomodacao_politica_de_uso_ibfk_1` FOREIGN KEY (`numero_acomodacao`, `hotel_id`) REFERENCES `acomodacao` (`numero`, `hotel_id`),
  CONSTRAINT `acomodacao_politica_de_uso_ibfk_2` FOREIGN KEY (`politica_de_uso_id`) REFERENCES `politica_de_uso` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acomodacao_politica_de_uso`
--

LOCK TABLES `acomodacao_politica_de_uso` WRITE;
/*!40000 ALTER TABLE `acomodacao_politica_de_uso` DISABLE KEYS */;
INSERT INTO `acomodacao_politica_de_uso` VALUES (1,1,1),(1,2,1),(1,3,1),(1,4,1),(2,1,1),(4,1,1),(4,2,1),(4,3,1),(4,4,1),(1,1,2),(1,2,2),(1,3,2),(2,4,2),(4,1,2),(4,2,2),(4,3,2),(5,4,2),(1,1,3),(1,4,3),(2,2,3),(2,3,3),(4,4,3),(5,1,3),(5,2,3),(5,3,3),(2,1,4),(2,4,4),(3,2,4),(3,3,4),(5,4,4),(2,2,5),(2,3,5),(3,1,5),(3,4,5),(6,3,5),(3,1,6),(3,2,6),(3,4,6);
/*!40000 ALTER TABLE `acomodacao_politica_de_uso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `condominio`
--

DROP TABLE IF EXISTS `condominio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `condominio` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hotel_id` bigint(20) NOT NULL,
  `nome` varchar(120) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hotel_id` (`hotel_id`),
  CONSTRAINT `condominio_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condominio`
--

LOCK TABLES `condominio` WRITE;
/*!40000 ALTER TABLE `condominio` DISABLE KEYS */;
INSERT INTO `condominio` VALUES (1,1,'Condomínio Central Plaza'),(2,2,'Condomínio Pousada dos Ventos'),(3,4,'Condomínio Hotel Urbano Premium');
/*!40000 ALTER TABLE `condominio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contrato_aluguel`
--

DROP TABLE IF EXISTS `contrato_aluguel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contrato_aluguel` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `data_inicio` date NOT NULL,
  `data_fim` date NOT NULL,
  `dia_pagamento` bigint(20) NOT NULL,
  `empresa_id` bigint(20) NOT NULL,
  `numero_sala_condominio` bigint(20) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `condominio_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `empresa_id` (`empresa_id`),
  KEY `numero_sala_condominio` (`numero_sala_condominio`,`condominio_id`),
  CONSTRAINT `contrato_aluguel_ibfk_1` FOREIGN KEY (`empresa_id`) REFERENCES `empresa` (`id`),
  CONSTRAINT `contrato_aluguel_ibfk_2` FOREIGN KEY (`numero_sala_condominio`, `condominio_id`) REFERENCES `sala_condominio` (`numero`, `condominio_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contrato_aluguel`
--

LOCK TABLES `contrato_aluguel` WRITE;
/*!40000 ALTER TABLE `contrato_aluguel` DISABLE KEYS */;
INSERT INTO `contrato_aluguel` VALUES (1,'2024-11-01','2025-11-01',5,1,1,10000.00,1),(2,'2024-11-02','2025-11-02',10,2,2,11000.00,1),(3,'2024-11-03','2025-11-03',15,3,1,15000.00,2),(4,'2024-11-04','2025-11-04',20,4,1,9000.00,3),(5,'2024-11-05','2025-11-05',25,5,2,3000.00,3);
/*!40000 ALTER TABLE `contrato_aluguel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contrato_de_trabalho`
--

DROP TABLE IF EXISTS `contrato_de_trabalho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contrato_de_trabalho` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cargo` varchar(60) NOT NULL,
  `tipo_contrato_de_trabalho_id` bigint(20) NOT NULL,
  `data_inicio` date NOT NULL,
  `horas_mes` bigint(20) NOT NULL,
  `salario_mes` decimal(10,2) NOT NULL,
  `finalizado` tinyint(1) NOT NULL,
  `funcionario_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_contrato_de_trabalho_id` (`tipo_contrato_de_trabalho_id`),
  KEY `funcionario_id` (`funcionario_id`),
  CONSTRAINT `contrato_de_trabalho_ibfk_1` FOREIGN KEY (`tipo_contrato_de_trabalho_id`) REFERENCES `tipo_contrato_de_trabalho` (`id`),
  CONSTRAINT `contrato_de_trabalho_ibfk_2` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contrato_de_trabalho`
--

LOCK TABLES `contrato_de_trabalho` WRITE;
/*!40000 ALTER TABLE `contrato_de_trabalho` DISABLE KEYS */;
INSERT INTO `contrato_de_trabalho` VALUES (1,'Recepcionista',1,'2023-01-15',180,2500.00,0,1),(2,'Gerente',2,'2022-06-01',200,5000.00,0,2),(3,'Camareira',1,'2023-03-01',180,2000.00,0,3),(4,'Cozinheiro',1,'2022-12-15',180,3000.00,0,4),(5,'Garçom',1,'2023-04-01',180,2200.00,0,5),(6,'Segurança',1,'2023-02-01',180,2800.00,0,6),(7,'Manutenção',1,'2023-05-01',180,2600.00,0,7),(8,'Marketing',3,'2022-08-01',200,4000.00,0,8),(9,'Financeiro',2,'2023-01-10',200,4500.00,0,9),(10,'Limpeza',1,'2023-03-20',180,1800.00,0,10);
/*!40000 ALTER TABLE `contrato_de_trabalho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cozinha`
--

DROP TABLE IF EXISTS `cozinha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cozinha` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) NOT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `estoque_id` bigint(20) NOT NULL,
  `tamanho_em_metros` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hotel_id` (`hotel_id`),
  KEY `estoque_id` (`estoque_id`),
  CONSTRAINT `cozinha_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`),
  CONSTRAINT `cozinha_ibfk_2` FOREIGN KEY (`estoque_id`) REFERENCES `estoque` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cozinha`
--

LOCK TABLES `cozinha` WRITE;
/*!40000 ALTER TABLE `cozinha` DISABLE KEYS */;
INSERT INTO `cozinha` VALUES (1,'Cozinha Principal',1,1,70),(2,'Cozinha Gourmet',2,2,50),(3,'Cozinha Principal',3,3,55),(4,'Cozinha Local',4,4,45);
/*!40000 ALTER TABLE `cozinha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documento_identificacao`
--

DROP TABLE IF EXISTS `documento_identificacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documento_identificacao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(60) NOT NULL,
  `numero` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documento_identificacao`
--

LOCK TABLES `documento_identificacao` WRITE;
/*!40000 ALTER TABLE `documento_identificacao` DISABLE KEYS */;
INSERT INTO `documento_identificacao` VALUES (1,'PASSAPORTE','X12345678'),(2,'RG','1234567890'),(3,'CPF','98765432109'),(4,'PASSAPORTE','Y98765432'),(5,'RG','0987654321'),(6,'CPF','12345678901'),(7,'PASSAPORTE','Z87654321'),(8,'RG','5678901234'),(9,'CPF','65432109876'),(10,'PASSAPORTE','A12345678'),(11,'RG','2345678901'),(12,'CPF','34567890123'),(13,'PASSAPORTE','B87654321'),(14,'RG','6789012345'),(15,'CPF','87654321098'),(16,'PASSAPORTE','C12345678'),(17,'RG','7890123456'),(18,'CPF','45678901234'),(19,'PASSAPORTE','D98765432'),(20,'RG','8901234567'),(21,'CPF','111.222.333-44'),(22,'CNPJ','03.255.567/0004-96'),(23,'CPF','333.444.555-66'),(24,'CPF','444.555.666-77'),(25,'CPF','555.666.777-88'),(26,'CPF','666.777.888-99'),(27,'CPF','777.888.999-00'),(28,'CPF','888.999.000-11'),(29,'CNPJ','01.234.567/0001-99'),(30,'CPF','000.111.222-33'),(31,'CNPJ','12.345.678/0001-99'),(32,'CNPJ','23.456.789/0001-88'),(33,'CNPJ','34.567.890/0001-77'),(34,'CNPJ','45.678.901/0001-66'),(35,'CNPJ','56.789.012/0001-55'),(36,'CNPJ','67.890.123/0001-44'),(37,'CNPJ','78.901.234/0001-33'),(38,'CNPJ','89.012.345/0001-22');
/*!40000 ALTER TABLE `documento_identificacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `razao_social` varchar(120) NOT NULL,
  `nome_fantasia` varchar(120) NOT NULL,
  `cnpj` varchar(18) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES (1,'MC Donalds LTDA','MC Donalds','12345678000101'),(2,'MSC LTDA','MSC','23456789000112'),(3,'Coco Bambu LTDA','Coco Bambu','34567890000123'),(4,'Turismo DC LTDA','Turismo DC','45678901000134'),(5,'Bar do Zé LTDA','Bar do Zé','56789012000145');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrega`
--

DROP TABLE IF EXISTS `entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrega` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `data_hora` datetime NOT NULL,
  `reserva_id` bigint(20) NOT NULL,
  `empresa_remetente_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reserva_id` (`reserva_id`),
  KEY `empresa_remetente_id` (`empresa_remetente_id`),
  CONSTRAINT `entrega_ibfk_1` FOREIGN KEY (`reserva_id`) REFERENCES `reserva_acomodacao` (`id`),
  CONSTRAINT `entrega_ibfk_2` FOREIGN KEY (`empresa_remetente_id`) REFERENCES `empresa` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrega`
--

LOCK TABLES `entrega` WRITE;
/*!40000 ALTER TABLE `entrega` DISABLE KEYS */;
INSERT INTO `entrega` VALUES (1,'Entrega de almoço','2024-11-18 10:00:00',1,1),(2,'Entrega de alimento','2024-11-18 14:00:00',2,2),(3,'Entrega de café da manhã','2024-11-19 09:00:00',3,3),(4,'Entrega de bebidas','2024-11-19 16:30:00',4,4),(5,'Entrega de presentes','2024-11-20 11:00:00',5,5),(6,'Entrega de itens decorativos','2024-11-20 15:00:00',6,2),(7,'Entrega de eletrônicos','2024-11-21 08:30:00',7,3),(8,'Entrega de materiais de escritório','2024-11-21 13:00:00',8,1),(9,'Entrega de frutas e legumes','2024-11-22 07:00:00',9,4);
/*!40000 ALTER TABLE `entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `espaco_de_evento`
--

DROP TABLE IF EXISTS `espaco_de_evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `espaco_de_evento` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hotel_id` bigint(20) NOT NULL,
  `tamanho_em_metros_total` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hotel_id` (`hotel_id`),
  CONSTRAINT `espaco_de_evento_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `espaco_de_evento`
--

LOCK TABLES `espaco_de_evento` WRITE;
/*!40000 ALTER TABLE `espaco_de_evento` DISABLE KEYS */;
INSERT INTO `espaco_de_evento` VALUES (1,1,700),(2,2,500),(3,3,450),(4,4,600);
/*!40000 ALTER TABLE `espaco_de_evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estacionamento`
--

DROP TABLE IF EXISTS `estacionamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estacionamento` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(60) NOT NULL,
  `capacidade` bigint(20) NOT NULL,
  `valor_diaria` decimal(10,2) NOT NULL,
  `hotel_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hotel_id` (`hotel_id`),
  CONSTRAINT `estacionamento_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estacionamento`
--

LOCK TABLES `estacionamento` WRITE;
/*!40000 ALTER TABLE `estacionamento` DISABLE KEYS */;
INSERT INTO `estacionamento` VALUES (1,'COBERTO',50,25.00,1),(2,'AR_LIVRE',100,15.00,2),(3,'COBERTO',100,15.00,2),(4,'COBERTO',20,50.00,3),(5,'COBERTO',30,20.00,4),(6,'AR_LIVRE',70,15.00,4);
/*!40000 ALTER TABLE `estacionamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoque`
--

DROP TABLE IF EXISTS `estoque`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoque` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `capacidade` bigint(20) NOT NULL,
  `data_atualizacao` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque`
--

LOCK TABLES `estoque` WRITE;
/*!40000 ALTER TABLE `estoque` DISABLE KEYS */;
INSERT INTO `estoque` VALUES (1,2000,'2024-11-01 10:00:00'),(2,2500,'2024-11-01 11:00:00'),(3,1800,'2024-11-01 12:00:00'),(4,2200,'2024-11-01 13:00:00');
/*!40000 ALTER TABLE `estoque` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estoque_produto`
--

DROP TABLE IF EXISTS `estoque_produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estoque_produto` (
  `produto_id` bigint(20) NOT NULL,
  `estoque_id` bigint(20) NOT NULL,
  `quantidade` bigint(20) NOT NULL,
  PRIMARY KEY (`produto_id`,`estoque_id`),
  KEY `estoque_id` (`estoque_id`),
  CONSTRAINT `estoque_produto_ibfk_1` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`),
  CONSTRAINT `estoque_produto_ibfk_2` FOREIGN KEY (`estoque_id`) REFERENCES `estoque` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estoque_produto`
--

LOCK TABLES `estoque_produto` WRITE;
/*!40000 ALTER TABLE `estoque_produto` DISABLE KEYS */;
INSERT INTO `estoque_produto` VALUES (1,1,50),(2,1,60),(3,1,40),(4,1,30),(5,1,20),(6,1,10),(7,1,70),(8,1,80),(9,1,25),(10,1,15),(11,2,100),(12,2,90),(13,2,110),(14,2,120),(15,2,130),(16,2,140),(17,2,150),(18,2,160),(19,2,170),(20,2,180),(21,3,60),(22,3,70),(23,3,80),(24,3,90),(25,3,100),(26,3,110),(27,3,120),(28,3,130),(29,3,140),(30,3,150),(31,4,200),(32,4,190),(33,4,180),(34,4,170),(35,4,160),(36,4,150),(37,4,140),(38,4,130),(39,4,120),(40,4,110);
/*!40000 ALTER TABLE `estoque_produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcionario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pessoa_id` bigint(20) NOT NULL,
  `email` varchar(120) NOT NULL,
  `hotel_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pessoa_id` (`pessoa_id`),
  KEY `hotel_id` (`hotel_id`),
  CONSTRAINT `funcionario_ibfk_1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`),
  CONSTRAINT `funcionario_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` VALUES (1,21,'joao.silva@hotel.com',1),(2,22,'maria.oliveira@hotel.com',1),(3,23,'carlos.souza@hotel.com',2),(4,24,'ana.santos@hotel.com',2),(5,25,'pedro.lima@hotel.com',3),(6,26,'fernanda.costa@hotel.com',3),(7,27,'lucas.almeida@hotel.com',4),(8,28,'juliana.martins@hotel.com',4),(9,29,'gabriel.rocha@hotel.com',1),(10,30,'patricia.mendes@hotel.com',4);
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `georreferenciamento`
--

DROP TABLE IF EXISTS `georreferenciamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `georreferenciamento` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `georreferenciamento`
--

LOCK TABLES `georreferenciamento` WRITE;
/*!40000 ALTER TABLE `georreferenciamento` DISABLE KEYS */;
INSERT INTO `georreferenciamento` VALUES (1,-23.55052000,-46.63330800),(2,-22.90684700,-43.17289700),(3,-15.78014800,-47.92917000),(4,-12.97143100,-38.50140000),(5,-25.42835600,-49.27325100);
/*!40000 ALTER TABLE `georreferenciamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospede`
--

DROP TABLE IF EXISTS `hospede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hospede` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pessoa_id` bigint(20) NOT NULL,
  `data_registro` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pessoa_id` (`pessoa_id`),
  CONSTRAINT `hospede_ibfk_1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospede`
--

LOCK TABLES `hospede` WRITE;
/*!40000 ALTER TABLE `hospede` DISABLE KEYS */;
INSERT INTO `hospede` VALUES (1,1,'2024-11-01 14:23:00'),(2,2,'2024-11-01 15:45:00'),(3,3,'2024-11-02 09:15:00'),(4,4,'2024-11-02 10:30:00'),(5,5,'2024-11-02 11:45:00'),(6,6,'2024-11-02 12:30:00'),(7,7,'2024-11-03 08:15:00'),(8,8,'2024-11-03 09:45:00'),(9,9,'2024-11-03 10:00:00'),(10,10,'2024-11-03 11:20:00'),(11,11,'2024-11-04 12:40:00'),(12,12,'2024-11-04 13:50:00'),(13,13,'2024-11-04 15:00:00'),(14,14,'2024-11-05 08:10:00'),(15,15,'2024-11-05 09:20:00'),(16,16,'2024-11-05 10:30:00'),(17,17,'2024-11-05 11:40:00'),(18,18,'2024-11-06 07:30:00'),(19,19,'2024-11-06 08:45:00'),(20,20,'2024-11-06 09:55:00');
/*!40000 ALTER TABLE `hospede` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel`
--

DROP TABLE IF EXISTS `hotel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome_fantasia` varchar(120) NOT NULL,
  `setor` varchar(60) NOT NULL,
  `tamanho` bigint(20) NOT NULL,
  `is_central` tinyint(1) NOT NULL,
  `categoria` varchar(60) NOT NULL,
  `registro_imobiliario_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `registro_imobiliario_id` (`registro_imobiliario_id`),
  CONSTRAINT `hotel_ibfk_1` FOREIGN KEY (`registro_imobiliario_id`) REFERENCES `registro_imobiliario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel`
--

LOCK TABLES `hotel` WRITE;
/*!40000 ALTER TABLE `hotel` DISABLE KEYS */;
INSERT INTO `hotel` VALUES (1,'Hotel Central Plaza','FAMILIA',3000,1,'TRADICIONAL',1),(2,'Pousada dos Ventos','FAMILIA',1200,0,'TRADICIONAL',2),(3,'Resort Sol e Mar','ADULTOS',5000,0,'RESORT',3),(4,'Hotel Urbano Premium','ADULTOS',2500,1,'POUSADA',4);
/*!40000 ALTER TABLE `hotel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `local_evento`
--

DROP TABLE IF EXISTS `local_evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `local_evento` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo_de_espaco` varchar(60) NOT NULL,
  `tipo_de_uso_id` bigint(20) NOT NULL,
  `capacidade` bigint(20) NOT NULL,
  `tamanho_em_metros` bigint(20) NOT NULL,
  `espaco_evento_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `espaco_evento_id` (`espaco_evento_id`),
  KEY `tipo_de_uso_id` (`tipo_de_uso_id`),
  CONSTRAINT `local_evento_ibfk_1` FOREIGN KEY (`espaco_evento_id`) REFERENCES `espaco_de_evento` (`id`),
  CONSTRAINT `local_evento_ibfk_2` FOREIGN KEY (`tipo_de_uso_id`) REFERENCES `tipo_de_uso` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local_evento`
--

LOCK TABLES `local_evento` WRITE;
/*!40000 ALTER TABLE `local_evento` DISABLE KEYS */;
INSERT INTO `local_evento` VALUES (1,'Salão Principal',1,200,50,1),(2,'Sala VIP',2,50,60,1),(3,'Auditório',3,300,75,2),(4,'Sala de Reunião',4,20,55,2),(5,'Espaço ao Ar Livre',5,150,120,3),(6,'Teatro',7,400,100,3),(7,'Palco Aberto',9,100,80,4),(8,'Sala de Palestra',10,120,70,4);
/*!40000 ALTER TABLE `local_evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `local_evento_manutencao`
--

DROP TABLE IF EXISTS `local_evento_manutencao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `local_evento_manutencao` (
  `local_evento_id` bigint(20) NOT NULL,
  `manutencao_id` bigint(20) NOT NULL,
  PRIMARY KEY (`local_evento_id`,`manutencao_id`),
  KEY `manutencao_id` (`manutencao_id`),
  CONSTRAINT `local_evento_manutencao_ibfk_1` FOREIGN KEY (`local_evento_id`) REFERENCES `local_evento` (`id`),
  CONSTRAINT `local_evento_manutencao_ibfk_2` FOREIGN KEY (`manutencao_id`) REFERENCES `manutencao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local_evento_manutencao`
--

LOCK TABLES `local_evento_manutencao` WRITE;
/*!40000 ALTER TABLE `local_evento_manutencao` DISABLE KEYS */;
INSERT INTO `local_evento_manutencao` VALUES (1,1),(2,2),(1,3),(1,4),(1,5);
/*!40000 ALTER TABLE `local_evento_manutencao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manutencao`
--

DROP TABLE IF EXISTS `manutencao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manutencao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `data_hora_inicio` datetime NOT NULL,
  `data_hora_fim` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manutencao`
--

LOCK TABLES `manutencao` WRITE;
/*!40000 ALTER TABLE `manutencao` DISABLE KEYS */;
INSERT INTO `manutencao` VALUES (1,'Troca de encanamento','2024-11-10 08:00:00','2024-11-10 12:00:00'),(2,'Revisão elétrica','2024-11-11 09:00:00','2024-11-11 15:00:00'),(3,'Pintura externa','2024-11-12 08:00:00','2024-11-12 18:00:00'),(4,'Reforma no telhado','2024-11-13 07:00:00','2024-11-13 19:00:00'),(5,'Manutenção de ar-condicionado','2024-11-14 10:00:00','2024-11-14 14:00:00');
/*!40000 ALTER TABLE `manutencao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nota_fiscal`
--

DROP TABLE IF EXISTS `nota_fiscal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nota_fiscal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `numero` varchar(60) NOT NULL,
  `data_emissao` date NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `documento_emissor_id` bigint(20) NOT NULL,
  `documento_destinatario_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `documento_emissor_id` (`documento_emissor_id`),
  KEY `documento_destinatario_id` (`documento_destinatario_id`),
  CONSTRAINT `nota_fiscal_ibfk_1` FOREIGN KEY (`documento_emissor_id`) REFERENCES `documento_identificacao` (`id`),
  CONSTRAINT `nota_fiscal_ibfk_2` FOREIGN KEY (`documento_destinatario_id`) REFERENCES `documento_identificacao` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nota_fiscal`
--

LOCK TABLES `nota_fiscal` WRITE;
/*!40000 ALTER TABLE `nota_fiscal` DISABLE KEYS */;
INSERT INTO `nota_fiscal` VALUES (1,'NF-1001','2024-11-01',5000.00,31,35),(2,'NF-1002','2024-11-02',1500.00,31,35),(3,'NF-1003','2024-11-03',8000.00,32,35),(4,'NF-1004','2024-11-04',12000.00,33,36),(5,'NF-1005','2024-11-05',2500.00,34,36),(6,'NF-1006','2024-11-06',3000.00,31,36),(7,'NF-1007','2024-11-07',7000.00,32,37),(8,'NF-1008','2024-11-08',4500.00,33,37),(9,'NF-1009','2024-11-09',3500.00,34,38),(10,'NF-1010','2024-11-10',6200.00,31,38);
/*!40000 ALTER TABLE `nota_fiscal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(120) NOT NULL,
  `descricao` varchar(120) NOT NULL,
  `nota_fiscal_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nota_fiscal_id` (`nota_fiscal_id`),
  CONSTRAINT `pagamento_ibfk_1` FOREIGN KEY (`nota_fiscal_id`) REFERENCES `nota_fiscal` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
INSERT INTO `pagamento` VALUES (1,'Pagamento Governo','Pagamento referente a impostos municipais',1),(2,'Pagamento Associação','Pagamento de taxas de associação empresarial',2),(3,'Pagamento Terceiro','Pagamento de serviços de terceiros para manutenção',3),(4,'Pagamento Fornecedor','Pagamento de fornecedores de material',4),(5,'Pagamento Governo','Pagamento referente a impostos estaduais',5),(6,'Pagamento Associação','Pagamento de taxa de associação comercial',6),(7,'Pagamento Terceiro','Pagamento de serviços de segurança terceirizados',7),(8,'Pagamento Fornecedor','Pagamento de fornecedor de tecnologia',8),(9,'Pagamento Governo','Pagamento de contribuições federais',9),(10,'Pagamento Associação','Pagamento de taxas associativas regionais',10);
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data_hora` datetime NOT NULL,
  `reserva_acomodacao_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reserva_acomodacao_id` (`reserva_acomodacao_id`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`reserva_acomodacao_id`) REFERENCES `reserva_acomodacao` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,'Café da manhã',30.00,'2024-11-01 07:30:00',1),(2,'Almoço',50.00,'2024-11-01 12:00:00',1),(3,'Serviço de quarto',40.00,'2024-11-01 20:00:00',1),(4,'Café da manhã',30.00,'2024-11-02 07:30:00',2),(5,'Almoço',50.00,'2024-11-02 12:00:00',2),(6,'Serviço de quarto',40.00,'2024-11-02 20:00:00',2),(7,'Café da manhã',30.00,'2024-11-04 07:30:00',3),(8,'Almoço',50.00,'2024-11-04 12:00:00',3),(9,'Serviço de quarto',40.00,'2024-11-04 20:00:00',3),(10,'Café da manhã',30.00,'2024-11-05 07:30:00',4);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pessoa`
--

DROP TABLE IF EXISTS `pessoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pessoa` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `data_nascimento` date NOT NULL,
  `celular` varchar(20) NOT NULL,
  `email` varchar(120) NOT NULL,
  `sexo` varchar(30) NOT NULL,
  `documento_identificacao_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `documento_identificacao_id` (`documento_identificacao_id`),
  CONSTRAINT `pessoa_ibfk_1` FOREIGN KEY (`documento_identificacao_id`) REFERENCES `documento_identificacao` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pessoa`
--

LOCK TABLES `pessoa` WRITE;
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` VALUES (1,'João Silva','1985-03-15','11987654321','joao.silva@gmail.com','MASCULINO',1),(2,'Maria Oliveira','1992-07-23','11998765432','maria.oliveira@gmail.com','FEMININO',2),(3,'Carlos Souza','1978-11-05','11987651234','carlos.souza@gmail.com','MASCULINO',3),(4,'Ana Costa','1990-02-28','11987654322','ana.costa@gmail.com','FEMININO',4),(5,'Pedro Santos','1983-05-12','11987654323','pedro.santos@gmail.com','MASCULINO',5),(6,'Julia Mendes','1995-09-18','11987654324','julia.mendes@gmail.com','FEMININO',6),(7,'Bruno Lima','1989-08-04','11987654325','bruno.lima@gmail.com','MASCULINO',7),(8,'Renata Araújo','1982-12-14','11987654326','renata.araujo@gmail.com','FEMININO',8),(9,'Fernando Almeida','1975-10-27','11987654327','fernando.almeida@gmail.com','MASCULINO',9),(10,'Luiza Rocha','1997-01-30','11987654328','luiza.rocha@gmail.com','FEMININO',10),(11,'Gabriel Reis','1981-04-17','11987654329','gabriel.reis@gmail.com','MASCULINO',11),(12,'Tatiana Gomes','1994-06-09','11987654330','tatiana.gomes@gmail.com','FEMININO',12),(13,'Ricardo Barbosa','1979-09-20','11987654331','ricardo.barbosa@gmail.com','MASCULINO',13),(14,'Carolina Mello','1991-03-22','11987654332','carolina.mello@gmail.com','FEMININO',14),(15,'Gustavo Pereira','1987-07-15','11987654333','gustavo.pereira@gmail.com','MASCULINO',15),(16,'Patricia Silva','1993-12-29','11987654334','patricia.silva@gmail.com','FEMININO',16),(17,'André Fernandes','1980-11-01','11987654335','andre.fernandes@gmail.com','MASCULINO',17),(18,'Beatriz Ribeiro','1996-10-11','11987654336','beatriz.ribeiro@gmail.com','FEMININO',18),(19,'Felipe Matos','1984-08-08','11987654337','felipe.matos@gmail.com','MASCULINO',19),(20,'Sofia Martins','1998-02-25','11987654338','sofia.martins@gmail.com','FEMININO',20),(21,'João Silva','1990-05-12','123456789','joao.silva@gmail.com','FEMININO',21),(22,'Maria Oliveira','1985-08-25','987654321','maria.oliveira@gmail.com','FEMININO',22),(23,'Carlos Souza','1993-02-18','123123123','carlos.souza@gmail.com','MASCULINO',23),(24,'Ana Santos','1998-07-30','321321321','ana.santos@gmail.com','FEMININO',24),(25,'Pedro Lima','1987-03-05','555555555','pedro.lima@gmail.com','MASCULINO',25),(26,'Fernanda Costa','1991-11-12','666666666','fernanda.costa@gmail.com','FEMININO',26),(27,'Lucas Almeida','1994-09-23','777777777','lucas.almeida@gmail.com','MASCULINO',27),(28,'Juliana Martins','1989-01-15','888888888','juliana.martins@gmail.com','FEMININO',28),(29,'Gabriel Rocha','1992-06-17','999999999','gabriel.rocha@gmail.com','MASCULINO',29),(30,'Patrícia Mendes','1986-12-01','101010101','patricia.mendes@gmail.com','FEMININO',30);
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plano_de_saude`
--

DROP TABLE IF EXISTS `plano_de_saude`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plano_de_saude` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  `cnpj_fornecedor` varchar(18) NOT NULL,
  `valor_mensal` decimal(10,2) NOT NULL,
  `possui_coparticipacao` tinyint(1) NOT NULL,
  `tipo_contrato_beneficiario_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_contrato_beneficiario_id` (`tipo_contrato_beneficiario_id`),
  CONSTRAINT `plano_de_saude_ibfk_1` FOREIGN KEY (`tipo_contrato_beneficiario_id`) REFERENCES `tipo_contrato_de_trabalho` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plano_de_saude`
--

LOCK TABLES `plano_de_saude` WRITE;
/*!40000 ALTER TABLE `plano_de_saude` DISABLE KEYS */;
INSERT INTO `plano_de_saude` VALUES (1,'Amil Básico','12.345.678/0001-99',350.00,0,2),(2,'Amil Premium','12.345.678/0001-99',650.00,1,1);
/*!40000 ALTER TABLE `plano_de_saude` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `politica_de_uso`
--

DROP TABLE IF EXISTS `politica_de_uso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `politica_de_uso` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  `descricao` varchar(120) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `politica_de_uso`
--

LOCK TABLES `politica_de_uso` WRITE;
/*!40000 ALTER TABLE `politica_de_uso` DISABLE KEYS */;
INSERT INTO `politica_de_uso` VALUES (1,'Política de Cancelamento','Cancelamento gratuito até 24 horas antes do check-in'),(2,'Política de Fumantes','Proibido fumar dentro das acomodações'),(3,'Política de Animais','Permitido animais de pequeno porte com taxa adicional'),(4,'Política de Silêncio','Horário de silêncio entre 22h e 7h'),(5,'Política de Limpeza','Limpeza diária incluída na diária'),(6,'Política de Visitantes','Visitantes permitidos até 22h'),(7,'Política de Check-in Antecipado','Check-in antecipado sujeito à disponibilidade e taxa extra'),(8,'Política de Check-out Tardio','Check-out tardio sujeito à disponibilidade e taxa extra');
/*!40000 ALTER TABLE `politica_de_uso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) NOT NULL,
  `marca` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (1,'Arroz','Marca A'),(2,'Feijão','Marca B'),(3,'Açúcar','Marca C'),(4,'Óleo','Marca D'),(5,'Macarrão','Marca E'),(6,'Farinha','Marca F'),(7,'Sal','Marca G'),(8,'Pimenta','Marca H'),(9,'Café','Marca I'),(10,'Chá','Marca J'),(11,'Leite','Marca K'),(12,'Manteiga','Marca L'),(13,'Presunto','Marca M'),(14,'Queijo','Marca N'),(15,'Tomate','Marca O'),(16,'Alface','Marca P'),(17,'Cebola','Marca Q'),(18,'Alho','Marca R'),(19,'Batata','Marca S'),(20,'Cenoura','Marca T'),(21,'Banana','Marca U'),(22,'Maçã','Marca V'),(23,'Laranja','Marca W'),(24,'Melancia','Marca X'),(25,'Uva','Marca Y'),(26,'Limão','Marca Z'),(27,'Frango','Marca AA'),(28,'Carne','Marca AB'),(29,'Peixe','Marca AC'),(30,'Ovos','Marca AD'),(31,'Iogurte','Marca AE'),(32,'Suco','Marca AF'),(33,'Água','Marca AG'),(34,'Refrigerante','Marca AH'),(35,'Chocolate','Marca AI'),(36,'Biscoitos','Marca AJ'),(37,'Pão','Marca AK'),(38,'Pizza','Marca AL'),(39,'Salgadinhos','Marca AM'),(40,'Molho de tomate','Marca AN');
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registro_imobiliario`
--

DROP TABLE IF EXISTS `registro_imobiliario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro_imobiliario` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `numero_registro_prefeitura` varchar(60) NOT NULL,
  `data_registro` date NOT NULL,
  `georreferenciamento_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `georreferenciamento_id` (`georreferenciamento_id`),
  CONSTRAINT `registro_imobiliario_ibfk_1` FOREIGN KEY (`georreferenciamento_id`) REFERENCES `georreferenciamento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registro_imobiliario`
--

LOCK TABLES `registro_imobiliario` WRITE;
/*!40000 ALTER TABLE `registro_imobiliario` DISABLE KEYS */;
INSERT INTO `registro_imobiliario` VALUES (1,'REG12345','2022-05-10',1),(2,'REG67890','2021-11-23',2),(3,'REG54321','2020-07-15',3),(4,'REG09876','2019-03-18',4),(5,'REG11223','2023-01-25',5);
/*!40000 ALTER TABLE `registro_imobiliario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva_acomodacao`
--

DROP TABLE IF EXISTS `reserva_acomodacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva_acomodacao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `data_esperada_checkin` datetime NOT NULL,
  `data_esperada_checkout` datetime NOT NULL,
  `data_checkin` datetime DEFAULT NULL,
  `data_checkout` datetime DEFAULT NULL,
  `numero_acomodacao` bigint(20) NOT NULL,
  `hotel_id` bigint(20) NOT NULL,
  `hospede_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `numero_acomodacao` (`numero_acomodacao`,`hotel_id`),
  KEY `hospede_id` (`hospede_id`),
  CONSTRAINT `reserva_acomodacao_ibfk_1` FOREIGN KEY (`numero_acomodacao`, `hotel_id`) REFERENCES `acomodacao` (`numero`, `hotel_id`),
  CONSTRAINT `reserva_acomodacao_ibfk_2` FOREIGN KEY (`hospede_id`) REFERENCES `hospede` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva_acomodacao`
--

LOCK TABLES `reserva_acomodacao` WRITE;
/*!40000 ALTER TABLE `reserva_acomodacao` DISABLE KEYS */;
INSERT INTO `reserva_acomodacao` VALUES (1,'2024-11-01 14:00:00','2024-11-03 12:00:00','2024-11-01 15:00:00','2024-11-03 11:30:00',1,1,1),(2,'2024-11-02 14:00:00','2024-11-05 12:00:00','2024-11-02 14:30:00','2024-11-05 12:00:00',2,1,2),(3,'2024-11-04 14:00:00','2024-11-06 12:00:00','2024-11-04 14:15:00','2024-11-06 14:15:00',3,2,3),(4,'2024-11-05 14:00:00','2024-11-07 12:00:00',NULL,NULL,1,2,4),(5,'2024-11-06 14:00:00','2024-11-08 12:00:00','2024-11-06 14:05:00','2024-11-06 14:05:00',2,3,5),(6,'2024-11-07 14:00:00','2024-11-09 12:00:00',NULL,NULL,1,3,6),(7,'2024-11-08 14:00:00','2024-11-10 12:00:00','2024-11-08 15:00:00','2024-11-10 11:45:00',5,4,7),(8,'2024-11-09 14:00:00','2024-11-11 12:00:00','2024-11-09 14:45:00','2024-11-11 14:45:00',6,4,8),(9,'2024-11-10 14:00:00','2024-11-12 12:00:00','2024-11-10 15:00:00','2024-11-12 11:50:00',6,1,9),(10,'2024-11-28 14:00:00','2024-12-02 12:00:00',NULL,NULL,1,1,10),(11,'2024-11-29 14:00:00','2024-12-03 12:00:00',NULL,NULL,2,1,11),(12,'2024-11-30 14:00:00','2024-12-04 12:00:00',NULL,NULL,3,1,12),(13,'2024-12-01 14:00:00','2024-12-05 12:00:00',NULL,NULL,4,2,13),(14,'2024-12-02 14:00:00','2024-12-06 12:00:00',NULL,NULL,5,2,14),(15,'2024-12-03 14:00:00','2024-12-07 12:00:00',NULL,NULL,6,2,15),(16,'2024-12-04 14:00:00','2024-12-08 12:00:00',NULL,NULL,7,3,16),(17,'2024-12-05 14:00:00','2024-12-09 12:00:00',NULL,NULL,8,1,17),(18,'2024-12-06 14:00:00','2024-12-10 12:00:00',NULL,NULL,9,1,18),(19,'2024-12-07 14:00:00','2024-12-11 12:00:00',NULL,NULL,10,4,19),(20,'2024-01-01 11:00:00','2024-01-03 15:00:00',NULL,NULL,1,1,1);
/*!40000 ALTER TABLE `reserva_acomodacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva_estacionamento`
--

DROP TABLE IF EXISTS `reserva_estacionamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva_estacionamento` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `data_checkin` date NOT NULL,
  `data_checkout` date NOT NULL,
  `reserva_acomodacao_id` bigint(20) NOT NULL,
  `estacionamento_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reserva_acomodacao_id` (`reserva_acomodacao_id`),
  KEY `estacionamento_id` (`estacionamento_id`),
  CONSTRAINT `reserva_estacionamento_ibfk_1` FOREIGN KEY (`reserva_acomodacao_id`) REFERENCES `reserva_acomodacao` (`id`),
  CONSTRAINT `reserva_estacionamento_ibfk_2` FOREIGN KEY (`estacionamento_id`) REFERENCES `estacionamento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva_estacionamento`
--

LOCK TABLES `reserva_estacionamento` WRITE;
/*!40000 ALTER TABLE `reserva_estacionamento` DISABLE KEYS */;
INSERT INTO `reserva_estacionamento` VALUES (1,'2024-11-01','2024-11-03',1,1),(2,'2024-11-02','2024-11-05',2,1),(3,'2024-11-04','2024-11-06',3,2),(4,'2024-11-05','2024-11-07',4,3),(5,'2024-11-06','2024-11-08',5,4),(6,'2024-11-07','2024-11-09',6,5),(7,'2024-11-08','2024-11-10',7,6),(8,'2024-11-09','2024-11-11',8,1),(9,'2024-11-10','2024-11-12',9,3),(10,'2024-11-11','2024-11-13',10,6);
/*!40000 ALTER TABLE `reserva_estacionamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sala_condominio`
--

DROP TABLE IF EXISTS `sala_condominio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sala_condominio` (
  `numero` bigint(20) NOT NULL,
  `condominio_id` bigint(20) NOT NULL,
  `metros_quadrados` bigint(20) NOT NULL,
  PRIMARY KEY (`numero`,`condominio_id`),
  KEY `condominio_id` (`condominio_id`),
  CONSTRAINT `sala_condominio_ibfk_1` FOREIGN KEY (`condominio_id`) REFERENCES `condominio` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sala_condominio`
--

LOCK TABLES `sala_condominio` WRITE;
/*!40000 ALTER TABLE `sala_condominio` DISABLE KEYS */;
INSERT INTO `sala_condominio` VALUES (1,1,50),(1,2,40),(1,3,30),(2,1,60),(2,2,50),(2,3,40),(3,1,70),(3,2,60),(3,3,50),(4,1,80),(4,2,70),(4,3,60),(5,1,90),(5,2,80),(5,3,70);
/*!40000 ALTER TABLE `sala_condominio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sala_condominio_manutencao`
--

DROP TABLE IF EXISTS `sala_condominio_manutencao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sala_condominio_manutencao` (
  `numero_sala_condominio` bigint(20) NOT NULL,
  `condominio_id` bigint(20) NOT NULL,
  `manutencao_id` bigint(20) NOT NULL,
  PRIMARY KEY (`numero_sala_condominio`,`condominio_id`,`manutencao_id`),
  KEY `manutencao_id` (`manutencao_id`),
  CONSTRAINT `sala_condominio_manutencao_ibfk_1` FOREIGN KEY (`numero_sala_condominio`, `condominio_id`) REFERENCES `sala_condominio` (`numero`, `condominio_id`),
  CONSTRAINT `sala_condominio_manutencao_ibfk_2` FOREIGN KEY (`manutencao_id`) REFERENCES `manutencao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sala_condominio_manutencao`
--

LOCK TABLES `sala_condominio_manutencao` WRITE;
/*!40000 ALTER TABLE `sala_condominio_manutencao` DISABLE KEYS */;
INSERT INTO `sala_condominio_manutencao` VALUES (1,1,1),(2,1,2),(1,2,3),(1,3,4),(1,3,5);
/*!40000 ALTER TABLE `sala_condominio_manutencao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_contrato_de_trabalho`
--

DROP TABLE IF EXISTS `tipo_contrato_de_trabalho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_contrato_de_trabalho` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_contrato_de_trabalho`
--

LOCK TABLES `tipo_contrato_de_trabalho` WRITE;
/*!40000 ALTER TABLE `tipo_contrato_de_trabalho` DISABLE KEYS */;
INSERT INTO `tipo_contrato_de_trabalho` VALUES (1,'CLT'),(2,'PJ'),(3,'Estágio');
/*!40000 ALTER TABLE `tipo_contrato_de_trabalho` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_de_uso`
--

DROP TABLE IF EXISTS `tipo_de_uso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_de_uso` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) NOT NULL,
  `descricao` varchar(120) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_de_uso`
--

LOCK TABLES `tipo_de_uso` WRITE;
/*!40000 ALTER TABLE `tipo_de_uso` DISABLE KEYS */;
INSERT INTO `tipo_de_uso` VALUES (1,'Casamento','Eventos de celebração matrimonial'),(2,'Festa de Aniversário','Comemorações de aniversários'),(3,'Formatura','Celebrações de conclusão de cursos'),(4,'Reunião Corporativa','Reuniões de negócios e apresentações'),(5,'Treinamento','Espaço para workshops e treinamentos'),(6,'Feira de Exposições','Feiras e exposições comerciais'),(7,'Lançamento de Produto','Eventos de lançamento de novos produtos'),(8,'Conferência','Conferências e seminários'),(9,'Show Musical','Apresentações musicais e culturais'),(10,'Palestra','Eventos educativos e informativos');
/*!40000 ALTER TABLE `tipo_de_uso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vale`
--

DROP TABLE IF EXISTS `vale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vale` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(60) NOT NULL,
  `descricao` varchar(120) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data_hora` datetime NOT NULL,
  `percentual_de_desconto` decimal(10,2) NOT NULL,
  `tipo_contrato_beneficiario_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_contrato_beneficiario_id` (`tipo_contrato_beneficiario_id`),
  CONSTRAINT `vale_ibfk_1` FOREIGN KEY (`tipo_contrato_beneficiario_id`) REFERENCES `tipo_contrato_de_trabalho` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vale`
--

LOCK TABLES `vale` WRITE;
/*!40000 ALTER TABLE `vale` DISABLE KEYS */;
INSERT INTO `vale` VALUES (1,'Alimentação','Vale para compras em supermercados',800.00,'2024-01-10 09:00:00',3.00,1),(2,'Alimentação','Vale para compras em supermercados',300.00,'2024-01-10 09:00:00',3.00,3),(3,'Transporte','Vale transporte mensal para deslocamento urbano',300.00,'2024-01-15 08:30:00',2.00,1),(4,'Transporte','Vale transporte mensal para deslocamento urbano',250.00,'2024-01-15 08:30:00',2.00,2),(5,'Transporte','Vale transporte mensal para deslocamento urbano',300.00,'2024-01-15 08:30:00',0.00,3),(6,'Refeição','Vale refeição para uso em restaurantes',600.00,'2024-01-20 12:00:00',3.00,1),(7,'Refeição','Vale refeição para uso em restaurantes',600.00,'2024-01-20 12:00:00',3.00,3);
/*!40000 ALTER TABLE `vale` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-17 20:58:08
