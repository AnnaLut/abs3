

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOTARY_TRANSACTION.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOTARY_TRANSACTION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOTARY_TRANSACTION ("ID", "ACCREDITATION_ID", "TYPE_TRAN", "TRANSACTION_DETAILS", "TRANSACTION_DATE", "INCOME_AMOUNT", "BRANCH_ID") AS 
  SELECT ID               , -- идентификатор нотариуса
         ACCR_ID          , -- идентификатор аккредитации
         '40*'            , -- константа
         TO_CHAR(ref_oper), -- референс операции в филиале
         DAT_OPER         , -- дата операции
         profit/100       , -- сумма операции в грн.
         BRANCH             -- бранч
  FROM   NOTARY_PROFIT;

PROMPT *** Create  grants  V_NOTARY_TRANSACTION ***
grant SELECT                                                                 on V_NOTARY_TRANSACTION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOTARY_TRANSACTION.sql =========*** E
PROMPT ===================================================================================== 
