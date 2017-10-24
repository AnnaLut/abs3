

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBDK_PARTNER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBDK_PARTNER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBDK_PARTNER ("RNK", "NMK", "MFO", "BIC") AS 
  select c.rnk, c.NMK, b.mfo, b.bic
from CUSTOMER c
join CUSTBANK b on c.rnk = b.rnk
where c.DATE_OFF is null
    and c.custtype=1
    and ( ( c.codcagent = 1 and b.mfo <> '300465' )
           or
          ( c.codcagent = 2 and b.bic is not null )
        )
    and c.codcagent in (1,2);

PROMPT *** Create  grants  V_MBDK_PARTNER ***
grant SELECT                                                                 on V_MBDK_PARTNER  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBDK_PARTNER.sql =========*** End ***
PROMPT ===================================================================================== 
