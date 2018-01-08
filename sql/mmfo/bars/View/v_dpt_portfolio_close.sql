

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_PORTFOLIO_CLOSE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_PORTFOLIO_CLOSE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_PORTFOLIO_CLOSE ("DPT_ID", "DPT_NUM", "DPT_DAT", "DAT_BEGIN", "DAT_END", "VIDD_CODE", "VIDD_NAME", "RATE", "DPT_AMOUNT", "DPT_NOCASH", "DPT_STATUS", "DPT_COMMENTS", "DPTRCP_MFO", "DPTRCP_ACC", "DPTRCP_NAME", "DPTRCP_IDCODE", "INTRCP_MFO", "INTRCP_ACC", "INTRCP_NAME", "INTRCP_IDCODE", "CUST_ID", "CUST_NAME", "CUST_IDCODE", "CUST_BIRTHDATE", "DOC_SERIAL", "DOC_NUM", "DOC_ISSUED", "DOC_DATE", "DPT_ACCID", "DPT_ACCNUM", "DPT_ACCNAME", "DPT_CURID", "DPT_CURCODE", "DPT_CURNAME", "DPT_SALDO", "DPT_SALDO_PL", "INT_ACCID", "INT_ACCNUM", "INT_ACCNAME", "INT_CURID", "INT_CURCODE", "INT_CURNAME", "INT_SALDO", "INT_SALDO_PL", "INT_KOS", "INT_DOS", "DPT_CUR_DENOM", "BRANCH_ID", "BRANCH_NAME") AS 
  SELECT dpt.dpt_id,
          dpt.nd,
          dpt.datz,
          dpt.dat_begin,
          dpt.dat_end,
          v.vidd,
          v.type_name,
          dpt_web.get_dptrate (a1.acc,
                               a1.kv,
                               dpt.LIMIT,
                               bankdate),
          dpt.LIMIT,
          dpt.nocash,
          dpt.status,
          dpt.comments,
          dpt.mfo_d,
          dpt.nls_d,
          dpt.nms_d,
          dpt.okpo_d,
          dpt.mfo_p,
          dpt.nls_p,
          dpt.nms_p,
          dpt.okpo_p,
          c.rnk,
          c.nmk,
          c.okpo,
          p.bday,
          p.ser,
          p.numdoc,
          p.organ,
          p.pdate,
          a1.acc,
          a1.nls,
          a1.nms,
          a1.kv,
          t1.lcv,
          t1.name,
          a1.ostc,
          a1.ostb,
          a2.acc,
          a2.nls,
          a2.nms,
          a2.kv,
          t2.lcv,
          t2.name,
          DECODE (a1.acc, a2.acc, 0, a2.ostc),
          DECODE (a1.acc, a2.acc, 0, a2.ostb),
          (SELECT SUM (kos)
             FROM saldoa
            WHERE acc = a2.acc AND fdat BETWEEN a2.daos AND bankdate),
          (SELECT SUM (dos)
             FROM saldoa
            WHERE acc = a2.acc AND fdat BETWEEN a2.daos AND bankdate),
          t1.denom,
          b.branch,
          b.name
     FROM int_accn i,
          dpt_vidd v,
          customer c,
          person p,
          saldo a1,
          tabval t2,
          saldo a2,
          tabval t1,
          (
           SELECT dc.deposit_id dpt_id,
                  dc.nd,
                  dc.datz,
                  dc.acc,
                  dc.rnk,
                  dc.vidd,
                  dc.dat_begin,
                  dc.dat_end,
                  dc.LIMIT,
                  NVL (dpt.f_dptw (dc.deposit_id, 'NCASH'), '0') nocash,
                  -1 status,
                  dc.comments,
                  dc.mfo_p,
                  dc.nls_p,
                  SUBSTR (dc.name_p, 1, 38) nms_p,
                  dc.okpo_p,
                  dc.mfo_d,
                  dc.nls_d,
                  dc.nms_d,
                  dc.okpo_d,
                  dc.branch
             FROM dpt_deposit_clos dc
            WHERE dc.action_id = 1
              and NOT EXISTS
                 (SELECT 1
                    FROM dpt_deposit d
                   WHERE d.deposit_id = dc.deposit_id)) dpt,
          branch b
    WHERE     dpt.acc = a1.acc
          AND dpt.acc = i.acc
          AND i.id = 1
          AND i.acra = a2.acc
          AND a1.kv = t1.kv
          AND a2.kv = t2.kv
          AND dpt.rnk = c.rnk
          AND c.rnk = p.rnk
          AND dpt.vidd = v.vidd
          AND dpt.branch = b.branch;

PROMPT *** Create  grants  V_DPT_PORTFOLIO_CLOSE ***
grant SELECT                                                                 on V_DPT_PORTFOLIO_CLOSE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_PORTFOLIO_CLOSE to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_PORTFOLIO_CLOSE to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_PORTFOLIO_CLOSE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_PORTFOLIO_CLOSE.sql =========*** 
PROMPT ===================================================================================== 
