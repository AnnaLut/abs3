

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANKS_RU.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANKS_RU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANKS_RU ("RU", "RU_NAME", "MFO", "BANKNAME") AS 
  SELECT b2.ru,
          b2.name,
          b1.mfo,
          b1.nb
     FROM banks b1, banks_ru b2
    WHERE ( (b1.mfo IN (SELECT mfo FROM banks_ru)
             OR b1.mfop IN (SELECT mfo FROM banks_ru))
           AND b1.blk = 0)
          AND (b2.mfo = b1.mfo OR b2.mfo = b1.mfop)
          AND b2.ru <> 0;

PROMPT *** Create  grants  V_BANKS_RU ***
grant FLASHBACK,SELECT                                                       on V_BANKS_RU      to BARS014;
grant SELECT                                                                 on V_BANKS_RU      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANKS_RU      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BANKS_RU      to START1;
grant SELECT                                                                 on V_BANKS_RU      to UPLD;
grant FLASHBACK,SELECT                                                       on V_BANKS_RU      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANKS_RU.sql =========*** End *** ===
PROMPT ===================================================================================== 
