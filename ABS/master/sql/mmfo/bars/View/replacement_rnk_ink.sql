

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/REPLACEMENT_RNK_INK.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view REPLACEMENT_RNK_INK ***

  CREATE OR REPLACE FORCE VIEW BARS.REPLACEMENT_RNK_INK ("ACC", "NBS", "OB22", "NLS", "NMS", "BRANCH", "RNK", "NMK", "CUSTTYPE", "OKPO", "BC") AS 
  SELECT acc,
            nbs,
            ob22,
            nls,
            a.nms,
            a.branch,
            a.rnk,
            nmk,
            c.custtype,
            c.okpo,
            c.bc
       FROM v_gl a, customer c
      WHERE     (   (nbs = '3578' AND ob22 IN ('17', '09', '41', '45'))                 
                 OR (nbs = '2909' AND ob22 IN ('43'))
                 or nbs in ('3610', '3619', '3519','3510')
                 )
          and (a.nls like '35%' or a.nls like '36%')
            AND dazs IS NULL
            AND a.rnk = c.rnk
   ORDER BY branch;

PROMPT *** Create  grants  REPLACEMENT_RNK_INK ***
grant FLASHBACK,SELECT,UPDATE                                                on REPLACEMENT_RNK_INK to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on REPLACEMENT_RNK_INK to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/REPLACEMENT_RNK_INK.sql =========*** En
PROMPT ===================================================================================== 
