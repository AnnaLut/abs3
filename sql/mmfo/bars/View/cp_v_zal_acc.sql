

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_V_ZAL_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_V_ZAL_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_V_ZAL_ACC ("FDAT", "REF", "ID", "ISIN", "NLS", "KV", "ACC", "OST", "SUM_ZAL", "DAT_ZAL") AS 
  SELECT x.B FDAT,
            e.REF,
            k.id,
            k.cp_id,
            a.nls,
            a.kv,
            a.acc,
            fost (a.acc, x.B) OST,
            ROUND (
                 fost (a.acc, x.B)
               * TO_NUMBER (TRIM (F_GET_FROM_ACCOUNTSPV (sp.spid, e.acc, x.b)))
               / (-fost (e.acc, x.B) / f_cena_cp (k.id, x.B, 0) / 100),
               0)
               ost_zal,
            NVL (F_GET_FROM_ACCOUNTSPV_DAT2 (sp.spid, e.acc, x.b), a.mdate)
               datz
       FROM cp_deal e,
            cp_kod k,
            accounts a,
            cp_zal z,
            (SELECT NVL (
                       TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'),
                       gl.bd)
                       B
               FROM DUAL) x,
            (SELECT spid
               FROM sparam_list
              WHERE tag = 'CP_ZAL') sp
      WHERE     e.REF = z.REF
            AND e.id = k.id
            AND a.acc IN (e.acc,
                          e.accd,
                          e.accp,
                          e.accr,
                          e.accr2,
                          e.accs)
            AND (a.nls LIKE '14%' or a.nls LIKE '31%')
            AND fost (e.acc, x.B) < 0
   ORDER BY e.id, e.REF;

PROMPT *** Create  grants  CP_V_ZAL_ACC ***
grant SELECT                                                                 on CP_V_ZAL_ACC    to BARSREADER_ROLE;
grant SELECT                                                                 on CP_V_ZAL_ACC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_V_ZAL_ACC    to START1;
grant SELECT                                                                 on CP_V_ZAL_ACC    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_V_ZAL_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
