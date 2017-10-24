

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_CCK_BN_KOR.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_CCK_BN_KOR ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_CCK_BN_KOR ("B", "RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "TOBO", "ZDAT", "COMM", "HIST") AS 
  SELECT NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd),
          d.RNK,
          d.ND,
          d.WDATE,
          d.CC_ID,
          d.vidd,
          d.FIN23,
          d.OBS23,
          d.KAT23,
          d.k23,
          d.branch,
          TO_CHAR (ROUND (sysdate, 'mm'), 'dd/mm/yyyy') ZDAT,
          (select comm from Nbu23_Cck_Ul_Kor
           where pdat = (select max(pdat)  from Nbu23_Cck_Ul_Kor
                         where  zdat=round(sysdate,'MM') and nd = d.nd ) and nd = d.nd and zdat=round(sysdate,'MM') ) comm,
          'Переглянути' hist
     FROM cc_deal d
    WHERE (d.sos > 9 AND d.sos < 15 OR d.wdate >= NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd))
          AND d.vidd >= 1500 AND d.vidd < 1600 AND d.sdate < NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd);

PROMPT *** Create  grants  NBU23_CCK_BN_KOR ***
grant SELECT,UPDATE                                                          on NBU23_CCK_BN_KOR to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_CCK_BN_KOR to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_CCK_BN_KOR.sql =========*** End *
PROMPT ===================================================================================== 
