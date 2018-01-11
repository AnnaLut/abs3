
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_rec_qlt_grp.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_REC_QLT_GRP as table of r_rec_qlt_grp;
/

 show err;
 
PROMPT *** Create  grants  T_REC_QLT_GRP ***
grant EXECUTE                                                                on T_REC_QLT_GRP   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_rec_qlt_grp.sql =========*** End *** 
 PROMPT ===================================================================================== 
 