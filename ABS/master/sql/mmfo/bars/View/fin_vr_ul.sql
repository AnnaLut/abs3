

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_VR_UL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_VR_UL ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_VR_UL ("RNK", "OKPO", "NMK", "FZ", "FDAT5", "FDAT1", "FDAT2", "FDAT3", "FDAT4", "FIN", "NAME") AS 
  select c.rnk,c.okpo, c.nmk, DECODE( UPPER( NVL(w.value,' ')),'M','M',''),
  f0.FDAT, f1.FDAT, f2.FDAT, f3.FDAT, f4.FDAT, c.crisk, s.name
 FROM customer c, stan_fin S, customerw w,
   (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF=0 group by OKPO) F0,
   (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF=1 group by OKPO) F1,
   (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF=2 group by OKPO) F2,
   (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF=3 group by OKPO) F3,
   (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF=4 group by OKPO) F4
 WHERE c.OKPO = f0.OKPO(+) and c.OKPO = f1.OKPO(+) and
       c.OKPO = f2.OKPO(+) and c.OKPO = f3.OKPO(+) and
       c.OKPO = f4.OKPO(+) and c.DATE_OFF is null  and
       c.rnk=w.rnk (+) and w.tag (+) ='FZ' and
       NVL(c.crisk,0) = s.FIN (+) and c.custtype =2 
 ;

PROMPT *** Create  grants  FIN_VR_UL ***
grant SELECT                                                                 on FIN_VR_UL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_VR_UL       to R_FIN2;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_VR_UL       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_VR_UL.sql =========*** End *** ====
PROMPT ===================================================================================== 
