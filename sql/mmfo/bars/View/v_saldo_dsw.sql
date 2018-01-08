

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SALDO_DSW.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SALDO_DSW ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SALDO_DSW ("FDAT", "RNK", "KV", "SHORT_S1", "SHORT_I1", "LONG_S1", "LONG_I1", "SHORT_S2", "SHORT_I2", "LONG_S2", "LONG_I2", "SHORT_S1_UAH", "LONG_S1_UAH", "SHORT_S2_UAH", "LONG_S2_UAH") AS 
  select fdat,
          rnk,
          kv,
          round (short_s1, 10) as short_s1,
          round (short_i1, 10) as short_i1,
          round (long_s1, 10) as long_s1,
          round (long_i1, 10) as long_i1,
          round (short_s2, 10) as short_s2,
          round (short_i2, 10) as short_i2,
          round (long_s2, 10) as long_s2,
          round (long_i2, 10) as long_i2,
          round (short_s1_uah, 10) as short_s1_uah,
          round (long_s1_uah, 10) as long_s1_uah,
          round (short_s2_uah, 10) as short_s2_uah,
          round (long_s2_uah, 10) as long_s2_uah
     from saldo_dsw;

PROMPT *** Create  grants  V_SALDO_DSW ***
grant SELECT                                                                 on V_SALDO_DSW     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SALDO_DSW.sql =========*** End *** ==
PROMPT ===================================================================================== 
