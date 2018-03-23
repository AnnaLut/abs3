

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RC_BNK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RC_BNK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RC_BNK ("B010", "NAME") AS 
  select B010, NAME
  from BARS.RC_BNK
 union ALL
select to_char(COUNTRY,'FM000') || '0000000', NULL
  from BARS.COUNTRY
;

PROMPT *** Create  grants  V_RC_BNK ***
grant SELECT                                                                 on V_RC_BNK        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RC_BNK        to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RC_BNK.sql =========*** End *** =====
PROMPT ===================================================================================== 
