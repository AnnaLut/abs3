

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PROVODKI.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view PROVODKI ***

  CREATE OR REPLACE FORCE VIEW BARS.PROVODKI ("ISP", "BRANCH", "MFOA", "MFOB", "NAM_A", "NAM_B", "SOSO", "NAZN", "TT", "REF", "KV", "S", "SQ", "FDAT", "STMT", "TXT", "ACCD", "NLSD", "NBSD", "BRANCH_A", "ACCK", "NLSK", "NBSK", "BRANCH_B") AS 
  SELECT p.userid,
          p.branch,
          p.mfoa,
          p.mfob,
          p.nam_a,
          p.nam_b,
          p.sos,
          DECODE (o.tt, p.tt, p.nazn, DECODE (o.tt, 'PO3', p.nazn, t.NAME)),
          o.tt,
          o.REF,
          ad.kv,
          o.s / 100,
          o.sq / 100,
          o.fdat,
          o.stmt,
          o.txt,
          o.accd,
          ad.nls,
          ad.NBS,
          ad.branch,
          o.acck,
          ak.nls,
          ak.NBS,
          ak.branch
     FROM oper p,
          tts t,
          accounts ad,
          accounts ak,
          (  SELECT fdat,
                    REF,
                    stmt,
                    tt,
                    s,
                    sq,
                    txt,
                    SUM (DECODE (dk, 0, acc, 0)) accd,
                    SUM (DECODE (dk, 1, acc, 0)) acck
               FROM opldok p
              WHERE sos >= 4
           GROUP BY fdat,
                    REF,
                    stmt,
                    tt,
                    s,
                    sq,
                    txt) o
    WHERE     p.REF = o.REF
          AND t.tt = o.tt
          AND o.accd = ad.acc
          AND o.acck = ak.acc;

PROMPT *** Create  grants  PROVODKI ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PROVODKI        to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on PROVODKI        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PROVODKI        to RPBN001;
grant SELECT                                                                 on PROVODKI        to SALGL;
grant SELECT                                                                 on PROVODKI        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PROVODKI        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PROVODKI.sql =========*** End *** =====
PROMPT ===================================================================================== 
