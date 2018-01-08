

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MON0.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MON0 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MON0 ("KOD", "NAME", "NOM_MON", "CENA2", "CENA1", "KODF", "NAMEF", "CENAF2", "CENAF1") AS 
  SELECT DISTINCT
          KOD,
          f_mon_null (kod, TYPE, 'NAME_MON'),
          --NAME_MON,
          NVL (f_mon_null (kod, TYPE, 'NOM_MON'), 0),
          NVL (f_mon_null (kod, TYPE, 'CENA_NBU_OTP'), 0),
          NVL (f_mon_null (kod, TYPE, 'CENA_NBU'), 0),
          NVL (f_mon_null (kod, TYPE, 'CASE'), 0),
          NVL(f_mon_null (NVL (f_mon_null (kod, TYPE, 'CASE'), 0), 1, 'NAME_MON'),' ')     NAMEF,
          NVL (f_mon_null (NVL (f_mon_null (kod, TYPE, 'CASE'), 0),1,'CENA_NBU_OTP'),0)    CENAF2,
          NVL (f_mon_null (NVL (f_mon_null (kod, TYPE, 'CASE'), 0),1,'CENA_NBU'),0)        CENAF1
     FROM BANK_MON m
    WHERE     m.TYPE = 0
          AND f_mon_null (kod, TYPE, 'RAZR') = 1
          AND NVL (f_mon_null (kod, TYPE, 'CENA_NBU_OTP'), 0) > 0;

PROMPT *** Create  grants  V_MON0 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_MON0          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MON0.sql =========*** End *** =======
PROMPT ===================================================================================== 
