
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_rec_ebk.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_REC_EBK as table of r_rec_ebk;
/

 show err;
 
PROMPT *** Create  grants  T_REC_EBK ***
grant EXECUTE                                                                on T_REC_EBK       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_rec_ebk.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 