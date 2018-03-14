PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_CREDIT.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_CREDIT ***

create or replace view V_NBU_CREDIT as
select "RNK","ND","ORDERNUM","FLAGOSOBA","TYPECREDIT","NUMDOG","DOGDAY","ENDDAY","SUMZAGAL","R030","PROCCREDIT","SUMPAY","PERIODBASE","PERIODPROC","SUMARREARS","ARREARBASE","ARREARPROC","DAYBASE","DAYPROC","FACTENDDAY","FLAGZ","KLASS","RISK","FLAGINSURANCE","STATUS","STATUS_MESSAGE","KF" from NBU_CREDIT;

PROMPT *** Create  grants  V_NBU_CREDIT ***
grant SELECT                                                                 on V_NBU_CREDIT to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_CREDIT.sql =========**
PROMPT ===================================================================================== 
