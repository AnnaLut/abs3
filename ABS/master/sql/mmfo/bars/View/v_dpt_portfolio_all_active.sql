

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_PORTFOLIO_ALL_ACTIVE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_PORTFOLIO_ALL_ACTIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_PORTFOLIO_ALL_ACTIVE ("DPT_ID", "DPT_NUM", "DPT_DAT", "DAT_BEGIN", "DAT_END", "VIDD_CODE", "VIDD_NAME", "RATE", "DPT_AMOUNT", "DPT_NOCASH", "DPT_STATUS", "DPT_COMMENTS", "DPTRCP_MFO", "DPTRCP_ACC", "DPTRCP_NAME", "DPTRCP_IDCODE", "INTRCP_MFO", "INTRCP_ACC", "INTRCP_NAME", "INTRCP_IDCODE", "ARCHDOC_ID", "CUST_ID", "CUST_NAME", "CUST_IDCODE", "CUST_BIRTHDATE", "DOC_SERIAL", "DOC_NUM", "DOC_ISSUED", "DOC_DATE", "DPT_ACCID", "DPT_ACCNUM", "DPT_ACCNAME", "DPT_CURID", "DPT_CURCODE", "DPT_CURNAME", "DPT_SALDO", "DPT_SALDO_PL", "DPT_LOCK", "INT_ACCID", "INT_ACCNUM", "INT_ACCNAME", "INT_CURID", "INT_CURCODE", "INT_CURNAME", "INT_SALDO", "INT_SALDO_PL", "INT_KOS", "INT_DOS", "BRANCH_ID", "BRANCH_NAME", "FL_INT_PAYOFF", "FL_AVANS_PAYOFF", "DPT_CUR_DENOM", "WB") AS 
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
          d.archdoc_id,
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
          d.wb
     FROM dpt_deposit d,
          dpt_vidd v,
          customer c,
          person p,
          int_accn i,
          accounts a1,
          accounts a2,
          tabval$global t2,
          tabval$global t1,
          branch b
    WHERE     d.acc = a1.acc
          AND d.acc = i.acc
          AND i.id = 1
          AND i.acra = a2.acc
          AND a1.kv = t1.kv
          AND a2.kv = t2.kv
          AND d.vidd = v.vidd
          AND d.rnk = c.rnk
          AND c.rnk = p.rnk
          AND d.branch = b.branch
          AND d.archdoc_id >= 0 -- Виключити можливість відображення в АРМі «Робота з клієнтом» за старою схемою (http://jira.unity-bars.com.ua:11000/browse/BRSMAIN-2605)
	  and canilookclient(c.rnk) = 1 --COBUSUPABS-4372 Забезпечити можливість обмеження доступу до перегляду/редагування інформації в картках клієнтів певної групи (згідно окремого переліку) для окремих користувачів АБС.;

PROMPT *** Create  grants  V_DPT_PORTFOLIO_ALL_ACTIVE ***
grant DEBUG,DELETE,FLASHBACK,INSERT,MERGE VIEW,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on V_DPT_PORTFOLIO_ALL_ACTIVE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_PORTFOLIO_ALL_ACTIVE to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_PORTFOLIO_ALL_ACTIVE to DPT_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_PORTFOLIO_ALL_ACTIVE.sql ========
PROMPT ===================================================================================== 
