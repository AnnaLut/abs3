

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_CURRENCY_INCOME.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_CURRENCY_INCOME ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_CURRENCY_INCOME ("MFO", "BRANCH", "PDAT", "TT", "REF", "NAZN", "KV", "LCV", "RNK", "OKPO", "NMK", "S", "S_OBZ", "TXT", "NB") AS 
  select r."MFO",r."BRANCH",r."PDAT",r."TT",r."REF",r."NAZN",r."KV",r."LCV",r."RNK",r."OKPO",r."NMK",r."S",r."S_OBZ",r."TXT", b.nb from zay_currency_income_ru r, banks$base b where b.mfo = r.mfo
union all
select z."MFO",z."BRANCH",z."PDAT",z."TT",z."REF",z."NAZN",z."KV",z."LCV",z."RNK",z."OKPO",z."NMK",z."S",z."S_OBZ",z."TXT", b.nb from zay_currency_income z, banks$base b where b.mfo = z.mfo;

PROMPT *** Create  grants  V_ZAY_CURRENCY_INCOME ***
grant SELECT                                                                 on V_ZAY_CURRENCY_INCOME to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_CURRENCY_INCOME.sql =========*** 
PROMPT ===================================================================================== 
