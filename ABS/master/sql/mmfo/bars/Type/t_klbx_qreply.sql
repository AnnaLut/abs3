
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_klbx_qreply.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_KLBX_QREPLY is object
      (  pack_name  varchar2(100),
         reply      clob
      )
/

 show err;
 
PROMPT *** Create  grants  T_KLBX_QREPLY ***
grant EXECUTE                                                                on T_KLBX_QREPLY   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_klbx_qreply.sql =========*** End *** 
 PROMPT ===================================================================================== 
 