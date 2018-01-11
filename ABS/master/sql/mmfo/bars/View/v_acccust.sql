

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCCUST.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCCUST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCCUST ("ACC", "NLS", "NMS", "KV", "RNK", "KF", "NMK", "OKPO") AS 
  SELECT a.ACC,
          a.NLS,
          a.nms,
          a.KV,
          a.RNK,
          a.kf,
          c.nmk,
          c.OKPO
     FROM Accounts a, Customer c
    WHERE a.rnk = c.rnk AND a.dazs IS NULL
    and substr(a.nls,1,4) in ('2520','2523','2525','2530','2542','2545','2546','2560','2561','2562','2565','2600','2603','2604','2605','2610','2615','2620','2625','2630','2635','2650','2651','2652');

PROMPT *** Create  grants  V_ACCCUST ***
grant SELECT                                                                 on V_ACCCUST       to BARSREADER_ROLE;
grant SELECT                                                                 on V_ACCCUST       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCCUST       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCCUST.sql =========*** End *** ====
PROMPT ===================================================================================== 
