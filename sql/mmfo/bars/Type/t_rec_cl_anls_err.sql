
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_rec_cl_anls_err.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_REC_CL_ANLS_ERR as table of r_rec_cl_anls_err;
/

 show err;
 
PROMPT *** Create  grants  T_REC_CL_ANLS_ERR ***
grant EXECUTE                                                                on T_REC_CL_ANLS_ERR to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_rec_cl_anls_err.sql =========*** End 
 PROMPT ===================================================================================== 
 