

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROVODKI_OTC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view PROVODKI_OTC ***

  CREATE OR REPLACE FORCE VIEW BARS.PROVODKI_OTC ("ISP", "BRANCH", "MFOA", "MFOB", "NAM_A", "NAM_B", "SOSO", "NAZN", "TT", "REF", "KV", "S", "SQ", "FDAT", "STMT", "TXT", "ACCD", "NLSD", "NBSD", "BRANCH_A", "ACCK", "NLSK", "NBSK", "BRANCH_B", "RNKD", "RNKK", "OB22D", "OB22K", "VOB", "NLSA", "NLSB", "KV_O", "KV2_O", "DK_O", "PDAT", "PDATD", "PNAZN", "PTT", "PS") AS 
  SELECT p.userid, p.branch, p.mfoa, p.mfob, p.nam_a, p.nam_b, p.sos,
       DECODE (o.tt, p.tt, p.nazn, DECODE (o.tt, 'PO3', p.nazn, t.NAME)),
       o.tt, o.REF, ad.kv, o.s/100, o.sq/100, o.fdat,   o.stmt, o.txt,
       o.accd,  ad.nls, ad.NBS, ad.branch,
       o.acck,  ak.nls, ak.NBS, ak.branch,
       ad.rnk, ak.rnk, ad.ob22, ak.ob22,
       p.vob, p.nlsa, p.nlsb, p.kv, p.kv2,
       p.dk, p.pdat, p.datd, p.nazn, p.tt, p.s
FROM oper p, tts t,    accounts ad,   accounts ak,
     (SELECT /*+parallel(p)*/
             fdat, REF, stmt, tt, s, sq, txt,
             SUM (DECODE (dk,0,acc,0)) accd,  SUM (DECODE (dk,1,acc,0)) acck
      FROM opldok p
      WHERE sos >= 4
      GROUP BY fdat, REF, stmt, tt, s, sq, txt) o
WHERE p.REF = o.REF AND t.tt = o.tt AND o.accd = ad.acc
  AND o.acck = ak.acc;

PROMPT *** Create  grants  PROVODKI_OTC ***
grant SELECT                                                                 on PROVODKI_OTC    to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROVODKI_OTC.sql =========*** End *** =
PROMPT ===================================================================================== 
