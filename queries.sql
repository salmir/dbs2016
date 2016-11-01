--Query 1--
select h.hname as Haus, (select count(*) 
from platz p join saal s
on p.sid = s.sid
where s.hid = h.hid) as Plaetze
from haus h;

--Query 2--
create or replace view WerkKat as
	with recursive supkat(kid_sup, kid_inf) as (
		select a.kid_sup, a.kid_inf 
		from superkat a
	union all
		select b.kid_sup, b.kid_inf
		from supkat b join superkat a on a.kid_inf = b.kid_sup
		)
	select z.wid as werk, coalesce(b.kid_inf, b.kid_sup, '0') as kategorie
	from zugeordnet z left join (select supkat.kid_sup, supkat.kid_inf
								 from supkat) b on z.kid = b.kid_inf
	order by z.wid;		
	-- Endlos-Rekursion -.-
select * from WerkKat;

--Query 3--
select a.datum as datum, h.hname as hausname
from auffuehrung a 
inner join ((((select s.sid as sid 
		    from saal s 
		    inner join haus h on s.hid = h.hid) h on a.sid = h.sid
				inner join (select sp.wid, sp.aid 
				from spielt sp) on sp.aid = a.aid)
					inner join (select t.aid 
					from ticket t 
					where t.knr is null) on a.aid = t.aid)
						inner join
						(select z.wid 
						from zugeordnet z where z.kid = 1) on z.wid = sp.wid);





--WS 15--
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