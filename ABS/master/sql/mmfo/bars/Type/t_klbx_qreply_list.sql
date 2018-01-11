
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_klbx_qreply_list.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_KLBX_QREPLY_LIST as table of t_klbx_qreply
/

 show err;
 
PROMPT *** Create  grants  T_KLBX_QREPLY_LIST ***
grant EXECUTE                                                                on T_KLBX_QREPLY_LIST to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_klbx_qreply_list.sql =========*** End
 PROMPT ===================================================================================== 
 