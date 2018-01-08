

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_V_ZAL_WEB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_V_ZAL_WEB ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_V_ZAL_WEB ("FDAT", "REF", "ND", "ACC", "VDAT", "ID", "VIDD", "RYN", "CENA", "KOL_ALL", "KOL_ZAL", "DAT_ZAL", "NOM_ALL", "NOM_ZAL", "DIS_ZAL", "PRE_ZAL", "KUN_ZAL", "KUK_ZAL", "PRC_ZAL", "NLS", "KV") AS 
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
            /*x.kolz,*/
           cp.sum_kolz(x.REF) kolz, -- 14.08.2017
          /* case when nvl(x.kolz,0) = 0 then null
           when x.kolz is not null then  nvl(to_date(F_GET_FROM_ACCOUNTSPV_DAT2(x.spid, x.acc, x.b)*/ nvl(cp.cp_zal_dat(x.ref),null) /*end*/ datz,  -- 14.08.017
            x.NOM_ALL * x.kf NOM_ALL,
            (x.NOM_ALL * /*x.kolz*/ cp.sum_kolz(x.REF) * x.kf / x.KOL_ALL) NOM_ZAL,
            ROUND ( (fost (x.accd, x.B) * /*x.kolz*/ cp.sum_kolz(x.REF) * x.kf / x.KOL_ALL), 2)
               DIS_ZAL,
            ROUND ( (fost (x.accp, x.B) * /*x.kolz*/ cp.sum_kolz(x.REF) * x.kf / x.KOL_ALL), 2)
               PRE_ZAL,
            ROUND ( (fost (x.accr, x.B) * /*x.kolz*/ cp.sum_kolz(x.REF) * x.kf / x.KOL_ALL), 2)
               KUN_ZAL,
            ROUND ( (fost (x.accr2, x.B) */*x.kolz*/ cp.sum_kolz(x.REF) * x.kf / x.KOL_ALL), 2)
               KUK_ZAL,
            ROUND ( (fost (x.accs, x.B) * /*x.kolz*/ cp.sum_kolz(x.REF) * x.kf / x.KOL_ALL), 2)
               PRC_ZAL,
            x.nls,
            x.kv
       FROM /*cp_zal z,*/  --14.08.2017
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
                    e.acc,  a.nls, a.kv,
                   ( select spid
     from sparam_list
    where tag = 'CP_ZAL') spid/*,
                    a.rnk -- 11.08.2017*/
               FROM cp_deal e,
                    cp_kod k,
                    accounts a,
                    (SELECT NVL (
                               TO_DATE (PUL.get ('DAT_ZAL'),'dd.mm.yyyy'),
                               gl.bd)
                               B
                       FROM DUAL) d
              WHERE     e.acc = a.acc
                    AND (a.nls LIKE '14%' OR a.nls LIKE '31%')
                    AND fost (a.acc, d.B) < 0
                    AND e.id = k.id) x
      WHERE x.REF = o.REF
        AND x.REF = /*z.REF(+)*/  nvl ((select z.ref from cp_zal z where  x.REF= z.ref(+) group by z.ref ), x.REF) -- 14.08.2017
   ORDER BY x.id, x.REF;

PROMPT *** Create  grants  CP_V_ZAL_WEB ***
grant SELECT                                                                 on CP_V_ZAL_WEB    to BARSREADER_ROLE;
grant DELETE,SELECT,UPDATE                                                   on CP_V_ZAL_WEB    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on CP_V_ZAL_WEB    to START1;
grant SELECT                                                                 on CP_V_ZAL_WEB    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_V_ZAL_WEB.sql =========*** End *** =
PROMPT ===================================================================================== 
