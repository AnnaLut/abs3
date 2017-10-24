

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MWAY_DPT_PORTFOLIO_ALL.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MWAY_DPT_PORTFOLIO_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MWAY_DPT_PORTFOLIO_ALL ("DPT_ID", "DPT_NUM", "DPT_DAT", "DAT_BEGIN", "DAT_END", "VIDD_CODE", "VIDD_NAME", "RATE", "DPT_AMOUNT", "DPT_NOCASH", "DPT_STATUS", "DPT_COMMENTS", "DPTRCP_MFO", "DPTRCP_ACC", "DPTRCP_NAME", "DPTRCP_IDCODE", "INTRCP_MFO", "INTRCP_ACC", "INTRCP_NAME", "INTRCP_IDCODE", "CUST_ID", "CUST_NAME", "CUST_IDCODE", "CUST_BIRTHDATE", "DOC_SERIAL", "DOC_NUM", "DOC_ISSUED", "DOC_DATE", "DPT_ACCID", "DPT_ACCNUM", "DPT_ACCNAME", "DPT_DAZS", "DPT_CURID", "DPT_CURCODE", "DPT_CURNAME", "DPT_SALDO", "DPT_SALDO_PL", "DPT_LOCK", "INT_ACCID", "INT_ACCNUM", "INT_ACCNAME", "INT_CURID", "INT_CURCODE", "INT_CURNAME", "INT_SALDO", "INT_SALDO_PL", "INT_KOS", "INT_DOS", "BRANCH_ID", "BRANCH_NAME", "FL_INT_PAYOFF", "FL_AVANS_PAYOFF", "DPT_CUR_DENOM", "FREQ_N", "FREQ_K", "TERM_TYPE", "DURATION", "DURATION_DAYS", "DISABLE_ADD", "FREQ_K_NAME", "FL_DUBL", "COMPROC", "FLAG", "PRODUCT_CODE") AS 
  SELECT d.deposit_id,
          d.nd,
          d.datz,
          d.dat_begin,
          d.dat_end,
          v.vidd,
          v.type_name,
          dpt_web.get_dptrate (a1.acc,
                               a1.kv,
                               d.LIMIT,
                               TRUNC (SYSDATE)),
          d.LIMIT,
          NVL (dpt.f_dptw (d.deposit_id, 'NCASH'), '0') nocash,
          d.status,
          d.comments,
          d.mfo_d,
          d.nls_d,
          d.nms_d,
          d.okpo_d,
          d.mfo_p,
          d.nls_p,
          SUBSTR (d.name_p, 1, 38),
          d.okpo_p,
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
          a1.dazs,
          a1.kv,
          t1.lcv,
          t1.name,
          a1.ostc,
          a1.ostb,
          SIGN (a1.blkd),
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
          b.branch,
          b.name,
          dpt.payoff_enable (a2.acc,
                             d.freq,
                             DECODE (v.amr_metr, 0, 0, 1),
                             d.dat_begin,
                             d.dat_end,
                             bankdate,
                             DECODE (NVL (d.cnt_dubl, 0), 0, 0, 1)),
          DECODE (v.amr_metr, 0, 0, 1),
          t1.denom,
          v.freq_n,
          v.freq_k,
          v.term_type,
          v.duration,
          v.duration_days,
          v.disable_add,
          f.name AS freq_k_name,
          v.fl_dubl,
          v.comproc,
          v.flag,
          dt.type_id AS product_code
     FROM dpt_deposit d,
          dpt_vidd v,
          customer c,
          person p,
          int_accn i,
          accounts a1,
          accounts a2,
          tabval$global t2,
          tabval$global t1,
          branch b,
          freq f,
          dpt_types dt
    WHERE     d.acc = a1.acc
          AND d.acc = i.acc
          AND i.id = 1
          AND i.acra = a2.acc
          AND a1.kv = t1.kv
          AND a2.kv = t2.kv
          AND d.vidd = v.vidd
          AND d.rnk = c.rnk
          AND c.rnk = p.rnk
          AND v.freq_k = f.freq
          AND d.branch = b.branch
          AND v.type_cod = dt.type_code;

PROMPT *** Create  grants  V_MWAY_DPT_PORTFOLIO_ALL ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_MWAY_DPT_PORTFOLIO_ALL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MWAY_DPT_PORTFOLIO_ALL.sql =========*
PROMPT ===================================================================================== 
