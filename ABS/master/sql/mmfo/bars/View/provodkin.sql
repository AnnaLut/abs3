

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROVODKIN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view PROVODKIN ***

  CREATE OR REPLACE FORCE VIEW BARS.PROVODKIN ("ACCD", "TT", "REF", "KV", "NLSD", "S", "SQ", "FDAT", "NAZN", "ACCK", "NLSK", "ISP", "VOB", "VDAT", "OTM", "STMT") AS 
  SELECT O.accD, O.tt, O.REF, AD.kv,
          DECODE (AD.tip, 'T00', P.nlsa, AD.nls), O.s, O.sq, O.fdat,
          DECODE (O.tt, P.tt, P.nazn, DECODE (O.tt, 'PO3', P.nazn, t.NAME)),
          O.accK, DECODE (AK.tip, 'T00', P.nlsb, AK.nls), P.userid, P.vob,
          P.vdat, O.otm, O.stmt
     FROM oper P, tts t, accounts AD, accounts AK,
        (select FDAT,ref,stmt,tt,s,sq, OTM,
                sum(decode(dk,0,acc,0)) ACCD, sum(decode(dk,1,acc,0)) ACCk 
         from opldok  where sos>=4 group by FDAT, ref,stmt,tt,s,sq,OTM
         ) o  
    WHERE P.REF = O.REF
      AND t.tt = O.tt
      AND O.accD = AD.acc
      AND O.accK = AK.acc 
 ;

PROMPT *** Create  grants  PROVODKIN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PROVODKIN       to ABS_ADMIN;
grant SELECT                                                                 on PROVODKIN       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PROVODKIN       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PROVODKIN       to RPBN001;
grant SELECT                                                                 on PROVODKIN       to SALGL;
grant SELECT                                                                 on PROVODKIN       to START1;
grant SELECT                                                                 on PROVODKIN       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PROVODKIN       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROVODKIN.sql =========*** End *** ====
PROMPT ===================================================================================== 
