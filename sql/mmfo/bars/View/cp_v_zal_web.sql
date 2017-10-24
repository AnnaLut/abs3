

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_V_ZAL_WEB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_V_ZAL_WEB ***

  CREATE OR REPLACE VIEW CP_V_ZAL_WEB
(fdat, ref, nd, acc, vdat, id, vidd, ryn, cena, kol_all, kol_zal, dat_zal, nom_all, nom_zal, dis_zal, pre_zal, kun_zal, kuk_zal, prc_zal, nls, kv)
AS
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
   
comment on table CP_V_ZAL_WEB is 'ЦП (14*)';
comment on column CP_V_ZAL_WEB.FDAT is 'Станом на дату';
comment on column CP_V_ZAL_WEB.REF is 'Код угоди';
comment on column CP_V_ZAL_WEB.ND is 'Номер договору';
comment on column CP_V_ZAL_WEB.ACC is 'Рахунок номiналу ACC';
comment on column CP_V_ZAL_WEB.VDAT is 'Дата угоди';
comment on column CP_V_ZAL_WEB.ID is 'Внутр ID ЦП';
comment on column CP_V_ZAL_WEB.VIDD is 'Портфель баланс рах-к';
comment on column CP_V_ZAL_WEB.RYN is 'Суб портфель особовий рах-к';
comment on column CP_V_ZAL_WEB.CENA is 'Стартова Номiнальна вартiсть ЦП\Поточна Номiнальна вартiсть ЦП';
comment on column CP_V_ZAL_WEB.KOL_ALL is 'Загальна кількисть';
comment on column CP_V_ZAL_WEB.KOL_ZAL is 'ВВОД обтяжена кількість';
comment on column CP_V_ZAL_WEB.DAT_ZAL is 'ВВОД дата діі обтяження';
comment on column CP_V_ZAL_WEB.NOM_ALL is 'Загальний номінал';
comment on column CP_V_ZAL_WEB.NOM_ZAL is 'Обтяжений номінал';
comment on column CP_V_ZAL_WEB.DIS_ZAL is 'Обтяжений дісконт';
comment on column CP_V_ZAL_WEB.PRE_ZAL is 'Обтяжений премія';
comment on column CP_V_ZAL_WEB.KUN_ZAL is 'Обтяжений купон нарахування';
comment on column CP_V_ZAL_WEB.KUK_ZAL is '---';
comment on column CP_V_ZAL_WEB.PRC_ZAL is 'Обтяжена переоцінка';
comment on column CP_V_ZAL_WEB.NLS is 'Номер лицевого счета (внешний)';
comment on column CP_V_ZAL_WEB.KV is 'Валюта';

PROMPT *** Create  grants  CP_V_ZAL_WEB ***
grant DELETE,SELECT,UPDATE                                                   on CP_V_ZAL_WEB    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on CP_V_ZAL_WEB    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_V_ZAL_WEB.sql =========*** End *** =
PROMPT ===================================================================================== 
