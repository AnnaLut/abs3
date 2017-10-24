

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOTARY_TRANSACTION.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOTARY_TRANSACTION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOTARY_TRANSACTION ("ID", "ACCREDITATION_ID", "TYPE_TRAN", "TRANSACTION_DETAILS", "TRANSACTION_DATE", "INCOME_AMOUNT", "BRANCH_ID") AS 
  select a.ID                           ,
       a.ACCREDITATION_ID             ,
       b.TXT                 type_tran,
       a.TRANSACTION_DETAILS          ,
       a.TRANSACTION_DATE             ,
       a.INCOME_AMOUNT                ,
       a.BRANCH_ID
from   NOTARY_TRANSACTION       a,
       NOTARY_TRANSACTION_TYPES b
where  b.TYPE_ID(+)=a.TRANSACTION_TYPE_ID;

PROMPT *** Create  grants  V_NOTARY_TRANSACTION ***
grant SELECT                                                                 on V_NOTARY_TRANSACTION to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOTARY_TRANSACTION.sql =========*** E
PROMPT ===================================================================================== 
