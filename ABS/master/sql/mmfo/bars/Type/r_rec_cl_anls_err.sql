
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/r_rec_cl_anls_err.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.R_REC_CL_ANLS_ERR as object( rnk         number(38),
                                                    code        varchar2(50 ),
                                                    msg         varchar2(500)
                                                  );
/

 show err;
 
PROMPT *** Create  grants  R_REC_CL_ANLS_ERR ***
grant EXECUTE                                                                on R_REC_CL_ANLS_ERR to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/r_rec_cl_anls_err.sql =========*** End 
 PROMPT ===================================================================================== 
 