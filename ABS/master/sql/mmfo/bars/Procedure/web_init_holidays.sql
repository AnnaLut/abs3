

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/WEB_INIT_HOLIDAYS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure WEB_INIT_HOLIDAYS ***

  CREATE OR REPLACE PROCEDURE BARS.WEB_INIT_HOLIDAYS (p_kv number, p_year number)
is
l_lcv tabval.lcv%type;
begin
    begin
        select lcv into l_lcv from tabval
        where kv=p_kv;
        exception when no_data_found then l_lcv:='UAH';
    end;
init_holidays(l_lcv, p_year);
end;
/
show err;

PROMPT *** Create  grants  WEB_INIT_HOLIDAYS ***
grant EXECUTE                                                                on WEB_INIT_HOLIDAYS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/WEB_INIT_HOLIDAYS.sql =========***
PROMPT ===================================================================================== 
