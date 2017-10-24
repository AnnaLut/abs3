

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_PORTFOLIO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_PORTFOLIO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_PORTFOLIO ("DPT_ID", "DPT_NUM", "DPT_DAT", "DAT_BEGIN", "DAT_END", "VIDD_CODE", "VIDD_NAME", "RATE", "DPT_AMOUNT", "DPT_NOCASH", "DPT_STATUS", "DPT_COMMENTS", "DPTRCP_MFO", "DPTRCP_ACC", "DPTRCP_NAME", "DPTRCP_IDCODE", "INTRCP_MFO", "INTRCP_ACC", "INTRCP_NAME", "INTRCP_IDCODE", "CUST_ID", "CUST_NAME", "CUST_IDCODE", "CUST_BIRTHDATE", "DOC_SERIAL", "DOC_NUM", "DOC_ISSUED", "DOC_DATE", "DPT_ACCID", "DPT_ACCNUM", "DPT_ACCNAME", "DPT_CURID", "DPT_CURCODE", "DPT_CURNAME", "DPT_SALDO", "DPT_SALDO_PL", "INT_ACCID", "INT_ACCNUM", "INT_ACCNAME", "INT_CURID", "INT_CURCODE", "INT_CURNAME", "INT_SALDO", "INT_SALDO_PL", "INT_KOS", "INT_DOS", "DPT_CUR_DENOM", "BRANCH_ID", "BRANCH_NAME", "WB") AS 
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
          b.name,
          dpt.wb
     FROM int_accn i,
          dpt_vidd v,
          customer c,
          person p,
          saldo a1,
          tabval t2,
          saldo a2,
          tabval t1,
          (SELECT d1.deposit_id dpt_id,
                  d1.nd,
                  d1.datz,
                  d1.acc acc,
                  d1.rnk,
                  d1.vidd,
                  d1.dat_begin,
                  d1.dat_end,
                  d1.LIMIT,
                  NVL (dpt.f_dptw (d1.deposit_id, 'NCASH'), '0') nocash,
                  d1.status,
                  d1.comments,
                  d1.mfo_p,
                  d1.nls_p,
                  SUBSTR (d1.name_p, 1, 38) nms_p,
                  d1.okpo_p,
                  d1.mfo_d,
                  d1.nls_d,
                  d1.nms_d,
                  d1.okpo_d,
                  d1.branch,
                  d1.wb
             FROM dpt_deposit d1
           UNION ALL
           SELECT dc.deposit_id,
                  dc.nd,
                  dc.datz,
                  dc.acc,
                  dc.rnk,
                  dc.vidd,
                  dc.dat_begin,
                  dc.dat_end,
                  dc.LIMIT,
                  NVL (dpt.f_dptw (dc.deposit_id, 'NCASH'), '0') nocash,
                  -1,
                  dc.comments,
                  dc.mfo_p,
                  dc.nls_p,
                  SUBSTR (dc.name_p, 1, 38),
                  dc.okpo_p,
                  dc.mfo_d,
                  dc.nls_d,
                  dc.nms_d,
                  dc.okpo_d,
                  dc.branch,
                  dc.wb
             FROM dpt_deposit_clos dc,
                  (  SELECT MAX (idupd) idupd
                       FROM dpt_deposit_clos
                      WHERE (deposit_id, when) IN (  SELECT deposit_id,
                                                            MAX (when) upd_date
                                                       FROM dpt_deposit_clos
                                                      WHERE (deposit_id, bdate) IN (  SELECT deposit_id,
                                                                                             MAX (
                                                                                                bdate)
                                                                                                bdate
                                                                                        FROM dpt_deposit_clos
                                                                                       WHERE bdate <=
                                                                                                bankdate
                                                                                    GROUP BY deposit_id)
                                                   GROUP BY deposit_id)
                   GROUP BY deposit_id) dcm
            WHERE     dc.idupd = dcm.idupd
                  AND NOT EXISTS
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
          AND dpt.branch = b.branch
          and canilookclient(c.rnk) = 1--COBUSUPABS-4372 Забезпечити можливість обмеження доступу до перегляду/редагування інформації в картках клієнтів певної групи (згідно окремого переліку) для окремих користувачів АБС.;

PROMPT *** Create  grants  V_DPT_PORTFOLIO ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_PORTFOLIO to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_PORTFOLIO to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_PORTFOLIO to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_PORTFOLIO to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_PORTFOLIO to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_DPT_PORTFOLIO to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_PORTFOLIO.sql =========*** End **
PROMPT ===================================================================================== 
