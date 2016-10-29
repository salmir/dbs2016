CREATE SEQUENCE seq_person;
CREATE SEQUENCE seq_ticket;

CREATE SEQUENCE seq_kunde 
START WITH 1000
INCREMENT BY 1;

CREATE TABLE Person(
	pid INTEGER DEFAULT NEXTVAL ('seq_person'),
	vname VARCHAR(50) NOT NULL,
	nname VARCHAR(50) NOT NULL,
	gebdatum DATE,
	adresse VARCHAR(200),
	PRIMARY KEY (pid)
);
CREATE TABLE Kuenstler(
	pid INTEGER,
	instagram VARCHAR(50),
	PRIMARY KEY (pid),
	FOREIGN KEY (pid) REFERENCES Person(pid)
);
CREATE TABLE Kunde(
	pid INTEGER,
	knr INTEGER DEFAULT NEXTVAL ('seq_kunde'),
	PRIMARY KEY (knr),
	FOREIGN KEY (pid) REFERENCES Person(pid)
	-- UNIQUE nicht notwendig da knr schon PK ist.
);
CREATE TABLE Mitarbeiter(
	pid INTEGER,
	hid INTEGER,
	lohn NUMERIC(8,2) NOT NULL Check (lohn >= 1.00),
	PRIMARY KEY (pid),
	FOREIGN KEY (pid) REFERENCES Person(pid)
);
CREATE TABLE Haus(
	hid INTEGER,
	pid INTEGER,
	hname varchar(50),
	adresse varchar(100),
	PRIMARY KEY (hid),
	FOREIGN KEY (pid) REFERENCES Mitarbeiter(pid) DEFERRABLE INITIALLY DEFERRED
);
ALTER TABLE Mitarbeiter ADD CONSTRAINT fk_haus FOREIGN KEY (hid) REFERENCES Haus(hid) DEFERRABLE INITIALLY DEFERRED;
/* Alternativ zu ALTER TABLE
CREATE TABLE arbeitet_in(
	hid INTEGER,
	mid INTEGER,
	leitet BOOLEAN,
	PRIMARY KEY (mid, hid),
	FOREIGN KEY (mid) REFERENCES Mitarbeiter(pid),
	FOREIGN KEY (hid) REFERENCES Haus(hid)
);*/
CREATE TABLE Saal(
	sid INTEGER,
	hid INTEGER,
	sname VARCHAR(50),
	PRIMARY KEY (sid),
	FOREIGN KEY (hid) REFERENCES Haus(hid)
);
CREATE TABLE Platz(
	plid INTEGER,
	sid INTEGER,
	Sitz INTEGER,
	Reihe INTEGER,
	PRIMARY KEY (plid),
	FOREIGN KEY (sid) REFERENCES Saal(sid),
	UNIQUE (Sitz, Reihe)
);
CREATE TABLE Werk(
	wid INTEGER,
	wname VARCHAR(50),
	PRIMARY KEY (wid)
);
CREATE TABLE Kategorie(
	kid INTEGER,
	kname VARCHAR(50),
	PRIMARY KEY (kid)
);
CREATE TABLE superkat(
	kid_inf INTEGER,
	kid_sup INTEGER,
	FOREIGN KEY (kid_inf) REFERENCES Kategorie(kid), 
	FOREIGN KEY (kid_sup) REFERENCES Kategorie(kid),
	PRIMARY KEY (kid_inf, kid_sup)
);
CREATE TABLE zugeordnet(
	wid INTEGER,
	kid INTEGER,
	PRIMARY KEY (wid, kid),
	FOREIGN KEY (wid) REFERENCES Werk(wid),
	FOREIGN KEY (kid) REFERENCES Kategorie(kid)
);
CREATE TABLE Rolle(
	rid INTEGER,
	rname VARCHAR(50),
	wid INTEGER,
	PRIMARY KEY (rid, wid),
	FOREIGN KEY (wid) REFERENCES Werk(wid)
);
CREATE TABLE Auffuehrung(
	aid INTEGER,
	sid INTEGER,
	datum DATE,
	verkauf BOOLEAN DEFAULT 'false',
	PRIMARY KEY (aid),
	FOREIGN KEY (sid) REFERENCES Saal(sid)
);
CREATE Table spielt(
	aid INTEGER,
	pid INTEGER,
	rid INTEGER,
	wid INTEGER,
	Gage NUMERIC(8,2) NOT NULL CHECK (Gage >= 1.00),
	PRIMARY KEY (aid, pid),
	FOREIGN KEY (aid) REFERENCES Auffuehrung(aid),
	FOREIGN KEY (pid) REFERENCES Kuenstler(pid),
	FOREIGN KEY (rid, wid) REFERENCES Rolle(rid, wid)
);
CREATE TABLE Ticket(
	tid INTEGER DEFAULT nextval('seq_ticket'),
	knr INTEGER,
	aid INTEGER,
	plid INTEGER,
	preis NUMERIC(8,2) NOT NULL CHECK (preis >= 1.00),
	PRIMARY KEY (tid, plid, aid),
	FOREIGN KEY (knr) REFERENCES Kunde(knr),
	FOREIGN KEY (aid) REFERENCES Auffuehrung(aid),
	FOREIGN KEY (plid) REFERENCES Platz(plid)
);