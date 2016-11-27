DROP TRIGGER t_check_spielt on Spielt;
DROP FUNCTION check_spielt();
DROP TRIGGER t_check_auffuehrung on Auffuehrung;
DROP FUNCTION check_auffuehrung();

ALTER TABLE Mitarbeiter DROP CONSTRAINT fk_haus;
DROP VIEW WerkKat;
DROP TABLE Ticket;
DROP TABLE spielt;
DROP TABLE Auffuehrung;
DROP TABLE Rolle;
DROP TABLE zugeordnet;
DROP TABLE superkat;
DROP TABLE Kategorie;
DROP TABLE Werk;
DROP TABLE Platz;
DROP TABLE Saal;
DROP TABLE Haus;
DROP TABLE Mitarbeiter;
DROP TABLE Kunde;
DROP TABLE Kuenstler;
DROP Table Person;

DROP SEQUENCE seq_person;
DROP SEQUENCE seq_ticket;
DROP SEQUENCE seq_kunde;