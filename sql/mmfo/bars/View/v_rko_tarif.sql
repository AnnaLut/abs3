

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RKO_TARIF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RKO_TARIF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RKO_TARIF ("ACC", "INDPAR", "INDPAR_NAME", "ORGAN", "DATE_OPEN", "DATE_CLOSE") AS 
  select a.acc, a.id indpar, a.name indpar_name, t.organ, t.date_open, t.date_close
  from ( select a.acc, p.id, p.name
           from v_rko_accounts a, rko_indpar p ) a, rko_tarif t
 where a.acc = t.acc(+)
   and a.id = t.indpar(+);

PROMPT *** Create  grants  V_RKO_TARIF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_RKO_TARIF     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_RKO_TARIF     to CUST001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RKO_TARIF.sql =========*** End *** ==
PROMPT ===================================================================================== 
