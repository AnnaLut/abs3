

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_ZAL_WEB14.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_ZAL_WEB14 ***

CREATE OR REPLACE VIEW V_CP_ZAL_WEB14
(fdat, ref, nd, acc, vdat, id, vidd, ryn, cena, kol_all, kol_zal, dat_zal, nom_all, nom_zal, dis_zal, pre_zal, kun_zal, kuk_zal, prc_zal, nls, kv, rnk, nmkk, id_cp_zal)
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
            z.kolz,
           case when nvl(/*x.kolz*/ z.kolz,0) = 0 then null
           when /*x.kolz*/ z.kolz is not null then z.datz /*nvl(to_date(F_GET_FROM_ACCOUNTSPV_DAT2 (x.spid, x.acc, x.b)),null)*/ end datz,
            x.NOM_ALL * x.kf NOM_ALL,
            (x.NOM_ALL * /*x.kolz*/ z.kolz * x.kf / x.KOL_ALL) NOM_ZAL,
            ROUND ( (fost (x.accd, x.B) * /*x.kolz*/ z.kolz * x.kf / x.KOL_ALL), 2)
               DIS_ZAL,
            ROUND ( (fost (x.accp, x.B) * /*x.kolz*/ z.kolz * x.kf / x.KOL_ALL), 2)
               PRE_ZAL,
            ROUND ( (fost (x.accr, x.B) * /*x.kolz*/ z.kolz * x.kf / x.KOL_ALL), 2)
               KUN_ZAL,
            ROUND ( (fost (x.accr2, x.B) * /*x.kolz*/ z.kolz * x.kf / x.KOL_ALL), 2)
               KUK_ZAL,
            ROUND ( (fost (x.accs, x.B) * /*x.kolz*/ z.kolz * x.kf / x.KOL_ALL), 2)
               PRC_ZAL,
            x.nls,
            x.kv,
            c.rnk, -- ID contragent
            c.nmkk, -- names contragent
            z.id_cp_zal --Код CP_ZAL
       FROM cp_zal z,
            oper o,
            --
            customer c,
            --
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
    where tag = 'CP_ZAL') spid,
                    a.rnk
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
                    AND e.id = k.id) x -- sel_end
      WHERE  x.REF = o.REF
        AND  (x.REF = z.REF(+)   --93883705001
        and  z.rnk =  c.rnk(+) )
   ORDER BY x.id, x.REF
;
comment on table V_CP_ZAL_WEB14 is 'ЦП (14*)для порех. по ссылке';
comment on column V_CP_ZAL_WEB14.FDAT is 'Станом на дату';
comment on column V_CP_ZAL_WEB14.REF is 'Код угоди';
comment on column V_CP_ZAL_WEB14.ND is 'Номер договору';
comment on column V_CP_ZAL_WEB14.ACC is 'Рахунок номiналу ACC';
comment on column V_CP_ZAL_WEB14.VDAT is 'Дата угоди';
comment on column V_CP_ZAL_WEB14.ID is 'Внутр ID ЦП';
comment on column V_CP_ZAL_WEB14.VIDD is 'Портфель баланс рах-к';
comment on column V_CP_ZAL_WEB14.RYN is 'Суб портфель особовий рах-к';
comment on column V_CP_ZAL_WEB14.CENA is 'Стартова Номiнальна вартiсть ЦП\Поточна Номiнальна вартiсть ЦП';
comment on column V_CP_ZAL_WEB14.KOL_ALL is 'Загальна кількисть';
comment on column V_CP_ZAL_WEB14.KOL_ZAL is 'ВВОД обтяжена кількість';
comment on column V_CP_ZAL_WEB14.DAT_ZAL is 'ВВОД дата діі обтяження';
comment on column V_CP_ZAL_WEB14.NOM_ALL is 'Загальний номінал';
comment on column V_CP_ZAL_WEB14.NOM_ZAL is 'Обтяжений номінал';
comment on column V_CP_ZAL_WEB14.DIS_ZAL is 'Обтяжений дісконт';
comment on column V_CP_ZAL_WEB14.PRE_ZAL is 'Обтяжений премія';
comment on column V_CP_ZAL_WEB14.KUN_ZAL is 'Обтяжений купон нарахування';
comment on column V_CP_ZAL_WEB14.KUK_ZAL is '---';
comment on column V_CP_ZAL_WEB14.PRC_ZAL is 'Обтяжена переоцінка';
comment on column V_CP_ZAL_WEB14.NLS is 'Номер лицевого счета (внешний)';
comment on column V_CP_ZAL_WEB14.KV is 'Валюта';
comment on column V_CP_ZAL_WEB14.RNK is 'Код Контрагента';
comment on column V_CP_ZAL_WEB14.NMKK is 'ФИО контрагента';
comment on column V_CP_ZAL_WEB14.id_cp_zal is 'Код CP_ZAL';


PROMPT *** Create  grants  V_CP_ZAL_WEB14 ***
grant DELETE,SELECT,UPDATE                                                   on V_CP_ZAL_WEB14    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_CP_ZAL_WEB14    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_ZAL_WEB14.sql =========*** End *** =
PROMPT ===================================================================================== 

