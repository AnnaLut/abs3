CREATE OR REPLACE FORCE VIEW BARS.NBU23_CCK_FL
(  RNK,
   ND,
   WDATE,
   CC_ID,
   VIDD,
   FIN23,
   OBS23,
   KAT23,
   K23,
   FIN_351,
   PD,
   VKR,
   TOBO,
   ZDAT,
   COMM,
   HIST
)
AS
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


GRANT SELECT, UPDATE ON BARS.NBU23_CCK_FL TO BARS_ACCESS_DEFROLE;

GRANT SELECT, UPDATE ON BARS.NBU23_CCK_FL TO START1;