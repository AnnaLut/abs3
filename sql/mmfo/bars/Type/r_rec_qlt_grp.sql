
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/r_rec_qlt_grp.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.R_REC_QLT_GRP as object (name         varchar2(50 ),
                                                quality       number(6,2)
                                               );
/

 show err;
 
PROMPT *** Create  grants  R_REC_QLT_GRP ***
grant EXECUTE                                                                on R_REC_QLT_GRP   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/r_rec_qlt_grp.sql =========*** End *** 
 PROMPT ===================================================================================== 
 