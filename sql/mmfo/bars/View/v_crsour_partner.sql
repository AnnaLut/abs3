

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CRSOUR_PARTNER.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CRSOUR_PARTNER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CRSOUR_PARTNER ("RNK", "MFO", "NMK") AS 
  select c.rnk, b.mfo, c.nmk from customer c
join custbank b on b.rnk = c.rnk
where c.kf = sys_context('bars_context', 'user_mfo') and
      c.date_off is null and
      c.custtype = 1 and
      c.rnk in (select rnk from custbank b
                where c.codcagent = 9 and
                      b.mfo is not null /*and
                      b.mfo <> sys_context('bars_context', 'user_mfo')*/);

PROMPT *** Create  grants  V_CRSOUR_PARTNER ***
grant SELECT                                                                 on V_CRSOUR_PARTNER to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CRSOUR_PARTNER.sql =========*** End *
PROMPT ===================================================================================== 
