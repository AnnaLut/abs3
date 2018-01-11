

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_EXPCANDIDATES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_EXPCANDIDATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_EXPCANDIDATES ("CP_ID", "EXPIRY", "DOK", "DNK", "EXP_DATE", "OST_N_EXP", "OST_R_EXP") AS 
  SELECT ID,
         EXPIRY,
         DOK,
         DNK,
         EXP_DATE,
         --SUM (NN0) NN0,         SUM (NN1) NN1,
         CASE WHEN SUM (DELTAN) >0 THEN SUM (DELTAN) ELSE 0 END DELTAN,
         --SUM (RR0) RR0,         SUM (RR1) RR1,
         CASE WHEN SUM (DELTAR) >0 THEN SUM (DELTAR)  ELSE 0 END DELTAR
    FROM (  SELECT B.ID,
                   B.DOK,
                   B.EXPIRY,
                   B.DNK,
                   B.EXP_DATE,
                   B.BDAT,
                   B.ACC,
                   B.ACCR,
                   B.ACCR2,
                   B.NN0,
                   B.NN1,
                   B.DELTAN,
                   B.RR0,
                   SUM (SAR.KOS) RR1,
                   B.RR0 - SUM (SAR.KOS) DELTAR
              FROM (  SELECT DISTINCT A.ID,
                                      A.DOK,
                                      A.EXPIRY,
                                      A.DNK,
                                      A.EXP_DATE,
                                      A.ACC,
                                      A.ACCR,
                                      A.ACCR2,
                                      A.BDAT,
                                      A.NN0,
                                      SUM (SAN.KOS) NN1,
                                      A.NN0 - SUM (SAN.KOS) DELTAN,
                                      A.RR0
                        FROM (  SELECT CK.ID,
                                       CK.DOK,
                                       CK.EXPIRY,
                                       CK.DNK,
                                       COALESCE (CD.EXPIRY_DATE, CK.DOK + NVL (CK.EXPIRY, 0)) EXP_DATE,
                                       CE.ACC,
                                       CE.ACCR,
                                       CE.ACCR2,
                                       MIN (CM.FDAT) BDAT,
                                       SUM (CM.SS1 * 100) NN0,
                                       SUM (CM.SN2 * 100) RR0
                                  FROM CP_KOD CK, CP_DEAL CE, CP_MANY CM, CP_DAT CD
                                 WHERE     CK.ID = CE.ID
                                       AND CE.REF = CM.REF
                                       AND CK.ID = CD.ID
                                       AND CD.DOK = CK.DOK
                                       AND CE.ACTIVE = 1
                                       AND (CE.DAZS > CK.DOK OR CE.DAZS IS NULL)
                                       AND CM.FDAT BETWEEN CE.DAT_UG + 1 AND CK.DOK
                              GROUP BY CK.ID,
                                       CK.DOK,
                                       CK.EXPIRY,
                                       CK.DNK,
                                       COALESCE (CD.EXPIRY_DATE, CK.DOK + NVL (CK.EXPIRY, 0)),
                                       CE.ACC,
                                       CE.ACCR,
                                       CE.ACCR2) A,
                             SALDOA SAN
                       WHERE SAN.FDAT > A.BDAT AND SAN.ACC = A.ACC
                    GROUP BY A.ACC,
                             A.DOK,
                             A.EXPIRY,
                             A.DNK,
                             A.EXP_DATE,
                             A.BDAT,
                             A.NN0,
                             A.RR0,
                             A.ACCR,
                             A.ACCR2,
                             A.ID) B,
                   SALDOA SAR
             WHERE     SAR.FDAT >= B.BDAT
                   AND SAR.ACC IN (B.ACCR, B.ACCR2)
                   AND SAR.KOS > 0
          GROUP BY B.ID,
                   B.DOK,
                   B.EXPIRY,
                   B.DNK,
                   B.EXP_DATE,
                   B.BDAT,
                   B.ACC,
                   B.ACCR,
                   B.ACCR2,
                   B.NN0,
                   B.NN1,
                   B.RR0,
                   B.DELTAN)
   WHERE DELTAN > 0 OR DELTAR > 0
GROUP BY ID, DOK, EXPIRY, DNK, EXP_DATE;

PROMPT *** Create  grants  V_CP_EXPCANDIDATES ***
grant SELECT                                                                 on V_CP_EXPCANDIDATES to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_EXPCANDIDATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_EXPCANDIDATES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_EXPCANDIDATES.sql =========*** End
PROMPT ===================================================================================== 
