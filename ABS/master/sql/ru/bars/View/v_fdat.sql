create or replace view v_fdat
as
select fdat, case when stat is null then 0 when stat=9 then 1 else stat end status from fdat
order by fdat desc;
/
grant select, update on v_fdat to bars_access_defrole
/