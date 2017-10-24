

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SOCRECEIPTS_CASHLESS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SOCRECEIPTS_CASHLESS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SOCRECEIPTS_CASHLESS ("BRANCH_CODE", "BRANCH_NAME", "SOC_ID", "SOC_NUM", "SOC_DAT", "ACC_ID", "ACC_NUM", "CUR_ID", "CUR_CODE", "DOC_DAT", "DOC_REF", "DOC_SUM", "DOC_DTL", "DOC_TT", "CMS_DAT", "CMS_REF", "CMS_SUM", "CMS_DTL", "CMS_SOS") AS 
  SELECT b.branch, b.NAME, s.contract_id, s.contract_num, s.contract_date,
          a.acc, a.nls, a.kv, v.lcv, o.fdat, o.REF, o.s, p.nazn, o.tt,
          cms.vdat, cms.REF, cms.s, cms.nazn, cms.sos
     FROM social_contracts s,
          branch b,
          accounts a,
          opldok o,
          oper p,
          tabval v,
          tts t,
          oper cms
    WHERE a.branch = b.branch
      AND s.acc = a.acc
      AND a.acc = o.acc
      AND o.REF = p.REF
      AND a.kv = v.kv
      AND o.tt = t.tt
      AND o.dk = 1
      AND o.sos = 5
      AND p.refl = cms.REF(+)
      AND NVL (cms.sos, 0) >= 0
      AND t.sk IS NULL 
 ;

PROMPT *** Create  grants  V_SOCRECEIPTS_CASHLESS ***
grant SELECT                                                                 on V_SOCRECEIPTS_CASHLESS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SOCRECEIPTS_CASHLESS to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SOCRECEIPTS_CASHLESS to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_SOCRECEIPTS_CASHLESS to WR_CBIREP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SOCRECEIPTS_CASHLESS.sql =========***
PROMPT ===================================================================================== 
