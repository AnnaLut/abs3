

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_CCK_BN.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_CCK_BN ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_CCK_BN ("B", "RNK", "ND", "WDATE", "CC_ID", "VIDD", "FIN23", "FIN_351", "PD", "OBS23", "KAT23", "K23", "TOBO", "VNCRR", "KHIST", "NEINF", "ZDAT", "COMM", "HIST") AS 
  SELECT NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd),
          d.RNK,
          d.ND,
          d.WDATE,
          d.CC_ID,
          d.vidd,
          d.FIN23,
          d.fin_351,
          d.pd,
          d.OBS23,
          d.KAT23,
          d.k23,
          d.branch,
          SUBSTR (cck_app.get_nd_txt (d.ND, 'VNCRR'), 1, 4) VNCRR,
          TO_NUMBER (cck_app.get_nd_txt (d.ND, 'KHIST')) KHIST,
          TO_NUMBER (cck_app.get_nd_txt (d.ND, 'NEINF')) NEINF,
          TO_CHAR (ROUND (gl.bd, 'mm'), 'dd/mm/yyyy') ZDAT,
          SUBSTR (cck_app.get_nd_txt (d.ND, 'V'), 1, 254) comm,
          'Переглянути' hist
     FROM cc_deal d
    WHERE (d.sos > 9 AND d.sos < 15 OR d.wdate >= NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd))
          AND d.vidd >= 1500 AND d.vidd < 1600 AND d.sdate < NVL (TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'), gl.bd);

PROMPT *** Create  grants  NBU23_CCK_BN ***
grant SELECT                                                                 on NBU23_CCK_BN    to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on NBU23_CCK_BN    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_CCK_BN    to START1;
grant SELECT                                                                 on NBU23_CCK_BN    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_CCK_BN.sql =========*** End *** =
PROMPT ===================================================================================== 
