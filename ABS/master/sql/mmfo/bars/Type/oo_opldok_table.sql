
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/oo_opldok_table.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.OO_OPLDOK_TABLE AS TABLE OF OO_OPLDOK_RECORD;
/

 show err;
 
PROMPT *** Create  grants  OO_OPLDOK_TABLE ***
grant EXECUTE                                                                on OO_OPLDOK_TABLE to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/oo_opldok_table.sql =========*** End **
 PROMPT ===================================================================================== 
 