

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_LKL_RRP_LIM.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_LKL_RRP_LIM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_LKL_RRP_LIM ("ACC", "CLMFO", "KV", "CLNAM", "CLOST", "CLDOS", "CLKOS", "CLLTK", "CLLNO", "MFOP", "CLLCV", "CLOSTN", "CLOSTNL") AS 
  SELECT a.acc,
            lkl_rrp.mfo AS clMfo,
            lkl_rrp.kv,
            a.nms AS clNam,
            a.ostc AS clOst,
            a.dos AS clDos,
            a.kos clKos,
            DECODE (c.mfop, GetGlobalOption ('MFO'), -a.lim, lkl_rrp.lim)
               AS clLTK,
            lkl_rrp.lno AS clLNO,
            c.mfop,
            v.lcv AS clLCV,
              (SELECT SUM (ostc)
                 FROM accounts a, bank_acc b
                WHERE     a.tip IN ('TUR', 'TUD')
                      AND a.acc = b.acc
                      AND b.mfo = lkl_rrp.mfo)
            + a.ostc
               AS clOstN,
              (SELECT SUM (ostc)
                 FROM accounts a, bank_acc b
                WHERE     a.tip IN ('TUR', 'TUD')
                      AND a.acc = b.acc
                      AND b.mfo = lkl_rrp.mfo)
            + a.ostc
            - (DECODE (c.mfop, GetGlobalOption ('MFO'), -a.lim, lkl_rrp.lim))
               AS clOstNL
       FROM lkl_rrp,
            bank_acc b,
            accounts a,
            banks c,
            tabval v
      WHERE     lkl_rrp.mfo = b.mfo
            AND a.kv = lkl_rrp.kv
            AND c.mfo = lkl_rrp.mfo
            AND a.acc = b.acc
            AND a.tip = 'L00'
            AND v.kv = lkl_rrp.kv
   ORDER BY lkl_rrp.mfo, lkl_rrp.kv;

PROMPT *** Create  grants  V_LKL_RRP_LIM ***
grant SELECT                                                                 on V_LKL_RRP_LIM   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_LKL_RRP_LIM.sql =========*** End *** 
PROMPT ===================================================================================== 
