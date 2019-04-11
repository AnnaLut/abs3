
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_cust2vidd.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_CUST2VIDD ("RNK", "VIDD", "NAME") AS 
  select c.rnk, t.vidd, t.name
  from cc_vidd  t, customer c
  where tipd = 1
    and vidd < 15
    and nvl(t.blocked,0) = 0
    and t.custtype = case
                       when c.custtype = 3 and c.k050 = '910' then 2
                       else c.custtype
                     end
;
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_cust2vidd.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 