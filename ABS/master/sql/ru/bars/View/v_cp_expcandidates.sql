

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_EXPCANDIDATES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_EXPCANDIDATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_EXPCANDIDATES ("CP_ID", "EXPIRY", "DOK", "DNK", "EXP_DATE", "OST_N_EXP", "OST_R_EXP") AS 
  (  SELECT CK.ID,
             CK.EXPIRY,
             CK.DOK,
             CK.DNK,
             COALESCE (CD.EXPIRY_DATE, CK.DNK + NVL (CK.EXPIRY, 0)) EXP_DATE,
             SUM (NVL (FOST (E.ACC, CK.DNK), 0)) OST_N_EXP,
             SUM (NVL (FOST (E.ACCR, CK.DNK), 0) + NVL (FOST (E.ACCR2, CK.DNK), 0)) OST_R_EXP
        FROM CP_DAT CD, CP_KOD CK, CP_DEAL E
       WHERE CD.ID = CK.ID AND E.ID = CK.ID AND CK.DNK = CD.DOK
             AND COALESCE (CD.EXPIRY_DATE, CK.DNK + NVL (CK.EXPIRY, 0)) <=
                    CK.DNK
    GROUP BY CK.ID,
             CK.EXPIRY,
             CK.DOK,
             CK.DNK,
             COALESCE (CD.EXPIRY_DATE, CK.DNK + NVL (CK.EXPIRY, 0))
      HAVING SUM (NVL (FOST (E.ACC, CK.DNK), 0)) <> 0
             AND SUM (NVL (FOST (E.ACCR, CK.DNK), 0) + NVL (FOST (E.ACCR2, CK.DNK), 0)) <> 0)
   ORDER BY CK.ID ASC;

PROMPT *** Create  grants  V_CP_EXPCANDIDATES ***
grant SELECT                                                                 on V_CP_EXPCANDIDATES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_EXPCANDIDATES.sql =========*** End
PROMPT ===================================================================================== 
