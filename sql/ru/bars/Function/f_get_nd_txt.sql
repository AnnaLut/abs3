
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_nd_txt.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_ND_TXT (p_nd   in nd_txt_update.nd%type, -- номер договора
                                        p_tag  in nd_txt_update.tag%type, -- тег реквизита
                                        p_date in nd_txt_update.chgdate%type default sysdate -- дата для получения исторического значения (null или sysdate - текущее)
                                        )
  return nd_txt_update.txt%type is
  -- Получение значения допреквизита договора
  l_res   nd_txt_update.txt%type := null;
begin

  select cck_app.get_nd_txt_ex(p_nd, p_tag, p_date) into l_res from dual;

  return l_res;

end f_get_nd_txt;
/
 show err;
 
PROMPT *** Create  grants  F_GET_ND_TXT ***
grant EXECUTE                                                                on F_GET_ND_TXT    to BARSDWH_ACCESS_USER;
grant EXECUTE                                                                on F_GET_ND_TXT    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_nd_txt.sql =========*** End *
 PROMPT ===================================================================================== 
 