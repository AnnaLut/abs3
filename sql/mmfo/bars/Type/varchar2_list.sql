
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/varchar2_list.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.VARCHAR2_LIST AS TABLE OF VARCHAR2(32000);
/

 show err;
 
PROMPT *** Create  grants  VARCHAR2_LIST ***
grant EXECUTE                                                                on VARCHAR2_LIST   to BARSAQ with grant option;
grant EXECUTE                                                                on VARCHAR2_LIST   to BARSAQ_ADM;
grant EXECUTE                                                                on VARCHAR2_LIST   to BARSUPL;
grant EXECUTE                                                                on VARCHAR2_LIST   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VARCHAR2_LIST   to UPLD;
grant EXECUTE                                                                on VARCHAR2_LIST   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/varchar2_list.sql =========*** End *** 
 PROMPT ===================================================================================== 
 