
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_credit_partners_table.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_CREDIT_PARTNERS_TABLE as table of t_count_credit_partners;
/

 show err;
 
PROMPT *** Create  grants  T_CREDIT_PARTNERS_TABLE ***
grant EXECUTE                                                                on T_CREDIT_PARTNERS_TABLE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_credit_partners_table.sql =========**
 PROMPT ===================================================================================== 
 