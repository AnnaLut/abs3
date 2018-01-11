

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_VH_GPK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_VH_GPK ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_VH_GPK ("USER_ID", "ND", "CC_ID", "VIDK", "RNK", "NMK", "OKPO", "S", "DAT1", "DAT2", "DAT3", "DAT4", "PR", "OSTC", "NLSG", "SOS", "INFO") AS 
  SELECT d.USER_ID, d.ND, d.CC_ID, nt1.TXT, d.RNK, c.NMK, c.OKPO, ad.S, d.SDATE, ad.BDATE, ad.WDATE, d.WDATE, to_number(acrN.FPROCN(ad.ACCS,0,d.wdate )), -ss.ostc/100, sg.nls, o.NAME, nt2.TXT
    FROM CC_DEAL d, CUSTOMER c, CC_ADD ad, CC_SOS o, ACCOUNTS ss, ACCOUNTS sg, ND_ACC ns, ND_ACC ng, ND_TXT nt1, ND_TXT nt2
    WHERE d.RNK = c.RNK and d.SOS = o.SOS and d.ND = ad.ND and ad.ADDS = 0 and
          ad.ACCS = ss.ACC and ss.ACC = ns.ACC and ss.TIP = 'SS ' and
          ns.ND = d.ND and sg.ACC = ng.ACC and sg.TIP = 'SG ' and ng.ND = d.ND and
          nt1.ND = d.ND and nt1.TAG = 'VIDK' and nt2.ND = d.ND and nt2.TAG = 'AIM';

PROMPT *** Create  grants  CC_VH_GPK ***
grant SELECT                                                                 on CC_VH_GPK       to BARSREADER_ROLE;
grant SELECT                                                                 on CC_VH_GPK       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_VH_GPK       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_VH_GPK.sql =========*** End *** ====
PROMPT ===================================================================================== 
