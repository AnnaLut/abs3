

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_ALIENS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_ALIENS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_ALIENS ("KV", "NBB", "MFOB", "BICB", "NLSB", "KOD_GB", "KOD_BB", "OKPOB", "BICKB", "SSB", "NBKB", "NGB") AS 
  SELECT f.kv,
          f.name,
          f.mfo,
          f.BIC,
          f.NLS,
          f.KOD_G,
          f.KOD_B,
          f.OKPO,
          f.BICK,
          f.NLSK,
          s.name,
          b.COUNTRY
     FROM CP_alien f, sw_banks s, bopcount b
    WHERE UPPER (f.bick) = UPPER (s.bic(+)) AND b.KODC(+) = f.kod_G;

PROMPT *** Create  grants  V_CP_ALIENS ***
grant SELECT                                                                 on V_CP_ALIENS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_ALIENS.sql =========*** End *** ==
PROMPT ===================================================================================== 
