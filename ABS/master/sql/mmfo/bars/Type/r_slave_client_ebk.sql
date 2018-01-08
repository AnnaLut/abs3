
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/r_slave_client_ebk.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.R_SLAVE_CLIENT_EBK as object ( kf varchar2(6),
                                                      rnk number(38)  );
/

 show err;
 
PROMPT *** Create  grants  R_SLAVE_CLIENT_EBK ***
grant EXECUTE                                                                on R_SLAVE_CLIENT_EBK to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/r_slave_client_ebk.sql =========*** End
 PROMPT ===================================================================================== 
 