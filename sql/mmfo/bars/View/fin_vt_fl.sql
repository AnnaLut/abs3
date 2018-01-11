

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_VT_FL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_VT_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_VT_FL ("OKPO", "NMK", "SPD", "FDAT5", "FDAT4") AS 
  SELECT substr('0000000000'||C.okpo,-10),
   C.nmk, decode(C.custtype,3,'ÔÎ','ÑÏÄ'), f0.FDAT, f4.FDAT
FROM FIN_CUST c,
  (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF in(0,10) group by OKPO) F0 ,
  (select OKPO, max(FDAT) FDAT from FIN_RNK where IDF=4 group by OKPO) F4
WHERE C.OKPO=f0.OKPO(+) AND C.OKPO=f4.OKPO(+) and C.custtype in (3,23)
 ;

PROMPT *** Create  grants  FIN_VT_FL ***
grant SELECT                                                                 on FIN_VT_FL       to BARSREADER_ROLE;
grant SELECT                                                                 on FIN_VT_FL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_VT_FL       to R_FIN2;
grant SELECT                                                                 on FIN_VT_FL       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_VT_FL       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_VT_FL.sql =========*** End *** ====
PROMPT ===================================================================================== 
