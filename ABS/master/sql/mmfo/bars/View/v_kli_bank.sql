

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KLI_BANK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KLI_BANK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KLI_BANK ("RNK", "SAB", "NMK", "ACC", "NLS", "KV", "VYPISKA", "DEBET", "DAZS", "ISPNO", "ISPFIO") AS 
  SELECT   c.rnk,
            c.sab,
            c.nmk,
            a.acc,
            a.nls,
            a.kv,
            NVL2 (a2.acc, 'Y', ''),
            NVL2 (a3.acc, 'Y', ''),
            a.dazs,
            a.isp,
            s.fio
     FROM   accounts a,
            customer c,
            staff s,
            acce a2,
            acci a3
    WHERE c.custtype = 2
--      c.sab IS NOT NULL
--            AND c.stmt = 5
            AND c.rnk = a.rnk
            AND a.isp = s.id
            AND a.acc = a2.acc(+)
            AND a.acc = a3.acc(+);

PROMPT *** Create  grants  V_KLI_BANK ***
grant FLASHBACK,SELECT                                                       on V_KLI_BANK      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KLI_BANK      to START1;
grant FLASHBACK,SELECT                                                       on V_KLI_BANK      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KLI_BANK.sql =========*** End *** ===
PROMPT ===================================================================================== 
