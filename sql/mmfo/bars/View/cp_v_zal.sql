

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_V_ZAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_V_ZAL ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_V_ZAL ("FDAT", "REF", "ND", "ACC", "VDAT", "ID", "VIDD", "RYN", "CENA", "KOL_ALL", "KOL_ZAL", "DAT_ZAL", "NOM_ALL", "NOM_ZAL", "DIS_ZAL", "PRE_ZAL", "KUN_ZAL", "KUK_ZAL", "PRC_ZAL") AS 
  SELECT x.B,
            x.REF,
            o.nd,
            x.acc,
            o.vdat,
            x.id,
            x.vidd,
            x.ryn,
            x.cena,
            x.KOL_ALL,
            x.kolz,
            DECODE (x.kolz,
                    NULL, NULL,
                    F_GET_FROM_ACCOUNTSPV_DAT2 (x.spid, x.acc, x.b))
               datz,
            x.NOM_ALL * x.kf NOM_ALL,
            (x.NOM_ALL * x.kolz * x.kf / x.KOL_ALL) NOM_ZAL,
            ROUND ( (fost (x.accd, x.B) * x.kolz * x.kf / x.KOL_ALL), 2)
               DIS_ZAL,
            ROUND ( (fost (x.accp, x.B) * x.kolz * x.kf / x.KOL_ALL), 2)
               PRE_ZAL,
            ROUND ( (fost (x.accr, x.B) * x.kolz * x.kf / x.KOL_ALL), 2)
               KUN_ZAL,
            ROUND ( (fost (x.accr2, x.B) * x.kolz * x.kf / x.KOL_ALL), 2)
               KUK_ZAL,
            ROUND ( (fost (x.accs, x.B) * x.kolz * x.kf / x.KOL_ALL), 2)
               PRC_ZAL
       FROM cp_zal z,
            oper o,
            (SELECT d.B,
                    0.01 KF,
                    e.REF,
                    e.id,
                    fost (e.acc, d.B) NOM_ALL,
                    f_cena_cp (k.id, d.B, 0) CENA,                   --k.cena,
                    ROUND (-fost (e.acc, d.B) / 100 / f_cena_cp (k.id, d.B, 0),
                           5)
                       KOL_ALL,
                    TO_NUMBER (
                       TRIM (F_GET_FROM_ACCOUNTSPV (( select spid
     from sparam_list
    where tag = 'CP_ZAL'), e.acc, d.b)))
                       KOLZ,
                    e.accd,
                    e.accp,
                    e.accr,
                    e.accr2,
                    e.accs,
                    SUBSTR (a.nls, 1, 4) VIDD,
                    e.ryn,
                    e.acc,
                   ( select spid
     from sparam_list
    where tag = 'CP_ZAL') spid 
               FROM cp_deal e,
                    cp_kod k,
                    accounts a,
                    (SELECT NVL (
                               TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                        'dd.mm.yyyy'),
                               gl.bd)
                               B
                       FROM DUAL) d
              WHERE     e.acc = a.acc
                    AND (a.nls LIKE '14%' OR a.nls LIKE '31%')
                    AND fost (a.acc, d.B) < 0
                    AND e.id = k.id) x
      WHERE x.REF = o.REF AND x.REF = z.REF(+)
   ORDER BY x.id, x.REF;

PROMPT *** Create  grants  CP_V_ZAL ***
grant SELECT                                                                 on CP_V_ZAL        to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on CP_V_ZAL        to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on CP_V_ZAL        to CP_ROLE;
grant SELECT,UPDATE                                                          on CP_V_ZAL        to START1;
grant SELECT                                                                 on CP_V_ZAL        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_V_ZAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
