create or replace procedure p_set_fdat_status(p_fdat date, p_stat number)
is
begin
update fdat set stat=case p_stat when 1 then 9 when 0 then 0 else -1 end
where fdat=p_fdat;
end;
/
grant execute on p_set_fdat_status to bars_access_defrole
/
