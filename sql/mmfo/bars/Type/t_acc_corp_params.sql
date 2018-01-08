
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_acc_corp_params.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_ACC_CORP_PARAMS as table of T_acc_corp_params_rec;
/

 show err;
 
PROMPT *** Create  grants  T_ACC_CORP_PARAMS ***
grant EXECUTE                                                                on T_ACC_CORP_PARAMS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on T_ACC_CORP_PARAMS to CORP_CLIENT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_acc_corp_params.sql =========*** End 
 PROMPT ===================================================================================== 
 