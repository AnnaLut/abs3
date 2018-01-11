
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_cust_subgrp_ebk.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_CUST_SUBGRP_EBK as table of r_cust_subgrp_ebk;
/

 show err;
 
PROMPT *** Create  grants  T_CUST_SUBGRP_EBK ***
grant EXECUTE                                                                on T_CUST_SUBGRP_EBK to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_cust_subgrp_ebk.sql =========*** End 
 PROMPT ===================================================================================== 
 