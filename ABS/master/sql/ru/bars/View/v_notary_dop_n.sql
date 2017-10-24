

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOTARY_DOP_N.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOTARY_DOP_N ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOTARY_DOP_N ("ID", "NAME", "TIN", "ACCOUNT_NUMBER", "PASSPORT_SERIES", "PASSPORT_NUMBER") AS 
  select
   N.ID,
   N.FIRST_NAME||' '||
   N.MIDDLE_NAME||' '||
   N.LAST_NAME,
   N.TIN,
   A.ACCOUNT_NUMBER,
   N.PASSPORT_SERIES,
   N.PASSPORT_NUMBER
   from notary n, notary_accreditation a
   where n.id = a.notary_id
   and A.CLOSE_DATE is null;

PROMPT *** Create  grants  V_NOTARY_DOP_N ***
grant SELECT                                                                 on V_NOTARY_DOP_N  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NOTARY_DOP_N  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOTARY_DOP_N.sql =========*** End ***
PROMPT ===================================================================================== 
