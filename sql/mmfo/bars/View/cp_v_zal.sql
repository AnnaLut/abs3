

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
            case when nvl(x.kolz,0) = 0 then null
                 when x.kolz is not null then  nvl(cp.get_from_cp_zal_dat(x.ref, x.b),null) 
            end datz,
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
                    cp.get_from_cp_zal_kolz (e.ref, d.b) kolz,
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
comment on column CP_V_ZAL.FDAT is 'Станом на дату';
comment on column CP_V_ZAL.REF is 'Реф-с угоди куп_вл_ пакета';
comment on column CP_V_ZAL.ND is '№ угоди';
comment on column CP_V_ZAL.VDAT is 'Дата угоди';
comment on column CP_V_ZAL.ID is 'Код ЦП (ID)';
comment on column CP_V_ZAL.VIDD is 'Портфель~Бал.рахунок';
comment on column CP_V_ZAL.RYN is 'Субпортфель';
comment on column CP_V_ZAL.KOL_ALL is 'Загальна к_льк_сть';
comment on column CP_V_ZAL.KOL_ZAL is 'Обтяжена К_льк_сть (пакет або доля пакета )';
comment on column CP_V_ZAL.DAT_ZAL is 'Обтяження Дата до';
comment on column CP_V_ZAL.NOM_ALL is 'Загальний ном_нал';
comment on column CP_V_ZAL.NOM_ZAL is 'Обтяжений ном_нал';
comment on column CP_V_ZAL.DIS_ZAL is 'Обтяжений дисконт';
comment on column CP_V_ZAL.PRE_ZAL is 'Обтяжена прем_я';
comment on column CP_V_ZAL.KUN_ZAL is 'Обтяжений купон нарахований';
comment on column CP_V_ZAL.KUK_ZAL is 'Обтяжений купон сплачений';
comment on column CP_V_ZAL.PRC_ZAL is 'Обтяжена переоц_нка';
PROMPT *** Create  grants  CP_V_ZAL ***
grant SELECT,UPDATE                                                          on CP_V_ZAL        to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on CP_V_ZAL        to CP_ROLE;
grant SELECT,UPDATE                                                          on CP_V_ZAL        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_V_ZAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
