
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/clob_list.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.CLOB_LIST force as table of clob;
/

 show err;
 
PROMPT *** Create  grants  CLOB_LIST ***
grant EXECUTE                                                                on CLOB_LIST       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/clob_list.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 