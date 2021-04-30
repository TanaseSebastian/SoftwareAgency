DROP DATABASE if exists studiomedico;
CREATE DATABASE STUDIOMEDICO;
USE STUDIOMEDICO;
CREATE TABLE DIPARTIMENTI (
  codDipartimento int NOT NULL AUTO_INCREMENT,
  piano varchar(50) NOT NULL,
  phone varchar(45) NOT NULL,
  nome varchar(45) NOT NULL,
  PRIMARY KEY (codDipartimento)
);
CREATE TABLE UTENTI (
  CF char(16) NOT NULL unique,
  NOME varchar(50) NOT NULL,
  COGNOME varchar(50) NOT NULL,
  USERNAME varchar(50) NOT NULL unique,
  EMAIL varchar(50) NOT NULL unique,
  PHONE char(10) NOT NULL,
  PSW varchar(128) NOT NULL,
  AMMINISTRATORE char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (CF)
);

CREATE TABLE DOTTORI (
  codDottore int NOT NULL AUTO_INCREMENT,
  nome varchar(45) NOT NULL,
  cognome varchar(45) NOT NULL,
  phone varchar(45) NOT NULL,
  email varchar(45) NOT NULL,
  codDipartimento int NOT NULL,
  PRIMARY KEY (codDottore),
  KEY codDipartimento_idx (codDipartimento),
  CONSTRAINT codDipartimento FOREIGN KEY (codDipartimento) REFERENCES DIPARTIMENTI (codDipartimento) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PRESTAZIONI(
codPrestazione INT NOT NULL auto_increment primary key,
Nome varchar(255) NOT NULL,
codDipartimento INT NOT NULL,
FOREIGN KEY (codDipartimento) REFERENCES DIPARTIMENTI(codDipartimento) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PRENOTAZIONI (
  codPrenotazione int NOT NULL AUTO_INCREMENT,
  dateTime datetime NOT NULL,
  commento varchar(250) DEFAULT NULL,
  codPrestazione INT NOT NULL,
  codFisc char(16) NOT NULL,
  codDottore int NOT NULL,
  stato varchar(20) NOT NULL DEFAULT "In attesa",
  PRIMARY KEY (codPrenotazione),
  KEY CF_idx (codFisc),
  KEY codDottore_idx (codDottore),
  CONSTRAINT CF FOREIGN KEY (codFisc) REFERENCES UTENTI (CF) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT codDottore FOREIGN KEY (codDottore) REFERENCES DOTTORI (codDottore) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT codPrestazione FOREIGN KEY (codPrestazione) REFERENCES PRESTAZIONI(codPrestazione) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE fatture (
codiceFattura INT NOT NULL AUTO_INCREMENT , 
codicePrenotazione INT NOT NULL , 
importo DECIMAL(8,2) NOT NULL ,
dataEmissione DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
documento BLOB NULL DEFAULT NULL,
 PRIMARY KEY (codiceFattura),
 FOREIGN KEY (codicePrenotazione) REFERENCES PRENOTAZIONI(codPrenotazione) ON DELETE CASCADE ON UPDATE CASCADE
 );
 ALTER TABLE utenti ADD image VARCHAR(255) NULL DEFAULT 'undraw_profile.svg' AFTER AMMINISTRATORE;



insert into utenti(CF,NOME,COGNOME,USERNAME,EMAIL,PHONE,PSW,AMMINISTRATORE) values("TNSHSGTRHGST543S","Sebastian","Tanase","Tanase_Sebastian","sebastiantanase18@gmail.com","3490596202",md5("pippo"),"Y");
-- select * from utenti WHERE USERNAME="Reppo";
-- delete from utenti where cf="GJGHGDFJTNFTREJT";
insert into utenti(CF,NOME,COGNOME,USERNAME,EMAIL,PHONE,PSW) values("GJGHGDFJTNFTREJT","Samuele", "Restino", "Reppo","reppo@gmail.com","3422222234",md5("Reppo2021"));
insert into utenti(CF,NOME,COGNOME,USERNAME,EMAIL,PHONE,PSW) values("TTTTGDFJTNFTREJT","Seb", "Tanase", "Seba","sebastianlaszlo2002@gmail.com","3422222234",md5("ciao"));
-- select * from dipartimenti;
insert into dipartimenti(Nome,Piano,Phone) values("Cardiologia","1 Piano","0833212121"),("Neurologia","2 Piano","0833212122"),("Gastroenterologia ","3 Piano","0833212123"),("Pediatria","4 Piano","0833212124"),("Oculistica","5 Piano","0833212125");

-- delete  from dottori;
insert into dottori(NOME,COGNOME,PHONE,EMAIL,codDipartimento) values
("Mario","Rossi","3290987654","mariorossi@medilab.it",1),
("Matteo","Primiceri","3204567890","matteoprimiceri@medilab.it",1),
("Marco","Papallo","3270878890","marcopapallo@medilab.it",1),
("Davide","Solidoro","3203221890","davidesolidoro@medilab.it",1),
("Luigi","Zaia","3276532190","luigizaia@medilab.it",2),
("Samuele","Rossetto","3258793901","samuelerossetto@medilab.it",2),
("Abramo","Persano","3207893303","abramopersano@medilab.it",2),
("Luigi","Bianchi","3290987644","luigibianchi@medilab.it",2),
("Giuseppe","Verdi","3290987600","giuseppeverdi@medilab.it",3),
("Alberto","Stefanì","3278562901","albertostefani@medilab.it",3),
("Gabriele","Piccinno","3208710303","gabrielepiccinno@medilab.it",3),
("Antonio","Restino","3256782303","antoniorestino@medilab.it",3),
("Francesco","Alemanno","3290987699","francescoalemanno@medilab.it",4),
("Marco","Leo","3278907650","marcoleo@medilab.it",4),
("Italo","Ravenna","3278239091","italoravenna@medilab.it",4),
("Paolo","Solida","3278009303","paolosolida@medilab.it",4),
("Matteo","Toma","3290987688","matteotoma@medilab.it",5),
("Marcus","Murano","3207882091","marcusmurano@medilab.it",5),
("Sebastian","Picciolo","3279076303","sebastianpicciolo@medilab.it",5),
("Samuele","Grande","3293027303","samuelegrande@medilab.it",5);
-- select * from dottori;
-- describe prenotazioni;
-- select * from prenotazioni;
ALTER TABLE studiomedico.prenotazioni
  ADD CONSTRAINT uq_prenotazioni UNIQUE(dateTime, codDottore);
  
  -- prestazioni del reparto cardiologia
  insert into prestazioni(Nome,codDipartimento) values
  ("Visita Cardiologica",1),
  ("Visita Cardiologica Con Ec",1),
  ("Visita Cardiologica Con Ecocardiogramma",1),
  ("Visita Cardiologica Di Controllo Con Ecg",1),
  ("Controllo Elettronico Pacemaker",1),
  ("Ecg Secondo Holter",1),
  ("Ecocardiogramma",1),
  ("Ecocardiogramma Color Doppler",1),
  ("Elettrocardiogramma",1),
  ("Monitoraggio Pressione Arteriosa Delle 24 Ore",1);
  
  
  -- prestazioni del reparto neurologia
  insert into prestazioni(Nome,codDipartimento) values
    ("Visita Neurologica",2),
	("Elettromiografia 1 Distretto",2),
    ("Visita Neurologica Di Controllo",2),
	("Visita Per Vertigini",2),
	("Visita Per Cefalee",2);
      
      
	-- prestazioni del reparto gastroenterologia
	insert into prestazioni(Nome,codDipartimento) values
    ("Tampone Faringeo",3),
	("Visita Gastroenterologica",3),
	("Visita Epatologica",3),
    ("Colonscopia + Eventuale Biopsia",3),
    ("Colonscopia In Sedazione Profonda + Eventuale Biopsia",3),
    ("Enteroscopia Con Videocapsula",3),
    ("Gastroscopia + Eventuale Biopsia",3),
    ("Gastroscopia In Sedazione Profonda + Eventuale Biopsia",3),
    ("Gastroscopia Transnasale",3),
    ("Gastroscopia Transnasale + Eventuale Biopsia",3),
    ("Idrocolonterapia",3),
    ("Rettoscopia Rigida con Biopsia",3),
    ("Rettosigmoidoscopia",3),
    ("Rettosigmoidoscopia Rigida con Biopsia",3),
	("Urea Breath Test Per Helicobacter",3), 
	("Test Diagnostico Intolleranze Alimentari",3),  
	("Visita Disturbi Del Comportamento Alimentare",3);
    
    -- prestazioni del reparto pediatria
	insert into prestazioni(Nome,codDipartimento) values
    ("Visita Pediatrica",4),
	("Visita Pediatrica Con Tampone Faringeo",4),
    ("Spirometria Pediatrica",4),  
	("Visita Neonatologica",4),
    ("Visita Pediatrica Allergologica",4),
    ("Visita Pediatrica Allergologica Con Pricktest",4),
    ("Visita Pediatrica Allergologica Con Spirometria",4),
    ("Visita Cardiologica Pediatrica",4),
    ("Visita Cardiologica Pediatrica Con Ecg",4),
    ("Visita Pediatrica Della Crescita (Auxologica)",4),
    ("Visita Pediatrica Filtro (Bilanci Di Salute)",4),
    ("Visita Pediatrica Gastroenterologica",4),
    ("Visita Pediatrica Neurologica",4),
    ("Visita Pediatrica Pneumologica",4);
    
    
    
    
	-- prestazioni del reparto oculistica
	insert into prestazioni(Nome,codDipartimento) values
    ("Visita Oculistica",5),
    ("Aberrometria",5),
    ("Analisi del Film Lacrimale con TearLab",5),
    ("Angio OCT",5),
    ("Argon Laser Retinico Fotocoagulativo",5),
    ("Capsulotomia Yag Laser per Cataratta",5),
    ("Ecobiometria",5),
	("Ecografia Oculare",5),
    ("Esame Campo Visivo Computerizzato",5),
    ("Esame del Fondo Oculare",5),
    ("Fluorangiografia",5),
    ("Fotografia Segmento Anteriore",5),
    ("Microperimetria",5),
    ("Oct Tomografia Ottica A Radiazione Coerente",5),
    ("Pachimetria Corneale",5),
    ("Pupillometria",5),
    ("Retinografia",5),
    ("Test di Schirmer",5),
    ("Tonometria",5),
	("Topografia Corneale",5),
	("Visita Oculistica Con Tonometria Ed Esame Del Fondo Dell'Occhio",5),
	("Visita Oculistica Medico Legale",5),
	("Visita Ortottica",5),
    ("Visita Per Idoneita A Chirurgia Refrattiva",5);
    
   --    use studiomedico;
    --   select * from utenti;
--  SELECT EMAIL FROM UTENTI WHERE CF="GJGHGDFJTNFTREJT";
  
  -- SET lc_time_names = 'it_IT';
  -- select date_format("2021-05-07", '%W %d %M %Y') as DATA;
  -- SELECT count(*) FROM PRENOTAZIONI WHERE STATO="Eseguita";
  -- SELECT count(*) FROM PRENOTAZIONI WHERE STATO="Non eseguita";
  -- SELECT count(*) FROM PRENOTAZIONI WHERE STATO="In attesa";
  -- SELECT DISTINCT COUNT(*) FROM UTENTI WHERE AMMINISTRATORE="N";
  -- SELECT DISTINCT * FROM UTENTI WHERE AMMINISTRATORE="N";
  -- SELECT DISTINCT COUNT(*) FROM UTENTI WHERE AMMINISTRATORE="Y";
  -- SELECT DISTINCT * FROM UTENTI WHERE AMMINISTRATORE="Y";