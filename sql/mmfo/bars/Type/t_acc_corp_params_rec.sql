
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_acc_corp_params_rec.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_ACC_CORP_PARAMS_REC 
as object
(
       rnk              number(38),
       acc              number(38),
       use_invp         varchar2(254),
       trkk             varchar2(4),
       inst_kod         varchar2(500),
       alt_corp_cod     varchar2(254),
       daos             date
)
/

 show err;
 
PROMPT *** Create  grants  T_ACC_CORP_PARAMS_REC ***
grant EXECUTE                                                                on T_ACC_CORP_PARAMS_REC to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on T_ACC_CORP_PARAMS_REC to CORP_CLIENT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_acc_corp_params_rec.sql =========*** 
 PROMPT ===================================================================================== 
 