

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_ZAYV.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_ZAYV ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_ZAYV ("OKPO", "FDAT", "ID", "FIO", "RNK", "NMK", "CUSTTYPE", "TEL", "S", "KV", "NZ", "TXT", "DATZ", "DATU", "DATW", "SOS", "KLA", "BRANCH") AS 
  SELECT c.OKPO,z.FDAT,z.ID,s.FIO,z.RNK,c.NMK,c.CUSTTYPE,z.TEL,
       z.S,z.KV,z.NZ,n.TXT,z.DATZ,z.DATU,z.DATW,Nvl(z.sos,0), z.kla, Z.BRANCH
FROM CC_ZAY z, customer c, STAFF$BASE s, nd_txt n
WHERE z.rnk=c.rnk and z.id=s.id(+) and z.nz=n.ND(+) and n.tag(+)='ZAY' and z.rnk>0
  UNION ALL
SELECT nvl(z.OKPO,to_char(z.RNK)),
 z.FDAT,z.ID,s.FIO,z.RNK,z.NMK,z.CUSTTYPE,z.TEL,z.S,z.KV,z.NZ,n.TXT,
 z.DATZ,z.DATU,z.DATW , Nvl(z.sos,0), z.kla, Z.BRANCH
FROM CC_ZAY z, STAFF s, nd_txt n
WHERE z.rnk=0 and z.id=s.id(+) and z.nz=n.ND(+) and n.tag(+)='ZAY'
 ;

PROMPT *** Create  grants  CC_ZAYV ***
grant SELECT                                                                 on CC_ZAYV         to BARSREADER_ROLE;
grant SELECT                                                                 on CC_ZAYV         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_ZAYV         to RCC_DEAL;
grant SELECT                                                                 on CC_ZAYV         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_ZAYV         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_ZAYV.sql =========*** End *** ======
PROMPT ===================================================================================== 
