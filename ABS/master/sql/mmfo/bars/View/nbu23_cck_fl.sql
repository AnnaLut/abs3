

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_CCK_FL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_CCK_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_CCK_FL ("RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "OBS23", "KAT23", "K23", "FIN_351", "PD", "VKR", "TOBO", "ZDAT", "COMM", "HIST") AS 
  SELECT d.RNK,
          d.ND,
          d.WDATE,
          d.CC_ID,
          d.vidd,
          d.FIN23,
          d.OBS23,
          d.KAT23,
          d.k23,
          d.fin_351,
          d.pd,
          CCK_APP.Get_ND_TXT (d.nd, 'VNCRR') VKR,
          d.branch,
          TO_CHAR (ROUND (gl.bd, 'mm'), 'dd/mm/yyyy') ZDAT,
          (select comm from nbu23_cck_ul_kor
           where nd=d.nd and zdat=ROUND (gl.bd, 'mm') and
                 pdat = (select max(pdat) from nbu23_cck_ul_kor where nd=d.nd and zdat=ROUND (gl.bd, 'mm'))) comm,
          'Переглянути' hist
     FROM cc_deal d  WHERE d.sos > 9 AND d.sos < 15 AND d.vidd IN (11, 12, 13);

PROMPT *** Create  grants  NBU23_CCK_FL ***
grant SELECT                                                                 on NBU23_CCK_FL    to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on NBU23_CCK_FL    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_CCK_FL    to START1;
grant SELECT                                                                 on NBU23_CCK_FL    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_CCK_FL.sql =========*** End *** =
PROMPT ===================================================================================== 
