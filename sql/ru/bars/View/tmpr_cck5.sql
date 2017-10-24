

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMPR_CCK5.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view TMPR_CCK5 ***

  CREATE OR REPLACE FORCE VIEW BARS.TMPR_CCK5 ("BRANCH", "PROD", "ZN50", "SPOK", "KV", "SEGM", "B1", "E1", "KOL", "S11", "S12", "S13", "S14", "S15", "S16", "S17", "V11", "V12", "V13", "V14", "V15", "V16", "V17") AS 
  SELECT branch,
          prod,
          zn50,
          spok,
          kv,
          segm,
          b1,
          e1,
          kol,
          DECODE (s11, 0, NULL, s11) s11,
          DECODE (s12, 0, NULL, s12) s12,
          DECODE (s13, 0, NULL, s13) s13,
          DECODE (s14, 0, NULL, s14) s14,
          DECODE (s15, 0, NULL, s15) s15,
          DECODE (s16, 0, NULL, s16) s16,
          DECODE (s17, 0, NULL, s17) s17,
          DECODE (v11, 0, NULL, v11) v11,
          DECODE (v12, 0, NULL, v12) v12,
          DECODE (v13, 0, NULL, v13) v13,
          DECODE (v14, 0, NULL, v14) v14,
          DECODE (v15, 0, NULL, v15) v15,
          DECODE (v16, 0, NULL, v16) v16,
          DECODE (v17, 0, NULL, v17) v17
     FROM (  SELECT branch,
                    prod,
                    zn50,
                    spok,
                    kv,
                    segm,
                    b1,
                    e1,
                    COUNT (*) kol,
                    SUM (NVL (s11, 0)) s11,
                    SUM (NVL (s12, 0)) s12,
                    SUM (NVL (s13, 0)) s13,
                    SUM (NVL (s14, 0)) s14,
                    SUM (NVL (s15, 0)) s15,
                    SUM (NVL (s16, 0)) s16,
                    SUM (NVL (s17, 0)) s17,
                    SUM (NVL (v11, 0)) v11,
                    SUM (NVL (v12, 0)) v12,
                    SUM (NVL (v13, 0)) v13,
                    SUM (NVL (v14, 0)) v14,
                    SUM (NVL (v15, 0)) v15,
                    SUM (NVL (v16, 0)) v16,
                    SUM (NVL (v17, 0)) v17
               FROM tmp_cck5r
           GROUP BY branch,
                    prod,
                    zn50,
                    spok,
                    kv,
                    segm,
                    b1,
                    e1);

PROMPT *** Create  grants  TMPR_CCK5 ***
grant SELECT                                                                 on TMPR_CCK5       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMPR_CCK5       to RCC_DEAL;
grant SELECT                                                                 on TMPR_CCK5       to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMPR_CCK5.sql =========*** End *** ====
PROMPT ===================================================================================== 
