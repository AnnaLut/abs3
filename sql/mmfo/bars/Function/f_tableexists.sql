
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tableexists.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TABLEEXISTS (p_tabname in varchar2) return number
is

l_tabname    varchar2(30);  /* имя таблицы */

begin
  select table_name into l_tabname
    from user_tables
   where table_name = upper(p_tabname);

  return 1;
exception
  when NO_DATA_FOUND then return 0;
end f_tableexists;
 
/
 show err;
 
PROMPT *** Create  grants  F_TABLEEXISTS ***
grant EXECUTE                                                                on F_TABLEEXISTS   to ABS_ADMIN;
grant EXECUTE                                                                on F_TABLEEXISTS   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TABLEEXISTS   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tableexists.sql =========*** End 
 PROMPT ===================================================================================== 
 