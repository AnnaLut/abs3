
 
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

  for k in ( select c1, name_hash from v_finmon_reft where name_hash is not null )
  loop
     if l_txt = k.name_hash then
        l_ret := k.c1;
        exit;
     end if;
  end loop;

  return l_ret;

end;
/
 show err;
 
PROMPT *** Create  grants  F_ISTR ***
grant EXECUTE                                                                on F_ISTR          to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_istr.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 