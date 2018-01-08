

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PROVODKI.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PROVODKI ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PROVODKI ("TT", "REF", "KV", "NLSD", "S", "SQ", "FDAT", "NAZN", "NLSK", "BRANCH") AS 
  SELECT O.tt, O.REF, AD.kv, AD.nls, DECODE (AD.kv, 980, NULL, O.s) / 100,
          DECODE (AD.kv, 980, O.s, NULL) / 100, O.fdat, P.nazn, AK.nls,
          P.branch
     FROM oper P,  accounts AD, accounts AK,
        (select FDAT,ref,stmt,tt,s,sq, 
                sum(decode(dk,0,acc,0)) ACCD, sum(decode(dk,1,acc,0)) ACCk 
         from opldok  where sos>=4 group by FDAT, ref,stmt,tt,s,sq
         ) o  
    WHERE P.REF = O.REF
      AND O.accD = AD.acc
      AND O.accK = AK.acc
      AND (   AD.nls LIKE '100%' AND AK.nls LIKE '380%'
           OR AD.nls LIKE '380%' AND AK.nls LIKE '100%'
          ) 
 ;

PROMPT *** Create  grants  V_PROVODKI ***
grant SELECT                                                                 on V_PROVODKI      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PROVODKI      to SALGL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_PROVODKI      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PROVODKI.sql =========*** End *** ===
PROMPT ===================================================================================== 
