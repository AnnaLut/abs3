
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_istr.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ISTR (p_txt varchar2) return number is
-- функция проверки на вхождение в справочник террористов
-- с применением Hash-функции
-- version 2.8 06.05.2015

  l_txt         varchar2(2000);
  l_tmp         varchar2(2000);
  l_ret         number := 0;

begin

  l_txt := f_fm_hash(p_txt);
  --max is used for avoid exceptions no_data_found and too_many_rows
  select max(c1) into l_ret from v_finmon_reft where name_hash = l_txt;
  l_ret := nvl(l_ret, 0);
  return l_ret;

end;
/
 show err;
 
PROMPT *** Create  grants  F_ISTR ***
grant EXECUTE                                                                on F_ISTR          to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_istr.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 