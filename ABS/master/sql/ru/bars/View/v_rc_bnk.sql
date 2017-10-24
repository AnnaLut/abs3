

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RC_BNK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RC_BNK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RC_BNK ("B010", "NAME") AS 
  select b010, name from rc_bnk
 union all
select country || '0000000', null from country;

PROMPT *** Create  grants  V_RC_BNK ***
grant SELECT                                                                 on V_RC_BNK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RC_BNK        to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RC_BNK.sql =========*** End *** =====
PROMPT ===================================================================================== 
