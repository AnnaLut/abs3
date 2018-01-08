
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_pfu_pensioner.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_PFU_PENSIONER as table of r_pfu_pensioner
/

 show err;
 
PROMPT *** Create  grants  T_PFU_PENSIONER ***
grant EXECUTE                                                                on T_PFU_PENSIONER to PFU;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_pfu_pensioner.sql =========*** End **
 PROMPT ===================================================================================== 
 