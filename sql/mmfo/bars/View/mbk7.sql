

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MBK7.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view MBK7 ***

  CREATE OR REPLACE FORCE VIEW BARS.MBK7 ("ND", "SOS", "CC_ID", "SDATE", "WDATE", "RNK", "VIDD", "LIMIT", "KPROLOG", "USER_ID", "OBS", "BRANCH", "KF", "IR", "PROD", "SDOG", "SKARB_ID", "FIN", "NDI", "FIN23", "OBS23", "KAT23", "K23", "KV", "OSTSS", "SP", "OK_SS", "OSTSN", "SPN", "OK_SN", "OK_CL") AS 
SELECT d.ND,
    d.SOS,
    d.CC_ID,
    d.SDATE,
    d.WDATE,
    d.RNK,
    d.VIDD,
    d.LIMIT,
    d.KPROLOG,
    d.USER_ID,
    d.OBS,
    d.BRANCH,
    d.KF,
    d.IR,
    d.PROD,
    d.SDOG,
    d.SKARB_ID,
    d.FIN,
    d.NDI,
    d.FIN23,
    d.OBS23,
    d.KAT23,
    d.K23,
    ss.KV,
    -- тело = SS
    ABS(FOST(ss.acc,x.GL_BD))/100 OSTSS,
    MBK2.get_over_sum (d.nd,d.wdate,ss.acc,x.GL_BD) /100 SP, -- расчетная сумма для выноса на просрочку  = делта ФАКТ-ПЛАН
    0 OK_SS,
    --проц = SN
    ABS(FOST(sn.acc,x.GL_BD))/100 OSTSN, 
    (1-i.id)*ABS(FOST(sn.acc,x.GL_BD))/100 SPN,
    0 OK_SN,
    0 OK_CL
   FROM cc_deal d,  accounts ss,  accounts sn, cc_add ad,  int_accn i, (select NVL(to_date(pul.GET('GL_BD'),'DD.MM.YYYY') , gl.BD) GL_BD from dual) x
   WHERE d.nd=ad.nd AND ad.adds=0  AND d.sos <= 13  AND ad.accs=ss.acc AND ss.tip IN ('SS ','DEP') 
         AND ss.acc=i.acc AND i.id IN (0,1) AND i.acra=sn.acc  AND (ss.ostc<>0 OR sn.ostc<> 0)
         AND ss.ostc = ss.ostb --AND sn.ostc = sn.ostb
         AND d.vidd > 1000 AND vidd < 2000 AND ad.accs = ss.acc  AND vidd IN (SELECT vidd  FROM cc_vidd WHERE custtype = 1);

PROMPT *** Create  grants  MBK7 ***
grant SELECT                                                                 on MBK7            to BARSREADER_ROLE;
grant SELECT                                                                 on MBK7            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBK7            to START1;
grant SELECT                                                                 on MBK7            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MBK7.sql =========*** End *** =========
PROMPT ===================================================================================== 
