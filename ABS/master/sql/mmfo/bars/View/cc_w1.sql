
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/cc_w1.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.CC_W1 ("ID", "ND", "CC_ID", "RNK", "AIM", "KV", "S", "DSDATE", "GPK", "INS_DEAL", "TRANS", "DWDATE", "PR", "OSTC", "NLS", "NLS_SS", "ACC", "SROK", "SOS", "NAMK", "ACC8", "DAY", "DAZS", "OKPO", "SDOG", "BRANCH", "MFOKRED", "ACCKRED", "VKR", "CLASS_COR", "PD", "CLASS_INT") AS 
  SELECT d.user_id as id,
          d.nd,
          d.cc_id,
          make_url ('/barsroot/clientregister/registration.aspx',
                    d.rnk,
                    'readonly',
                    '1',
                    'rnk',
                    TO_CHAR (d.rnk))
             AS rnk,
          ad.aim,
          a8.kv,
          d.LIMIT as s,
          d.sdate as dsdate,
          DECODE (a8.vid,
                  2, '���������',
                  4, '����i���',
                  'I����i�.')
             gpk,
          make_url ('/barsroot/ins/deals.aspx',
                    '���������',
                    'fid',
                    'mgru',
                    'type',
                    'mgr',
                    'nd',
                    d.nd)
             ins_deal,
          DECODE (cck_app.get_nd_txt (d.nd, 'PR_TR'),
                  1, '������',
                  NULL)
             trans,
          d.wdate as dwdate,
          acrn.fprocn (ac.acc, 0, '') as pr,
          -a8.ostc / 100 as ostc,
          make_url ('/barsroot/customerlist/custacc.aspx',
                    '�������',
                    'type',
                    '3',
                    'nd',
                    TO_CHAR (d.nd))
             nls,
          ac.nls nls_ss,
          ac.acc,
          ABS (ROUND (MONTHS_BETWEEN (d.wdate, ad.wdate))) as srok,
          d.sos,
          c.nmk as namk,
          a8.acc as acc8,
          i.s as day,
          a8.dazs,
          c.okpo,
          d.sdog,
          d.branch,
          ad.mfokred,
          ad.acckred,
          fin_zp.zn_vncrr(c.rnk, d.nd) as VKR,
          FIN_NBU.ZN_P_ND('CLS',  56, sysdate, d.ND, c.RNK, null) as class_cor,
          FIN_NBU.ZN_P_ND('PD',   56, sysdate, d.ND, c.RNK, null) as pd,
          FIN_NBU.ZN_P_ND('CLAS', 56,  sysdate, d.ND, c.RNK, null) as class_int
     FROM cc_deal d,
          accounts ac,
          specparam p,
          customer c,
          accounts a8,
          int_accn i,
          cc_add ad,
          nd_acc n
    WHERE     ad.nd = d.nd
          AND ad.adds = 0
          AND n.nd = d.nd
          AND c.rnk = d.rnk
          AND ad.accs = ac.acc(+)
          AND ad.accs = p.acc(+)
          AND i.acc(+) = a8.acc
          AND i.id(+) = 0
          AND n.acc = a8.acc
          AND a8.tip = 'LIM'
          AND d.vidd IN (1, 2, 3, 5)
;
 show err;
 
PROMPT *** Create  grants  CC_W1 ***
grant SELECT                                                                 on CC_W1           to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on CC_W1           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_W1           to RCC_DEAL;
grant SELECT                                                                 on CC_W1           to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_W1           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_W1           to WR_REFREAD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/cc_w1.sql =========*** End *** ========
 PROMPT ===================================================================================== 
 