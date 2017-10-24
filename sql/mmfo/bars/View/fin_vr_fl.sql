

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_VR_FL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_VR_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_VR_FL ("RNK", "OKPO", "NMK", "SPD", "FDAT5", "FDAT4", "FIN", "NAME") AS 
  SELECT c.rnk, c.okpo, c.nmk, decode (NVL(c.sed,0), 91, 'ÑÏÄ','ÔÎ'),
       f0.FDAT, f4.FDAT, c.crisk, s.name
FROM customer c, stan_fin S,
  (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF in (0,10) group by OKPO) F0,
  (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF=4 group by OKPO) F4
WHERE c.country=804 and c.OKPO =f0.OKPO(+) AND c.OKPO = f4.OKPO(+) and
   NVL(c.crisk,0)=s.FIN (+) and c.custtype=3 and c.DATE_OFF is null 
 ;

PROMPT *** Create  grants  FIN_VR_FL ***
grant SELECT                                                                 on FIN_VR_FL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_VR_FL       to R_FIN2;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_VR_FL       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_VR_FL.sql =========*** End *** ====
PROMPT ===================================================================================== 
