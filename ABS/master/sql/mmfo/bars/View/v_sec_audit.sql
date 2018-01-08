

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SEC_AUDIT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SEC_AUDIT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SEC_AUDIT ("REC_ID", "REC_DATE", "REC_TIME", "REC_TYPE", "REC_BDATE", "REC_MESSAGE", "MACHINE", "REC_UID") AS 
  SELECT REC_ID,
       to_char(REC_DATE, 'dd/mm/yyyy' ) as REC_DATE,
       to_char(REC_DATE, 'HH24:MI:SS' ) as REC_TIME,
       REC_TYPE,
       REC_BDATE,
       REC_MESSAGE,
       MACHINE,
       REC_UID
   from sec_audit;

PROMPT *** Create  grants  V_SEC_AUDIT ***
grant SELECT                                                                 on V_SEC_AUDIT     to BARSREADER_ROLE;
grant SELECT                                                                 on V_SEC_AUDIT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SEC_AUDIT     to START1;
grant SELECT                                                                 on V_SEC_AUDIT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SEC_AUDIT.sql =========*** End *** ==
PROMPT ===================================================================================== 
