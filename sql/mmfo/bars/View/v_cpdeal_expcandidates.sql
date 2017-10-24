

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CPDEAL_EXPCANDIDATES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CPDEAL_EXPCANDIDATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CPDEAL_EXPCANDIDATES ("ID", "CP_ID", "NAME", "DOK", "DNK", "EXPIRY_DATE", "REF", "ACC", "N_INT", "N_PAY", "OST_N_EXP", "ACCR", "D_BEGIN", "D_END", "R_INT", "R_PAY", "OST_R_DIFF") AS 
  select "ID","CP_ID","NAME","CURRENT_DOK","CURRENT_DNK","MIN(EXPIRY_DATE)","REF","ACC","N_INT","N_PAY","OST_N_EXP","ACCR","D_BEGIN","D_END","R_INT","R_PAY","OST_R_DIFF" from (
     SELECT A.ID,
            cp_id,
            name,
            CURRENT_DOK,
            CURRENT_DNK,
            min(EXPIRY_DATE),
            REF,
            acc,
           (select nvl(sum(SS1),0) from cp_many cm where cm.ref = ce.ref and ss1 > 0 and fdat between ce.dat_ug and bankdate) N_INT,
            (SELECT NVL (SUM (kos), 0)/100
                    FROM saldoa
                   WHERE acc = ce.acc AND fdat between ce.dat_ug and bankdate)                                  N_PAY,
           (select  nvl(sum(SS1),0) from cp_many cm where cm.ref = ce.ref and ss1 > 0 and fdat between ce.dat_ug and bankdate)
                          - (SELECT NVL (SUM (kos), 0)/100
                               FROM saldoa
                              WHERE acc = ce.acc AND fdat  between ce.dat_ug and bankdate)                              OST_N_EXP,
            accr,
            D_BEGIN,
            bankdate D_END,
            SUM ( (SELECT NVL (SUM (dos), 0)
                     FROM saldoa
                    WHERE acc = ce.accr AND fdat BETWEEN D_BEGIN AND bankdate))/100                 R_INT,
            SUM ( (SELECT NVL (SUM (kos), 0)
                     FROM saldoa
                    WHERE acc = ce.accr AND fdat BETWEEN D_BEGIN AND bankdate))/100                 R_PAY,
            SUM (
               (SELECT NVL (SUM (dos), 0)
                  FROM saldoa
                 WHERE acc = ce.accr AND fdat BETWEEN D_BEGIN AND bankdate)
               - (SELECT NVL (SUM (kos), 0)
                    FROM saldoa
                   WHERE acc = ce.accr AND fdat BETWEEN D_BEGIN AND bankdate))/100                  OST_R_DIFF
       FROM (  SELECT id,name,cp_id,
                      expiry,
                      CURRENT_DOK,
                      CURRENT_DNK,
                      MIN (D_begin) D_BEGIN,
                      MAX (d_end) D_END,
                      SUM(NOM) NOM,
                      max(EXPIRY_DATE)EXPIRY_DATE
                 FROM (  SELECT cd.id, ck.name,cp_id,
                                ck.expiry,
                                ck.dok CURRENT_DOK,
                                ck.dnk CURRENT_DNK,
                                cd.NPP,
                                NVL ( (SELECT MAX (dok)
                                         FROM cp_dat
                                        WHERE id = cd.id AND dok < cd.DOK),
                                     (SELECT DAT_EM
                                        FROM cp_kod
                                       WHERE id = cd.id))
                                   D_BEGIN,
                                cd.DOK D_END,
                                cd.KUP,
                                NVL (cd.NOM, 0) NOM,
                                COALESCE (cd.EXPIRY_DATE, cd.dok + NVL (ck.expiry, 1)) AS EXPIRY_DATE
                           FROM cp_Dat cd, cp_kod ck
                          WHERE cd.id = ck.id AND cd.DOK <= bankdate
                       ORDER BY cd.NPP)
             GROUP BY id,name,cp_id,
                      expiry,
                      CURRENT_DOK,
                      CURRENT_DNK) a,
            CP_DEAL CE
      WHERE ce.id = a.id AND ce.dazs IS NULL --and ce.ref = 111312466
   GROUP BY A.ID,name,cp_id,
            CURRENT_DOK,
            CURRENT_DNK,
            REF,ce.dat_ug,
            D_BEGIN,
            acc,
            accr
   ORDER BY cp_id, REF)
   where OST_R_DIFF > 0 or OST_N_EXP > 0;

PROMPT *** Create  grants  V_CPDEAL_EXPCANDIDATES ***
grant SELECT                                                                 on V_CPDEAL_EXPCANDIDATES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CPDEAL_EXPCANDIDATES.sql =========***
PROMPT ===================================================================================== 
