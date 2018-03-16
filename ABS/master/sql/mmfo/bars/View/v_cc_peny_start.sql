

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CC_PENY_START.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CC_PENY_START ***

CREATE OR REPLACE FORCE VIEW BARS.V_CC_PENY_START
(
   ACC,
   NMK,
   NLS,
   KV,
   OSTC,
   BRANCH,
   SUM,
   OST_SN8,
   NLS_SN8,
   IR,
   ACC_SN8,
   ND
)
AS
   SELECT acc,
          nmk,
          nls,
          kv,
          ostc,
          branch,
          SUM,
          ost_sn8,
          nls_sn8,
          ir,
          acc_sn8,
          nd
     FROM (  SELECT a.acc,
                    c.nmk,
                    a.nls,
                    a.kv,
                    TO_CHAR (p.ostc / 100,
                             '99999999999D99',
                             'NLS_NUMERIC_CHARACTERS = ''. ''')
                       ostc,
                    a.branch,
                    TO_CHAR (a.ostc / 100,
                             '99999999999D99',
                             'NLS_NUMERIC_CHARACTERS = ''. ''')
                       SUM,
                    TO_CHAR (
                         fost (
                            NVL (
                               p.acc_sn8,
                               (SELECT aa.acc
                                  FROM accounts aa, nd_acc na
                                 WHERE     na.acc = aa.acc
                                       AND na.nd = n.nd
                                       AND aa.tip = 'SN8'
                                       AND ROWNUM = 1)),
                            gl.bd)
                       / 100,
                       '99999999999D99',
                       'NLS_NUMERIC_CHARACTERS = ''. ''')
                       ost_sn8,
                    p.nls_sn8,
                    (SELECT CASE
                               WHEN br IS NOT NULL
                               THEN
                                  'Базова ставка'
                               ELSE
                                  TO_CHAR (ir)
                            END
                       FROM int_ratn r
                      WHERE     ID = 2
                            AND acc = a.acc
                            AND bdat = (SELECT MAX (bdat)
                                          FROM int_ratn
                                         WHERE acc = a.acc AND ID = 2))
                       ir,
                    p.acc_sn8,
                    n.nd,
                    ROW_NUMBER ()
                    OVER (PARTITION BY n.nd
                          ORDER BY n.nd, p.ostc DESC NULLS LAST)
                       AS numb_nd
               FROM saldo a,
                    customer c,
                    cc_peny_start p,
                    nd_acc n,
                    cc_deal d
              WHERE     a.rnk = c.rnk
                    AND n.acc = a.acc
                    AND a.acc = p.acc(+)
                    AND a.dazs IS NULL
                    AND a.tip IN ('SP ', 'SPN', 'SK9')
                    AND D.ND = n.nd
                    and D.VIDD <>110 -- Умышленно убрал овердрафты так как они не подходят под этот функционал дублируют проводки
           ORDER BY n.nd, a.tip)
    WHERE     numb_nd = 1;

PROMPT *** Create  grants  V_CC_PENY_START ***
grant SELECT                                                                 on V_CC_PENY_START to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CC_PENY_START to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CC_PENY_START to RCC_DEAL;
grant SELECT                                                                 on V_CC_PENY_START to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_CC_PENY_START to WR_ALL_RIGHTS;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CC_PENY_START to WR_CREDIT;
grant FLASHBACK,SELECT                                                       on V_CC_PENY_START to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CC_PENY_START.sql =========*** End **
PROMPT ===================================================================================== 
