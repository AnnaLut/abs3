
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_slave_client_ebk.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_SLAVE_CLIENT_EBK as table of r_slave_client_ebk;
/

 show err;
 
PROMPT *** Create  grants  T_SLAVE_CLIENT_EBK ***
grant EXECUTE                                                                on T_SLAVE_CLIENT_EBK to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_slave_client_ebk.sql =========*** End
 PROMPT ===================================================================================== 
 