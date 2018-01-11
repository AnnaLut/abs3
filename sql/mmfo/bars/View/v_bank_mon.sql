

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BANK_MON.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BANK_MON ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BANK_MON ("NAME_MON", "NOM_MON", "CENA_NBU", "KOD", "TYPE", "CASE", "CENA_NBU_OTP", "TYPE_MET", "CENA_BANKA") AS 
  SELECT b.name_mon, b.nom_mon / 100, b.cena_nbu / 100, b.kod, b.TYPE,
(SELECT (cena_nbu * 1.2) / 100
FROM bank_mon
WHERE kod = b.CASE and branch = b.branch) CASE, b.cena_nbu_otp / 100, b.type_met,
b.cena_nbu_otp / 100 cena_banka
FROM bank_mon b
WHERE b.razr <> 0;

PROMPT *** Create  grants  V_BANK_MON ***
grant SELECT                                                                 on V_BANK_MON      to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANK_MON      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BANK_MON      to PYOD001;
grant SELECT                                                                 on V_BANK_MON      to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BANK_MON      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BANK_MON.sql =========*** End *** ===
PROMPT ===================================================================================== 
