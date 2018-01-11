

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_DOCUMENTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_DOCUMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_DOCUMENTS ("DPT_ID", "DPT_NUM", "DPT_DAT", "REF", "TT", "DK", "SOS", "DATD", "DATP", "PDAT", "VDAT", "SK", "NAZN", "NLS_A", "KV_A", "S_A", "BRANCH_A", "NLS_B", "KV_B", "S_B", "BRANCH_B") AS 
  SELECT d.deposit_id, d.nd, d.datz, o.ref, o.tt, o.dk, o.sos,
       o.datd, o.datp, o.pdat, o.vdat, o.sk, o.nazn,
       o.nlsa, t1.lcv, o.s,  null,
       o.nlsb, t2.lcv, o.s2, null
  FROM oper o, dpt_payments dp, saldo s, tabval t1, tabval t2,
      (SELECT dc.deposit_id, dc.nd, dc.datz, dc.acc
         FROM dpt_deposit_clos dc,
              (SELECT deposit_id, max(idupd) idupd
                 FROM dpt_deposit_clos
                WHERE (deposit_id, bdate) IN (SELECT deposit_id, max(bdate) bdate
                                                FROM dpt_deposit_clos
                                               GROUP BY deposit_id)
                GROUP BY deposit_id) dcm
        WHERE dc.idupd = dcm.idupd
          AND dc.deposit_id = dcm.deposit_id) d
 WHERE o.ref = dp.ref
   AND dp.dpt_id = d.deposit_id
   AND d.acc = s.acc
   AND o.kv = t1.kv
   AND o.kv2 = t2.kv 
 ;

PROMPT *** Create  grants  V_DPT_DOCUMENTS ***
grant SELECT                                                                 on V_DPT_DOCUMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_DOCUMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_DOCUMENTS to DPT_ROLE;
grant SELECT                                                                 on V_DPT_DOCUMENTS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_DOCUMENTS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_DOCUMENTS.sql =========*** End **
PROMPT ===================================================================================== 
