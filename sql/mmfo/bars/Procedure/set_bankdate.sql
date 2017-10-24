

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SET_BANKDATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SET_BANKDATE ***

  CREATE OR REPLACE PROCEDURE BARS.SET_BANKDATE (p_dat date) is
ern       constant positive := 033;
erm       varchar2(80);
err       exception;
v_stat    number(1);
begin
  begin
    select stat into v_stat from fdat where fdat=p_dat;
  exception when no_data_found then
    erm := '1 - Дата '||to_char(p_dat,'DD/MM/YYYY')||' не найдена в таблице fdat';
    raise err;
  end;
  if nvl(v_stat,0)<>0 then
    erm := '2 - Дата '||to_char(p_dat,'DD/MM/YYYY')||' закрыта';
    raise err;
  end if;
  gl.pl_dat(p_dat);
exception
   when err then
     raise_application_error(-(20000+ern),'\'||erm,TRUE);
end;
 
/
show err;

PROMPT *** Create  grants  SET_BANKDATE ***
grant EXECUTE                                                                on SET_BANKDATE    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SET_BANKDATE    to START1;
grant EXECUTE                                                                on SET_BANKDATE    to TOSS;
grant EXECUTE                                                                on SET_BANKDATE    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SET_BANKDATE.sql =========*** End 
PROMPT ===================================================================================== 
