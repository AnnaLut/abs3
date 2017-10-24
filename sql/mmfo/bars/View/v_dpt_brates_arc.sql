

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_BRATES_ARC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_BRATES_ARC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_BRATES_ARC ("MOD_CODE", "VIDD", "TYPE_NAME", "BR_ID", "NAME", "DATE_ENTRY", "BASEY") AS 
  SELECT MOD_CODE,
         db.VIDD,
         v.TYPE_NAME,
         db.BR_ID,
         br.NAME,
         DATE_ENTRY,
         db.BASEY
    FROM DPT_BRATES db, BRATES br, DPT_VIDD v
   WHERE db.BR_ID = br.BR_ID AND db.VIDD = v.VIDD
ORDER BY MOD_CODE, DATE_ENTRY, VIDD DESC;

PROMPT *** Create  grants  V_DPT_BRATES_ARC ***
grant SELECT                                                                 on V_DPT_BRATES_ARC to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_BRATES_ARC.sql =========*** End *
PROMPT ===================================================================================== 
