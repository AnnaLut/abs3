
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/date_list.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.DATE_LIST force as table of date;
/

 show err;
 
PROMPT *** Create  grants  DATE_LIST ***
grant EXECUTE                                                                on DATE_LIST       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/date_list.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 