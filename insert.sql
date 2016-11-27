begin;
INSERT INTO Person VALUES
(1,'vname1','nname1','2001-11-11','adresse1'),
(2,'vname2','nname2','2001-11-12','adresse2'),
(3,'vname3','nname3','2001-11-13','adresse3'),
(4,'vnkunde1','nnkunde1','2001-11-03','adresse11'),
(5,'vnkunde2','nnkunde2','2001-11-02','adresse12'),
(6,'vnkunde3','nnkunde3','2001-11-01','adresse13'),
(7,'vma1','nma1','2001-10-01','adresse01'),
(8,'vma2','nma2','2001-10-02','adresse02'),
(9,'vma3','nma3','2001-10-03','adresse03');
commit;

INSERT INTO Kuenstler VALUES
(1,'insta1'),
(2,'insta2'),
(3,'insta3');

INSERT INTO Kunde VALUES
(4,1001),
(5,1002),
(6,1003);

begin;
INSERT INTO Mitarbeiter VALUES
(7,1,2100.99),
(8,2,1500.49),
(9,3,1899.00);

INSERT INTO Haus VALUES
(1,7,'haus1','hadresse1'),
(2,8,'haus2','hadresse2'),
(3,9,'haus3','hadresse3');
commit;

INSERT INTO Saal VALUES
(1,1,'haus1_saal1'),
(2,1,'haus1_saal2'),
(3,1,'haus1_saal3'),
(4,2,'haus2_saal1'),
(5,3,'haus3_saal1');

INSERT INTO Platz VALUES
(1,1,1,1),
(2,1,2,1),
(3,1,3,1),
(4,1,4,1),
(5,1,5,1),
(6,1,1,2),
(7,1,2,2),
(8,1,3,2),
(9,1,4,2),
(10,1,5,2);

INSERT INTO Werk VALUES
(1,'werk1'),
(2,'werk2'),
(3,'werk3'),
(4,'werk4');

INSERT INTO Kategorie VALUES
(1,'Kategorie1'),
(2,'Kategorie2'),
(3,'Kategorie3'),
(4,'Kategorie4');

INSERT INTO Superkat VALUES
(1,2),
(2,3),
(3,4);

INSERT INTO Zugeordnet VALUES
(1,1),
(1,2),
(2,3);

INSERT INTO Rolle VALUES 
(1,'rolle1',1),
(2,'rolle2',1),
(3,'rolle3',1),
(1,'rolle4',2);

INSERT INTO Auffuehrung VALUES
(1,1,'2016-08-08','true'),
(2,2,'2017-02-09','false'),
(3,3,'2017-03-10','false');

INSERT INTO Spielt VALUES
(1,1,1,1,4000.00),
(1,2,2,1,5000.00),
(1,3,3,1,6000.00),
(2,1,1,1,4000.00);

INSERT INTO Ticket VALUES
(1,1001,1,1,199.99),
(2,1002,1,2,149.99),
(3,1003,1,5,99.99);

INSERT INTO Ticket(tid,aid,plid,preis) VALUES
(4,1,4,99.99),
(5,1,3,129.99);