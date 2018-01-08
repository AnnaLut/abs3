
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/r_rec_ebk.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.R_REC_EBK as object (quality         varchar2(5 ),
                                            name            varchar2(100 ),
                                            value           varchar2(4000 ),
                                            recommendvalue  varchar2(4000 ),
                                            descr           varchar2(4000 ));
/

 show err;
 
PROMPT *** Create  grants  R_REC_EBK ***
grant EXECUTE                                                                on R_REC_EBK       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/r_rec_ebk.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 