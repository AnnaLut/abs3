

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_V_PK_DATA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_V_PK_DATA ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_V_PK_DATA ("CRNK", "CNMK", "COKPO", "CADR", "CBDAT", "CPASN", "CPASO", "CTEL1", "CTEL2", "DND", "DCCID", "DDAT", "DSOS", "DVID", "DS", "DPR", "DOST", "DINFO", "DNLSSS") AS 
  select  c.RNK, c.NMK, c.OKPO, c.ADR, p.BDAY, p.SER||' '||p.NUMDOC, p.ORGAN||' '||to_char(p.PDATE, 'dd/mm/yyyy'), p.TELD, p.TELW, 
          d.ND, d.CC_ID, d.SDATE, o.NAME, nt1.TXT, ad.S, to_number(acrN.FPROCN(ad.ACCS, 0, d.wdate)), -ss.OSTC/100, nt2.TXT, ss.NLS 
    from  CUSTOMER c, PERSON p, 
        CC_DEAL d, CC_ADD ad, CC_SOS o, ACCOUNTS ss, ND_TXT nt1, ND_TXT nt2 
    where   d.SOS = o.SOS and d.RNK = c.RNK and c.RNK = p.RNK and d.ND = ad.ND 
        and ad.ADDS = 0 and ad.ACCS = ss.ACC and ss.TIP = 'SS ' and nt1.ND = d.ND 
        and nt1.TAG = 'VIDK' and nt2.ND = d.ND and nt2.TAG = 'AIM' 
 ;

PROMPT *** Create  grants  CC_V_PK_DATA ***
grant SELECT                                                                 on CC_V_PK_DATA    to BARSREADER_ROLE;
grant SELECT                                                                 on CC_V_PK_DATA    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_V_PK_DATA    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_V_PK_DATA    to WR_ALL_RIGHTS;
grant SELECT                                                                 on CC_V_PK_DATA    to WR_CREDIT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_V_PK_DATA.sql =========*** End *** =
PROMPT ===================================================================================== 
