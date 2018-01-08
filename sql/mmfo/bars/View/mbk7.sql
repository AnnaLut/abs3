

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MBK7.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view MBK7 ***

  CREATE OR REPLACE FORCE VIEW BARS.MBK7 ("ND", "SOS", "CC_ID", "SDATE", "WDATE", "RNK", "VIDD", "LIMIT", "KPROLOG", "USER_ID", "OBS", "BRANCH", "KF", "IR", "PROD", "SDOG", "SKARB_ID", "FIN", "NDI", "FIN23", "OBS23", "KAT23", "K23", "KV", "OSTSS", "SP", "OK_SS", "OSTSN", "SPN", "OK_SN", "OK_CL") AS 
  SELECT d."ND",
          d."SOS",
          d."CC_ID",
          d."SDATE",
          d."WDATE",
          d."RNK",
          d."VIDD",
          d."LIMIT",
          d."KPROLOG",
          d."USER_ID",
          d."OBS",
          d."BRANCH",
          d."KF",
          d."IR",
          d."PROD",
          d."SDOG",
          d."SKARB_ID",
          d."FIN",
          d."NDI",
          d."FIN23",
          d."OBS23",
          d."KAT23",
          d."K23",
          ss.KV,
          -- тело = SS
          ABS (ss.ostB) / 100 OSTSS,
          CASE WHEN d.wdate < gl.BD THEN ABS (ss.ostB) / 100 ELSE 0 END SP,
          0 OK_SS,
          --проц = SN
          ABS (sn.ostB) / 100 OSTSN,
          CASE WHEN i.id = 0 THEN ABS (sn.ostB) / 100 ELSE 0 END SPN,
          0 OK_SN,
          0 OK_CL
     FROM cc_deal d,
          accounts ss,
          accounts sn,
          cc_add ad,
          int_accn i
    WHERE     d.nd = ad.nd
          AND ad.adds = 0
          AND d.sos <= 13
          AND ad.accs = ss.acc
          AND ss.acc = i.acc
          AND i.id IN (0, 1)
          AND i.acra = sn.acc
          AND (ss.ostc <> 0 OR sn.ostc <> 0)
          AND ss.ostc = ss.ostb
          AND sn.ostc = sn.ostb
          AND d.vidd > 1000
          AND vidd < 2000
          AND ad.accs = ss.acc
          AND vidd IN (SELECT vidd
                         FROM cc_vidd
                        WHERE custtype = 1);

PROMPT *** Create  grants  MBK7 ***
grant SELECT                                                                 on MBK7            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBK7            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MBK7.sql =========*** End *** =========
PROMPT ===================================================================================== 
