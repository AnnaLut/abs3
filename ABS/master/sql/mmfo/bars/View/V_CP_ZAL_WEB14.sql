

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_ZAL_WEB14.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_ZAL_WEB14 ***
CREATE OR REPLACE VIEW V_CP_ZAL_WEB14
as
select zz.fdat,
       case
         when zz.fdat between zz.datz_from and zz.datz_to then
          1
         else
          0
       end in_st,
       zz.ref,
       zz.id,
       zz.kolz,
       zz.datz_from,
       zz.datz_to,
       zz.id_cp_zal,
       zz.rnk
  from (select NVL(TO_DATE(PUL.get('DAT_ZAL'), 'dd.mm.yyyy'), gl.bd) fdat,
               z.ref,
               z.id,
               z.kolz,
               z.datz_from,
               z.datz_to,
               z.id_cp_zal,
               z.rnk
          from cp_zal z
         /*where z.ref = 25539589601*/) zz
 order by zz.rnk nulls first, zz.datz_from;
comment on table V_CP_ZAL_WEB14 is 'ЦП (14*) редагування в розрізі контрагентів по угоді';
comment on column V_CP_ZAL_WEB14.FDAT is 'Станом на дату';
comment on column V_CP_ZAL_WEB14.IN_ST is '1 - якщо запис діє на Станом на дату';
comment on column V_CP_ZAL_WEB14.REF is 'Референс угоди';
comment on column V_CP_ZAL_WEB14.ID is 'ID ЦП';
comment on column V_CP_ZAL_WEB14.KOLZ is 'Кількість в заставі';
comment on column V_CP_ZAL_WEB14.DATZ_FROM is 'Діє з';
comment on column V_CP_ZAL_WEB14.DATZ_TO is 'Діє по';
comment on column V_CP_ZAL_WEB14.ID_CP_ZAL is 'Унікальний ід запису';
comment on column V_CP_ZAL_WEB14.RNK is 'RNK контрагенту';


PROMPT *** Create  grants  V_CP_ZAL_WEB14 ***
grant DELETE,SELECT,UPDATE                                                   on V_CP_ZAL_WEB14    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_CP_ZAL_WEB14    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_ZAL_WEB14.sql =========*** End *** =
PROMPT ===================================================================================== 

