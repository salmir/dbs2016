CREATE SEQUENCE seq_person;
CREATE SEQUENCE seq_haus;

CREATE TABLE Person(
	pid INTEGER PRIMARY KEY DEFAULT nextval('seq_person'),
	vname VARCHAR(50) NOT NULL,
	nname VARCHAR(50) NOT NULL,
	gebdatum DATE,
	adresse VARCHAR(200)
);
CREATE TABLE Kuenstler(
	pid INTEGER,
	instagram VARCHAR(50)
);
CREATE TABLE Kunde(
	pid INTEGER,
	knr INTEGER UNIQUE NOT NULL,
);
CREATE TABLE Mitarbeiter(
	pid INTEGER,
	lohn NUMERIC(5,2) NOT NULL CHECK (lohn >= 1)
);
CREATE TABLE Haus(
	hid INTEGER PRIMARY KEY DEFAULT nextval('seq_haus'),
	hname varchar(50),
	adresse varchar(100)
);
CREATE TABLE Saal(
	sid INTEGER,
	sname VARCHAR(50)
);
CREATE TABLE Platz(
	plid INTEGER,
	Sitz INTEGER,
	Reihe INTEGER	
);
CREATE TABLE Werk(
	wid INTEGER,
	wname VARCHAR(50)
);
CREATE TABLE Kategorie(
	kid INTEGER,
	kname VARCHAR(50)
	superkat INTEGER
);
CREATE TABLE Rolle(
	rid INTEGER,
	rname VARCHAR(50)
);
CREATE TABLE Auffuehrung(
	aid INTEGER,
	datum DATE,
	verkauf BOOLEAN DEFAULT 'false'
);
CREATE TABLE Ticket(
	tid INTEGER,
	preis NUMERIC(5,2)
);

/*
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

ALTER TABLE Leistung ADD CONSTRAINT fk_kategorie FOREIGN KEY (knr) REFERENCES Kategorie(knr) 
DEFERRABLE INITIALLY DEFERRED;

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
);*/