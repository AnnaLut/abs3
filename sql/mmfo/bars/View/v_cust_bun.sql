

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUST_BUN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUST_BUN ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUST_BUN ("RNK_WHO", "NMK_WHO", "LINKS", "NOTES") AS 
  (  SELECT c1.rnk, c1.nmk, cr.RELATEDNESS||' '||c2.nmk||' (–Õ ='||c2.rnk||')', cb.notes
   FROM customer c1, customer c2, cust_bun cb, cust_rel cr
   WHERE c2.rnk=cb.rnkb and c1.rnk=cb.rnka and cb.id_rel=cr.id )
ORDER BY c1.rnk, c2.rnk;

PROMPT *** Create  grants  V_CUST_BUN ***
grant SELECT                                                                 on V_CUST_BUN      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUST_BUN      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_BUN.sql =========*** End *** ===
PROMPT ===================================================================================== 
