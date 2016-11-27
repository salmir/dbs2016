--Query 1--
select h.hname as Haus, (select count(*) 
from platz p join saal s
on p.sid = s.sid
where s.hid = h.hid) as Plaetze
from haus h;

--Query 2--
/*create or replace view WerkKat as
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
select * from WerkKat;*/

--Query 3--
select datum, name from
	(select name, datum, aid from
	(select h.hname as name, s.sid as sid
	 from haus h
	 inner join saal s on h.hid = s.hid) x
inner join
	(select t.aid as aid, a.sid as sid, a.datum as datum
	 from ticket t 
	 inner join auffuehrung a on t.aid = a.aid 
	 where t.knr is null) y
on x.sid = y.sid) m
inner join
	(select s.aid as aid, z.kid as kid
	 from zugeordnet z
	 inner join spielt s on s.wid = z.wid
	 group by kid, aid) n
on m.aid = n.aid;

--Query 4--
select vname, nname from
	(select p.pid, p.vname, p.nname, count(p.pid) anz
	 from person p
	 left join spielt s on s.pid = p.pid
	 group by p.pid, s.rid, p.vname, p.nname
	 order by anz desc) a
inner join
kuenstler k on a.pid = k.pid;
