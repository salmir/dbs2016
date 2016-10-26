CREATE SEQUENCE seq_person;

CREATE TABLE Person(
	pid INTEGER PRIMARY KEY DEFAULT nextval('seq_person'),
	vname VARCHAR(50) NOT NULL,
	nname VARCHAR(50) NOT NULL,
	gebdatum DATE,
	adresse VARCHAR(200)
);
CREATE TABLE Kuenstler(
	kue_id INTEGER REFERENCES Person(pid),
	instagram VARCHAR(50)
);
CREATE TABLE Kunde(
	pid INTEGER REFERENCES Person(pid),
	knr INTEGER NOT NULL,
);
CREATE TABLE Mitarbeiter(
	pid INTEGER REFERENCES Person(pid),
	lohn NUMERIC(5,2) NOT NULL CHECK (lohn >= 1)
);
-- Bis hier


CREATE TABLE Kundendaten (
	knr INTEGER REFERENCES Kunde(knr),
	erstelldatum DATE,
	anschrift VARCHAR(40) NOT NULL,
	sonderrabatt INTEGER NOT NULL,
	
	PRIMARY KEY(knr, erstelldatum)
);

CREATE TABLE Auftrag (
	anr INTEGER PRIMARY KEY DEFAULT nextval('seq_auftrag'),
	knr INTEGER NOT NULL REFERENCES Kunde(knr),
	adatum DATE NOT NULL
);

CREATE TABLE APosition (
    anr INTEGER	REFERENCES Auftrag(anr),
	apnr INTEGER,
	liefertermin DATE NOT NULL,
	rabatt INTEGER NOT NULL,
	
	PRIMARY KEY (anr,apnr)
);

CREATE TABLE Rechnung (
	rnr INTEGER PRIMARY KEY DEFAULT nextval('seq_rechnung'),
	rdatum DATE NOT NULL
);

CREATE TABLE RPosition (
	rnr INTEGER REFERENCES Rechnung(rnr),
	rpnr INTEGER,
	anr INTEGER,
	apnr INTEGER,
	wert NUMERIC(7,2) NOT NULL CHECK (wert >= 1),
	text VARCHAR(100) NOT NULL,

	PRIMARY KEY(rnr,rpnr),
	FOREIGN KEY (anr,apnr) REFERENCES APosition(anr,apnr),
	UNIQUE (anr, apnr)
);


CREATE TABLE SonstigePosition (
        anr INTEGER,
	apnr INTEGER,
	wert NUMERIC(7,2) NOT NULL CHECK (wert >= 1), 
	beschreibung VARCHAR(100) NOT NULL,
	
	PRIMARY KEY (anr,apnr),
	FOREIGN KEY (anr,apnr) REFERENCES APosition(anr,apnr)
);

CREATE TABLE Leistung (
	lnr INTEGER PRIMARY KEY DEFAULT nextval('seq_leistung'),
	bezeichnung VARCHAR(40) NOT NULL,
	preis NUMERIC(5,2) NOT NULL CHECK (preis >= 1),
	knr INTEGER NOT NULL
);

CREATE TABLE Kategorie (
	knr INTEGER PRIMARY KEY DEFAULT nextval('seq_kategorie'),
	name VARCHAR(40) NOT NULL,
	topleistung INTEGER REFERENCES Leistung(lnr) DEFERRABLE INITIALLY DEFERRED
);

ALTER TABLE Leistung ADD CONSTRAINT fk_kategorie FOREIGN KEY (knr) REFERENCES Kategorie(knr) DEFERRABLE INITIALLY DEFERRED;

CREATE TABLE benoetigt (
   lnr INTEGER REFERENCES Leistung(lnr),
   benoetigt INTEGER REFERENCES Leistung(lnr),
   menge integer check (menge > 0),
   
   PRIMARY KEY (lnr, benoetigt)
);


CREATE TABLE Leistungsposition(
	anr INTEGER,
	apnr INTEGER,
	leistung INTEGER REFERENCES Leistung(lnr),
	menge INTEGER NOT NULL,

        PRIMARY KEY (anr,apnr),
	FOREIGN KEY (anr,apnr) REFERENCES APosition(anr,apnr)
);