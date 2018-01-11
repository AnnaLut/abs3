

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_EXPCANDIDATES_NEW.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_EXPCANDIDATES_NEW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_EXPCANDIDATES_NEW ("ID", "CP_ID", "NAME", "DOK", "DNK", "EXP_DATE", "NOM", "KUP", "OST_N_EXP", "RUN_EXPN", "OST_R_EXP", "RUN_EXPR") AS 
  SELECT  ID, CP_ID, NAME,
        CURRENT_DOK,
        CURRENT_DNK,
        max(EXPIRY_DATE) EXPIRY_DATE,
        max(NOM) NOM,
        max(KUP) KUP,
        (select sum(OST_N_EXP) from V_CPDEAL_EXPCANDIDATES where id = t.id) OST_N_EXP,
        0 as run_expn,
        (select sum(OST_R_diff) from V_CPDEAL_EXPCANDIDATES where id = t.id) OST_R_EXP,
        0 as run_expr
  FROM (
    SELECT A.ID, CP_ID, NAME,
                 CURRENT_DOK,
                 CURRENT_DNK,
                 A.NPP,
                 A.D_BEGIN DOK,
                 A.D_END DNK,
                 EXPIRY,
                 A.EXPIRY_DATE,NextDOK,
                 A.NOM,
                 KUP,
                 (SELECT NVL (SUM (SS1), 0)
                         FROM cp_many cm
                        WHERE     cm.REF = ce.REF
                              AND ss1 > 0
                              AND fdat BETWEEN ce.dat_ug AND bankdate)
                    - (SELECT NVL (SUM (kos), 0) / 100
                         FROM saldoa
                        WHERE     acc = ce.acc
                              AND fdat BETWEEN ce.dat_ug AND bankdate)
                       OST_N_EXP,
                 sum((select nvl(sum(dos),0) from saldoa where acc = ce.accr and fdat between D_BEGIN and D_END-1) -
                 (select nvl(sum(kos),0) from saldoa where acc = ce.accr and fdat between D_END   and NextDOK-1)) OST_R_EXP
           FROM(SELECT cd.id,
                       ck.CP_ID,
                       ck.NAME,
                       ck.expiry,
                       ck.dok CURRENT_DOK,
                       ck.dnk CURRENT_DNK,
                       cd.NPP,
                       nvl((select max(dok) from cp_dat where id=cd.id and dok < cd.DOK),(select DAT_EM from cp_kod where id = cd.id)) D_BEGIN,
                       cd.DOK D_END,
                       cd.KUP,
                       NVL (cd.NOM, 0) NOM,
                       COALESCE (cd.EXPIRY_DATE, cd.dok + NVL (ck.expiry, 1)) as EXPIRY_DATE,
                       (select nvl(min(DOK),cd.DOK) from cp_dat where dok > cd.DOK and id = cd.id) NextDOK
                  FROM cp_Dat cd, cp_kod ck
                 WHERE cd.id = ck.id --AND cd.id = :nId
                 ORDER BY cd.NPP) a,
                 CP_DEAL CE
           WHERE ce.id = a.id AND ce.dazs IS NULL AND A.D_END <= bankdate
            -- AND ce.ref = 45327604
        GROUP BY A.ID, CP_ID, NAME,
                 CURRENT_DOK,
                 CURRENT_DNK,
                 A.NPP,
                 A.D_BEGIN,
                 A.D_END,
                 EXPIRY,
                 A.EXPIRY_DATE,
                 NextDOK,
                 A.NOM,
                 KUP,ce.ref, ce.acc, ce.accr, ce.dat_ug
        ORDER BY npp) t
group by
        id, cp_id,name,
        CURRENT_DOK,
        CURRENT_DNK
having MAX(DNK) = current_dnk  and  (sum(OST_N_EXP)> 0 OR sum(OST_R_EXP)>0)
    order by cp_id;

PROMPT *** Create  grants  V_CP_EXPCANDIDATES_NEW ***
grant SELECT                                                                 on V_CP_EXPCANDIDATES_NEW to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_EXPCANDIDATES_NEW to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_EXPCANDIDATES_NEW to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_EXPCANDIDATES_NEW.sql =========***
PROMPT ===================================================================================== 
