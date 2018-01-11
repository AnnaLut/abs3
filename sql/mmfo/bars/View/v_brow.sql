

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BROW.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BROW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BROW ("INSP", "SOS", "RNK", "NMK", "CC_ID", "ND", "DAT1", "DAT4", "KV", "NLS", "ACC", "LIMIT", "IR", "OSTC", "TOBO", "LIM", "ACRA", "NLS8", "TXT", "DNI", "IR0", "IRB", "FL1") AS 
  SELECT INSP, SOS,  RNK,  NMK, CC_ID, ND, DAT1, DAT4,
        KV, NLS, ACC, LIMIT, IR, OSTC, TOBO,
        LIM , ACRA, NLS8, to_number(TXT)/100 TXT, DNI,
        IR0, (IR-IR0) IRB, 0 FL1
FROM
 (
   SELECT BR1.INSP, BR1.SOS, BR1.RNK, BR1.NMK, BR1.CC_ID, BR1.ND, BR1.DAT1, BR1.DAT4,
          BR1.KV,  BR1.NLS, BR1.ACC, BR1.LIMIT, BR1.IR, BR1.OSTC, BR1.TOBO,
          BR1.LIM , ar.ACC ACRA, AR.NLS NLS8, substr(t.txt,1,16) TXT, BR1.DNI,
          acrn.fprocn ( BR1.ACC,1,gl.BD) IR0
   FROM ( SELECT d.SOS ,
                 d.RNK, c.NMK, d.CC_ID, d.ND, d.user_id INSP,
                 d.sdate DAT1, d.wdate DAT4, d.wdate-d.sdate DNI,
                 accounts.KV, accounts.NLS, accounts.ACC, d.LIMIT,  accounts.ostc/100 OSTC,
                 d.IR, accounts.TOBO, -accounts.lim/100 LIM
          FROM cc_deal d, customer c, V_GL accounts, nd_acc n
          WHERE n.nd=d.nd  and n.acc = accounts.acc and d.vidd = 26 and d.rnk=c.rnk
         ) BR1,
        (Select * from accounts where tip ='BRO' ) ar ,
        (Select * from nd_txt where  tag = 'KNL' ) t
   WHERE BR1.ND = t.nd (+) and BR1.rnk = ar.rnk (+)
  );

PROMPT *** Create  grants  V_BROW ***
grant SELECT                                                                 on V_BROW          to BARSREADER_ROLE;
grant SELECT                                                                 on V_BROW          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BROW          to START1;
grant SELECT                                                                 on V_BROW          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BROW.sql =========*** End *** =======
PROMPT ===================================================================================== 
