
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/tms_tab_list_info.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.TMS_TAB_LIST_INFO IS TABLE OF T_TASK_LIST_INFO
/

 show err;
 
PROMPT *** Create  grants  TMS_TAB_LIST_INFO ***
grant EXECUTE                                                                on TMS_TAB_LIST_INFO to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/tms_tab_list_info.sql =========*** End 
 PROMPT ===================================================================================== 
 