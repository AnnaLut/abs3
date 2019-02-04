

PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/View/CP_V_ZAL_ACC_K.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_V_ZAL_ACC_K ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_V_ZAL_ACC_K ("FDAT", "REF", "ID", "ISIN", "NLS", "KV", "ACC", "OST", "SUM_ZAL", "DAT_ZAL", "CP_ACCTYPE") AS 
  SELECT x.B FDAT,
            e.REF,
            k.id,
            k.cp_id,
            a.nls,
            a.kv,
            a.acc,
            fostdt_snpf (a.acc, trunc(x.B,'MM')) OST,
            ROUND (
                 fostdt_snpf (a.acc, trunc(x.B,'MM'))
               * cp.get_from_cp_zal_kolz (e.ref, x.b)
               / (-fostdt_snpf (e.acc, trunc(x.B,'MM')) / f_cena_cp (k.id, x.B, 0) / 100),
               0)
               ost_zal,
            NVL (cp.get_from_cp_zal_dat(e.ref, x.b), a.mdate)
               datz,
            ca.cp_acctype
       FROM cp_deal e,
            cp_kod k,
            accounts a,
            (SELECT NVL (
                       TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy'),
                       gl.bd)
                       B
               FROM DUAL) x,
            cp_accounts ca 
      WHERE e.id = k.id
            AND ca.cp_acc = a.acc and e.ref = ca.cp_ref
            AND ca.cp_acctype in ('N','D','P','R','R2','R3','S','S2','SR')
            AND (a.nls LIKE '14%' or a.nls LIKE '31%')
            AND fostdt_snpf (e.acc, trunc(x.B,'MM')) < 0
   ORDER BY e.id, e.REF;

comment on column CP_V_ZAL_ACC_K.FDAT is 'Дата ...';
comment on column CP_V_ZAL_ACC_K.ACC is 'ACC рах-ку';
comment on column CP_V_ZAL_ACC_K.SUM_ZAL is 'Сума Обтяження';
comment on column CP_V_ZAL_ACC_K.DAT_ZAL is 'Дата Обтяження до';

PROMPT *** Create  grants  CP_V_ZAL_ACC_K ***
grant SELECT                    on CP_V_ZAL_ACC_K    to BARS_ACCESS_DEFROLE;
grant SELECT                    on CP_V_ZAL_ACC_K    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/View/CP_V_ZAL_ACC_K.sql =========*** End *** =
PROMPT ===================================================================================== 
