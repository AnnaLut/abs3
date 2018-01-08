

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KOD_DZR_DOC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view KOD_DZR_DOC ***

  CREATE OR REPLACE FORCE VIEW BARS.KOD_DZR_DOC ("BRANCH", "REF", "TT", "ND", "VDAT", "KV", "DK", "ISP", "NAZN", "MFOA", "NLSA", "MFOB", "NLSB", "NAM_B", "N1", "KODDZ", "SUMDZ") AS 
  SELECT o.branch,
          o.REF,
          o.tt,
          o.nd,
          o.vdat,
          o.kv,
          o.dk,
          o.userid ISP,
          o.nazn,
          o.mfoa,
          o.nlsa,
          o.mfob,
          o.nlsb,
          o.nam_b,
          t.id n1,
          t.nls koddz,
          t.S_980 sumdz
     FROM oper o, TMP_AN_KL t
    WHERE o.REF = t.RNK;

PROMPT *** Create  grants  KOD_DZR_DOC ***
grant SELECT                                                                 on KOD_DZR_DOC     to BARSREADER_ROLE;
grant SELECT                                                                 on KOD_DZR_DOC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KOD_DZR_DOC     to START1;
grant SELECT                                                                 on KOD_DZR_DOC     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KOD_DZR_DOC.sql =========*** End *** ==
PROMPT ===================================================================================== 
