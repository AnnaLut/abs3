

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_CONS_CREDIT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_CONS_CREDIT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBU_CONS_CREDIT ("REPORT_ID", "SESSION_CREATION_TIME", "SESSION_ACTIVITY_TIME", "NMK", "REQUEST_ID", "RNK", "ND", "ORDERNUM", "FLAGOSOBA", "TYPECREDIT", "NUMDOG", "DOGDAY", "ENDDAY", "SUMZAGAL", "R030", "PROCCREDIT", "SUMPAY", "PERIODBASE", "PERIODPROC", "SUMARREARS", "ARREARBASE", "ARREARPROC", "DAYBASE", "DAYPROC", "FACTENDDAY", "FLAGZ", "KLASS", "RISK", "FLAGINSURANCE", "DEFAULT_LOAN_KF", "DEFAULT_LOAN_ID", "LOAN_OBJECT_ID", "STATUS", "STATUS_MESSAGE", "KF", "LOAN_CODE", "CORE_CUSTOMER_KF", "CORE_CUSTOMER_ID", "ID") AS 
  select "REPORT_ID","SESSION_CREATION_TIME","SESSION_ACTIVITY_TIME","NMK","REQUEST_ID","RNK","ND","ORDERNUM","FLAGOSOBA","TYPECREDIT","NUMDOG","DOGDAY","ENDDAY","SUMZAGAL","R030","PROCCREDIT","SUMPAY","PERIODBASE","PERIODPROC","SUMARREARS","ARREARBASE","ARREARPROC","DAYBASE","DAYPROC","FACTENDDAY","FLAGZ","KLASS","RISK","FLAGINSURANCE","DEFAULT_LOAN_KF","DEFAULT_LOAN_ID","LOAN_OBJECT_ID","STATUS","STATUS_MESSAGE","KF","LOAN_CODE","CORE_CUSTOMER_KF","CORE_CUSTOMER_ID","ID" from nbu_gateway.v_consolidated_credit
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_CONS_CREDIT.sql =========*** End 
PROMPT ===================================================================================== 
