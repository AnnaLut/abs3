PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CORE_CREDIT.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CORE_CREDIT ***

create or replace view V_CORE_CREDIT as
select "REQUEST_ID","RNK","ND","ORDERNUM","FLAGOSOBA","TYPECREDIT","NUMDOG","DOGDAY","ENDDAY","SUMZAGAL","R030","PROCCREDIT","SUMPAY","PERIODBASE","PERIODPROC","SUMARREARS","ARREARBASE","ARREARPROC","DAYBASE","DAYPROC","FACTENDDAY","FLAGZ","KLASS","RISK","FLAGINSURANCE","DEFAULT_LOAN_KF","DEFAULT_LOAN_ID","LOAN_OBJECT_ID","STATUS","STATUS_MESSAGE","KF" from nbu_gateway.V_CORE_CREDIT;

PROMPT *** Create  grants  V_CORE_CREDIT ***
grant SELECT                                                                 on V_CORE_CREDIT to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CORE_CREDIT.sql =========**
PROMPT ===================================================================================== 
