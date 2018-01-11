

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VALDO_DSW.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view VALDO_DSW ***

  CREATE OR REPLACE FORCE VIEW BARS.VALDO_DSW ("FDAT", "KV", "ID", "S", "I") AS 
  SELECT fdat,
          kv,
          21 id,
          SHORT_S2 * 100 S,
          SHORT_I2 I
     FROM SALDO_DSW
    WHERE SHORT_S2 <> 0                                -- 21 Залучено овернайт
   UNION ALL
   SELECT fdat,
          kv,
          22 id,
          LONG_S2 * 100 S,
          LONG_I2 I
     FROM SALDO_DSW
    WHERE LONG_S2 <> 0                                 -- 22 Залучено строкові
   UNION ALL
   SELECT fdat,
          kv,
          24 id,
          -SHORT_S1 * 100 S,
          SHORT_I1 I
     FROM SALDO_DSW
    WHERE SHORT_S1 <> 0                               -- 24 Розмiщено овернайт
   UNION ALL
   SELECT fdat,
          kv,
          25 id,
          -LONG_S1 * 100 S,
          LONG_I1 I
     FROM SALDO_DSW
    WHERE LONG_S1 <> 0                               -- 25 Розмiщено строкові
    UNION ALL
    SELECT fdat,
          kv,
          26 id,
          SHORT_S2_UAH * 100 S,
          0
     FROM SALDO_DSW
    WHERE SHORT_S2_UAH <> 0                                -- 26 Залучено овернайт
   UNION ALL
   SELECT fdat,
          kv,
          27 id,
          LONG_S2_UAH * 100 S,
          0
     FROM SALDO_DSW
    WHERE LONG_S2_UAH <> 0                                 -- 27 Залучено строкові
   UNION ALL
   SELECT fdat,
          kv,
          28 id,
          -SHORT_S1_UAH * 100 S,
          0
     FROM SALDO_DSW
    WHERE SHORT_S1_UAH <> 0                               -- 28 Розмiщено овернайт
   UNION ALL
   SELECT fdat,
          kv,
          29 id,
          -LONG_S1_UAH * 100 S,
          0
     FROM SALDO_DSW
    WHERE LONG_S1_UAH <> 0                               -- 29 Розмiщено строкові;

PROMPT *** Create  grants  VALDO_DSW ***
grant SELECT                                                                 on VALDO_DSW       to BARSREADER_ROLE;
grant SELECT                                                                 on VALDO_DSW       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VALDO_DSW       to START1;
grant SELECT                                                                 on VALDO_DSW       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VALDO_DSW.sql =========*** End *** ====
PROMPT ===================================================================================== 
