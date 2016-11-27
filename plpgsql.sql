--Trigger 1--
create or replace function check_auffuehrung() returns trigger as $$
begin
	if (new.verkauf) then
		if not exists (select *
			   from spielt s
			   where s.aid = new.aid and s.rid is not null) then
			raise exception 'Noch keine Rolle eingetragen!';
			return null;
		end if;
	end if;
	return new;
end;
$$ language plpgsql;

create trigger t_check_auffuehrung before insert on Auffuehrung
for each row execute procedure check_auffuehrung();

--Trigger 2--
create or replace function check_spielt() returns trigger as $$
begin
	if exists(select * 
			  from spielt s
			  where new.aid = s.aid and new.wid = s.wid) then
			  raise exception 'Fuer diese Auffuehrung gibt es schon ein Werk!';
			  return null;
    end if;
	return new;	
end;
$$ language plpgsql;

create trigger t_check_spielt before insert on Spielt
for each row execute procedure check_spielt();