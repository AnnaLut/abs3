

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_VP.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_VP ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_VP ("CC_ID", "ND", "SDATE", "NMK", "KV", "SDOG", "OST", "SUMP", "POGACH") AS 
  SELECT /*+ ordered */
          cc_id, nd, sdate, nmk, kv, sdog, ost, sump,
          make_url ('/barsroot/credit/repayment.aspx',
                    'Виконати',
                    'ccid',
                    cc_id,
                    'dat1',
                    TO_CHAR (sdate, 'yyyyMMdd')
                   ) pogach
     FROM (SELECT d.cc_id, d.nd, d.sdate, c.nmk, a.kv, d.sdog,
                  -a.ostc / 100 ost, GREATEST (a.ostx - a.ostc, 0) / 100 sump
             FROM cc_deal d, nd_acc n, accounts a, customer c
            WHERE d.branch LIKE
                              SYS_CONTEXT ('bars_context', 'user_branch_mask')
              AND d.nd = n.nd
              AND d.rnk = c.rnk
              AND n.acc = a.acc
              AND a.tip = 'LIM'
              AND d.sos >= 10
              AND a.ostc < 0
              AND a.ostc = a.ostb) 
 ;

PROMPT *** Create  grants  CC_VP ***
grant FLASHBACK,SELECT                                                       on CC_VP           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_VP           to RCC_DEAL;
grant FLASHBACK,SELECT                                                       on CC_VP           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_VP.sql =========*** End *** ========
PROMPT ===================================================================================== 
