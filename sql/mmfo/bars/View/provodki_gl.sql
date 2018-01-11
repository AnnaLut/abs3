

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROVODKI_GL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view PROVODKI_GL ***

  CREATE OR REPLACE FORCE VIEW BARS.PROVODKI_GL ("ACCD", "TT", "REF", "KV", "NLSD", "S", "SQ", "FDAT", "NAZN", "ACCK", "NLSK", "ISP", "MFOA", "MFOB", "NAM_A", "NAM_B", "BRANCH_A", "BRANCH_B", "STMT", "TXT") AS 
  SELECT O.accD, O.tt, O.REF, AD.kv, AD.nls, O.s / 100, O.sq / 100,
          O.fdat,
          DECODE (O.tt, P.tt, P.nazn, DECODE (O.tt, 'PO3', P.nazn, t.NAME)),
          O.accK, AK.nls, P.userid, P.mfoa, P.mfob,
          SUBSTR (P.nam_a, 1, 20) nam_a, SUBSTR (P.nam_b, 1, 20) nam_b,
          AD.branch, AK.branch, O.stmt, O.txt
     FROM oper P, tts t, ACCOUNTS AD, ACCOUNTS AK,
        (select FDAT,ref,stmt,tt,s,sq, TXT,
                sum(decode(dk,0,acc,0)) ACCD, sum(decode(dk,1,acc,0)) ACCk 
         from opldok  where sos>=4 group by FDAT, ref,stmt,tt,s,sq,TXT
         ) o  
    WHERE P.REF = O.REF
      AND t.tt  = O.tt
      AND O.accD = AD.acc
      AND O.accK = AK.acc
      AND AD.BRANCH LIKE SYS_CONTEXT('bars_context','user_branch_mask')
      AND AK.BRANCH LIKE SYS_CONTEXT('bars_context','user_branch_mask') 
 ;

PROMPT *** Create  grants  PROVODKI_GL ***
grant SELECT                                                                 on PROVODKI_GL     to BARSREADER_ROLE;
grant SELECT                                                                 on PROVODKI_GL     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PROVODKI_GL     to RPBN001;
grant SELECT                                                                 on PROVODKI_GL     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROVODKI_GL.sql =========*** End *** ==
PROMPT ===================================================================================== 
