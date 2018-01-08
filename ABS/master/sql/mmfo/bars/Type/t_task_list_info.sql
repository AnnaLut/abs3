
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_task_list_info.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_TASK_LIST_INFO AS OBJECT (TASK_ID INT, TASK_ACTIVE VARCHAR2(3))
/

 show err;
 
PROMPT *** Create  grants  T_TASK_LIST_INFO ***
grant EXECUTE                                                                on T_TASK_LIST_INFO to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_task_list_info.sql =========*** End *
 PROMPT ===================================================================================== 
 