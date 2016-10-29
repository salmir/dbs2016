--Query 1--
SELECT DISTINCT hname 
FROM APosition 
WHERE (anr,apnr) NOT IN (SELECT anr, apnr FROM RPosition);

--Query 2--
CREATE OR REPLACE VIEW LeistungsPreis AS 
	WITH RECURSIVE lben(lnr, benoetigt, menge) AS (
			SELECT b.lnr, b.benoetigt, b.menge
			FROM benoetigt b
		UNION ALL
			SELECT l.lnr, b.benoetigt, b.menge
			FROM lben l JOIN benoetigt b ON l.benoetigt = b.lnr
			) 
	SELECT l.lnr, COALESCE(b.preis+l.preis,l.preis) AS preis 
	FROM leistung l LEFT JOIN (SELECT lben.lnr, SUM(lben.menge * l.preis) AS preis
	                           FROM lben JOIN leistung l ON lben.benoetigt = l.lnr 
	                           GROUP BY lben.lnr) b ON b.lnr = l.lnr
	ORDER BY l.lnr;

SELECT * FROM LeistungsPreis;


--Query 3--
CREATE OR REPLACE VIEW AktKundendaten AS 
    SELECT *
    FROM  Kundendaten d
    WHERE d.erstelldatum IN (SELECT max(erstelldatum) FROM Kundendaten WHERE knr = d.knr);

SELECT * FROM AktKundendaten;