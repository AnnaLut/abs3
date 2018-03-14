PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_CREDIT.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_CORE_CREDIT ***
create or replace view V_CORE_CREDIT as 
select "REQUEST_ID","RNK","ND","ORDERNUM","FLAGOSOBA","TYPECREDIT","NUMDOG","DOGDAY","ENDDAY","SUMZAGAL","R030","PROCCREDIT","SUMPAY","PERIODBASE","PERIODPROC","SUMARREARS","ARREARBASE","ARREARPROC","DAYBASE","DAYPROC","FACTENDDAY","FLAGZ","KLASS","RISK","FLAGINSURANCE","DEFAULT_LOAN_KF","DEFAULT_LOAN_ID","LOAN_OBJECT_ID","STATUS","STATUS_MESSAGE","KF" from      CORE_CREDIT t
 where t.request_id in (select max(r.id)
                          from nbu_core_data_request r
                         where r.data_type_id =
                               (select drt.id
                                  from nbu_core_data_request_type drt
                                 where drt.data_type_code = 'LOAN')
                         group by r.kf);

grant SELECT                                  on V_CORE_CREDIT   to bars;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CORE_CREDIT.sql =========*** End *** 
PROMPT ===================================================================================== 
