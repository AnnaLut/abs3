

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_VT_UL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_VT_UL ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_VT_UL ("OKPO", "NMK", "FZ", "FDAT5", "FDAT1", "FDAT2", "FDAT3", "FDAT4") AS 
  SELECT substr('00000000'||C.okpo,-8),
       C.nmk, C.FZ,
       f0.FDAT, f1.FDAT, f2.FDAT, f3.FDAT, f4.FDAT
FROM FIN_CUST c,
 (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF=0 group by OKPO) F0,
 (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF=1 group by OKPO) F1,
 (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF=2 group by OKPO) F2,
 (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF=3 group by OKPO) F3,
 (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF=4 group by OKPO) F4
WHERE C.OKPO = f0.OKPO(+) and C.OKPO = f1.OKPO(+) and
      C.OKPO = f2.OKPO(+) and C.OKPO = f3.OKPO(+) and
      C.OKPO = f4.OKPO(+) and NVL(C.custtype,2) = 2 
 ;

PROMPT *** Create  grants  FIN_VT_UL ***
grant SELECT                                                                 on FIN_VT_UL       to BARSREADER_ROLE;
grant SELECT                                                                 on FIN_VT_UL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_VT_UL       to R_FIN2;
grant SELECT                                                                 on FIN_VT_UL       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_VT_UL       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_VT_UL.sql =========*** End *** ====
PROMPT ===================================================================================== 
