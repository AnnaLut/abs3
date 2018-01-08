

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_W1.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_W1 ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_W1 ("ID", "ND", "CC_ID", "RNK", "AIM", "KV", "S", "DSDATE", "GPK", "INS_DEAL", "TRANS", "DWDATE", "S080", "PR", "OSTC", "NLS", "NLS_SS", "ACC", "SROK", "SOS", "OBS", "FIN", "CRISK", "K23", "NAMK", "ACC8", "DAY", "DAZS", "OKPO", "SDOG", "BRANCH", "MFOKRED", "ACCKRED") AS 
  SELECT d.user_id,
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
          d.LIMIT,
          d.sdate,
          DECODE (a8.vid,
                  2, 'Класичний',
                  4, 'Аннуiтет',
                  'Iндивiд.')
             gpk,
          make_url ('/barsroot/ins/deals.aspx',
                    'Страховки',
                    'fid',
                    'mgru',
                    'type',
                    'mgr',
                    'nd',
                    d.nd)
             ins_deal,
          DECODE (cck_app.get_nd_txt (d.nd, 'PR_TR'),
                  1, 'Транши',
                  NULL)
             trans,
          d.wdate,
          p.s080,
          acrn.fprocn (ac.acc, 0, ''),
          -a8.ostc / 100,
          make_url ('/barsroot/customerlist/custacc.aspx',
                    'Рахунки',
                    'type',
                    '3',
                    'nd',
                    TO_CHAR (d.nd))
             nls,
          ac.nls nls_ss,
          ac.acc,
          ABS (ROUND (MONTHS_BETWEEN (d.wdate, ad.wdate))),
          d.sos,
          d.obs23 obs,
          d.fin23 fin,
          d.kat23 crisk,
          d.k23,
          c.nmk,
          a8.acc,
          i.s,
          a8.dazs,
          c.okpo,
          d.sdog,
          d.branch,
          ad.mfokred,
          ad.acckred
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
          AND d.vidd IN (1, 2, 3);

PROMPT *** Create  grants  CC_W1 ***
grant SELECT                                                                 on CC_W1           to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on CC_W1           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_W1           to RCC_DEAL;
grant SELECT                                                                 on CC_W1           to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_W1           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_W1           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_W1.sql =========*** End *** ========
PROMPT ===================================================================================== 
