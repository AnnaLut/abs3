
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/type_deal_info.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.TYPE_DEAL_INFO AS TABLE OF OBJECT_deal_info;
/

 show err;
 
PROMPT *** Create  grants  TYPE_DEAL_INFO ***
grant EXECUTE                                                                on TYPE_DEAL_INFO  to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/type_deal_info.sql =========*** End ***
 PROMPT ===================================================================================== 
 