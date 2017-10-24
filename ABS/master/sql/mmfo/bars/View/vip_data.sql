

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VIP_DATA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view VIP_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.VIP_DATA ("NMK", "OKPO", "ADR", "SER", "NUMDOC", "PDATE", "ORGAN", "BDAY", "BPLACE", "TELD", "TELW") AS 
  SELECT C.NMK, C.OKPO, C.ADR, P.SER, P.NUMDOC, P.PDATE, P.ORGAN, P.BDAY, P.BPLACE, P.TELD, P.TELW
FROM CUSTOMER C, PERSON P
WHERE C.RNK = P.RNK and c.rnk in (select rnk from customer_update where doneby in ('USER38','USER57','USER516'))
ORDER BY C.NMK;

PROMPT *** Create  grants  VIP_DATA ***
grant SELECT                                                                 on VIP_DATA        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VIP_DATA        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VIP_DATA.sql =========*** End *** =====
PROMPT ===================================================================================== 
