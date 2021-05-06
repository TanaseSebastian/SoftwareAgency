DROP DATABASE if exists softwarehouse;
CREATE DATABASE softwarehouse;
USE softwarehouse;

CREATE TABLE DIPARTIMENTI (
  codDipartimento int NOT NULL AUTO_INCREMENT,
  nome varchar(50) NOT NULL,
  phone char(10) NOT NULL,
  descrizione varchar(200) NOT NULL,
  PRIMARY KEY (codDipartimento)
);

CREATE TABLE DIPENDENTI (
  codiceDipendente int NOT NULL AUTO_INCREMENT,
  cf char(16) NOT NULL unique,
  nome varchar(50) NOT NULL,
  cognome varchar(50) NOT NULL,
  username varchar(50) NOT NULL unique,
  email varchar(50) NOT NULL unique,
  phone char(10),
  psw varchar(128) ,
  qualificaProfessionale set ('Dirigente','Responsabile','Impiegato','Operaio') NOT NULL,
  nomeProfessione varchar(50),
  dataAssunzione date NOT NULL default current_timestamp,
  dataNascita date,
  provincia char(2),
  stipendio varchar(50) NOT NULL,
  anniAnzianita int default 0,
  amministratore char(1) NOT NULL default "N",
  codDipartimento INT NOT NULL,
  immagineProfilo varchar(255),
  codiceRegistrazione varchar(128),
  PRIMARY KEY (codiceDipendente),
  FOREIGN KEY (codDipartimento) REFERENCES DIPARTIMENTI(codDipartimento) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE SOFTWARE (
  codSoftware int NOT NULL AUTO_INCREMENT,
  codResponsabile int NOT NULL,
  nome varchar(50) NOT NULL,
  descrizione varchar(200) NOT NULL,
  tempoGiorniUomo INT NOT NULL,
  costo decimal(8,2) NOT NULL,
  PRIMARY KEY (codSoftware),
   CONSTRAINT codResponsabile FOREIGN KEY (codResponsabile) REFERENCES DIPENDENTI (codiceDipendente) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE LAVORAZIONI (
  codLavorazione int NOT NULL AUTO_INCREMENT,
  codSoftware int NOT NULL,
  nome varchar(50) NOT NULL,
  descrizione varchar(250) DEFAULT NULL,
  dataInizio datetime NOT NULL,
  dataFine datetime ,
  stato varchar(50) NOT NULL DEFAULT "In lavorazione",
  PRIMARY KEY (codLavorazione),
  CONSTRAINT codSoftware FOREIGN KEY (codSoftware) REFERENCES SOFTWARE (codSoftware) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE PERSONALE_COINVOLTO(
 codLavorazione INT NOT NULL ,
 codDipendente INT NOT NULL ,
 dataInzio DATE NOT NULL ,
 dataFine DATE NOT NULL,
 PRIMARY KEY (codLavorazione, codDipendente),
CONSTRAINT codDipendente FOREIGN KEY (codDipendente) REFERENCES dipendenti(codiceDipendente) ON DELETE CASCADE ON UPDATE CASCADE,  
CONSTRAINT codLavorazione FOREIGN KEY (codLavorazione) REFERENCES lavorazioni(codLavorazione) ON DELETE CASCADE ON UPDATE CASCADE
); 


CREATE TABLE CLIENTI(
codCliente int(11) NOT NULL,
nome varchar(50) NOT NULL,
indirizzo varchar(45) NOT NULL,
ragioneSociale varchar(45) NOT NULL,
partitaIva varchar(45) NOT NULL,
codiceRegistrazione varchar(128),
pws varchar(128),
PRIMARY KEY (codCliente)
);

 CREATE TABLE ORDINI (
codOrdine INT NOT NULL AUTO_INCREMENT ,
codSoftware INT NOT NULL ,
codCliente INT NOT NULL ,
dataOrdine DATE NOT NULL ,
contratto BLOB NOT NULL ,
fattura BLOB NOT NULL ,
PRIMARY KEY (codOrdine),
FOREIGN KEY (codSoftware) REFERENCES `software`(`codSoftware`),
FOREIGN KEY (codCliente) REFERENCES `clienti`(`codCliente`)
); 


-- ALTER TABLE `utenti` ADD `image` VARCHAR(255) NULL DEFAULT 'undraw_profile.svg' AFTER `AMMINISTRATORE`; 

-- -- prima query con metodo annidamento
--   SELECT * FROM dipendenti
--   WHERE dipendenti.codiceDipendente IN 
--  (select personale_coinvolto.codDipendente from personale_coinvolto
--   inner join lavorazioni on lavorazioni.codLavorazione=personale_coinvolto.codLavorazione
--   where lavorazioni.codSoftware=1);
--   -- oppure mostrare semplicemente codiceDipendente
--   select personale_coinvolto.codDipendente from personale_coinvolto
--   inner join lavorazioni on lavorazioni.codLavorazione=personale_coinvolto.codLavorazione
--   where lavorazioni.codSoftware=1;

-- -- seconda query
-- SELECT software.nome,lavorazioni.dataInizio,lavorazioni.dataFine,lavorazioni.codResponsabile from lavorazioni
-- inner JOIN software on software.codSoftware=lavorazioni.codSoftware 
-- where stato="Terminato" and dataFine BETWEEN '2021-05-01' and '2021-06-01';

-- -- terza query
-- SELECT software.nome,lavorazioni.dataInizio,software.costo,software.tempoGiorniUomo from lavorazioni inner JOIN software on software.codSoftware=lavorazioni.codSoftware where stato="In lavorazione" ;
--  
--  -- quarta query
--  
--  -- quinta query

