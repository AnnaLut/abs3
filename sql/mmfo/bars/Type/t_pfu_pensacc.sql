
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_pfu_pensacc.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_PFU_PENSACC as table of r_pfu_pensacc
/

 show err;
 
PROMPT *** Create  grants  T_PFU_PENSACC ***
grant EXECUTE                                                                on T_PFU_PENSACC   to PFU;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_pfu_pensacc.sql =========*** End *** 
 PROMPT ===================================================================================== 
 