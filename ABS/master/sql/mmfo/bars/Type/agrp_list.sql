
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/agrp_list.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.AGRP_LIST AS TABLE OF NUMBER;
/

 show err;
 
PROMPT *** Create  grants  AGRP_LIST ***
grant EXECUTE                                                                on AGRP_LIST       to BARSAQ;
grant EXECUTE                                                                on AGRP_LIST       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/agrp_list.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 