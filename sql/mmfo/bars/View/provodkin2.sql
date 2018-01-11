

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROVODKIN2.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view PROVODKIN2 ***

  CREATE OR REPLACE FORCE VIEW BARS.PROVODKIN2 ("ACCD", "TT", "REF", "KV", "NLSD", "S", "SQ", "FDAT", "NAZN", "ACCK", "NLSK", "ISP", "VOB", "VDAT") AS 
  SELECT O.accD, O.tt, O.REF, AD.kv,
          DECODE (AD.tip, 'T00', P.nlsa, AD.nls), O.s, O.sq, O.fdat,
          DECODE (O.tt, P.tt, P.nazn, DECODE (O.tt, 'PO3', P.nazn, t.NAME)),
          O.accK, DECODE (AK.tip, 'T00', P.nlsb, AK.nls), P.userid, P.vob,
          P.vdat
     FROM oper P, tts t,  accounts AD, accounts AK,
        (select FDAT,ref,stmt,tt,s,sq, 
                sum(decode(dk,0,acc,0)) ACCD, sum(decode(dk,1,acc,0)) ACCk 
         from opldok  where sos>=4 group by FDAT, ref,stmt,tt,s,sq
         ) o  
    WHERE P.REF = O.REF
      AND t.tt = O.tt
      AND O.accD = AD.acc
      AND O.accK = AK.acc 
 ;

PROMPT *** Create  grants  PROVODKIN2 ***
grant SELECT                                                                 on PROVODKIN2      to BARSREADER_ROLE;
grant SELECT                                                                 on PROVODKIN2      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PROVODKIN2      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROVODKIN2.sql =========*** End *** ===
PROMPT ===================================================================================== 
