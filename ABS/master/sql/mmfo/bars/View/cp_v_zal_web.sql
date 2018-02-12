

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_V_ZAL_WEB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_V_ZAL_WEB ***

  CREATE OR REPLACE VIEW CP_V_ZAL_WEB
(fdat, ref, nd, acc, vdat, id, vidd, ryn, cena, kol_all, kol_zal, dat_zal, nom_all, nom_zal, dis_zal, pre_zal, kun_zal, kuk_zal, prc_zal, nls, kv)
AS
     SELECT x.b,
            x.ref,
            o.nd,
            x.acc,
            o.vdat,
            x.id,
            x.vidd,
            x.ryn,
            x.cena,
            x.kol_all,
            x.kolz,
            case when nvl(x.kolz,0) = 0 then null
                 when x.kolz is not null then  cp.get_from_cp_zal_dat(x.ref, x.b)
            end datz,
            x.nom_all * x.kf nom_all,
            (x.nom_all * x.kolz * x.kf / x.kol_all) nom_zal,
            ROUND((fost(x.accd, x.b) * x.kolz * x.kf / x.kol_all), 2)  dis_zal,
            ROUND((fost(x.accp, x.b) * x.kolz * x.kf / x.kol_all), 2)  pre_zal,
            ROUND((fost(x.accr, x.b) * x.kolz * x.kf / x.kol_all), 2)  kun_zal,
            ROUND((fost(x.accr2, x.b) * x.kolz * x.kf / x.kol_all), 2) kuk_zal,
            ROUND((fost(x.accs, x.b) * x.kolz * x.kf / x.kol_all), 2)  prc_zal,
            x.nls, 
            x.kv
       FROM oper o,
            (SELECT d.b,
                    0.01 kf,
                    e.ref,
                    e.id,
                    fost(e.acc, d.b) nom_all,
                    f_cena_cp(e.id, d.b, 0) cena,                   --k.cena,
                    ROUND(-fost (e.acc, d.b) / 100 / f_cena_cp (e.id, d.b, 0), 5) kol_all,
                    cp.get_from_cp_zal_kolz (e.ref, d.b) kolz,
                    e.accd,
                    e.accp,
                    e.accr,
                    e.accr2,
                    e.accs,
                    SUBSTR(a.nls, 1, 4) vidd,
                    e.ryn,
                    e.acc,  
                    a.nls, 
                    a.kv
               FROM cp_deal e,
                    accounts a,
                    (SELECT NVL(TO_DATE(PUL.get('DAT_ZAL'),'dd.mm.yyyy'), gl.bd) B
                       FROM DUAL) d
               WHERE e.acc = a.acc
                 AND (a.nls LIKE '14%' OR a.nls LIKE '31%')
                 AND fost (a.acc, d.B) < 0
              ) x
      WHERE x.ref = o.ref
      ORDER BY x.id, x.ref;
   
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
comment on column CP_V_ZAL_WEB.KOL_ZAL is 'Обтяжена кількість';
comment on column CP_V_ZAL_WEB.DAT_ZAL is 'Дата діі обтяження';
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
