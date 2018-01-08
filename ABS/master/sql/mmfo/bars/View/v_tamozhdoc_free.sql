

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TAMOZHDOC_FREE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TAMOZHDOC_FREE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TAMOZHDOC_FREE ("RNK", "NMK", "OKPO", "ND", "IMPEXP", "ID_TD", "NAME_TD", "DATE_TD", "KV_TD", "S_TD", "KURS_TD", "LCV", "DIG", "ID_R", "NAME_R", "DATE_R", "FL", "NAME_K", "DATE_K", "BENEFCOUNTRY", "BENEFNAME", "MC_FN", "MC_DAT", "MC_NUM") AS 
  select c.rnk, c.nmk, c.okpo, c.nd, t.impexp,
       t.idt, t.name, t.datedoc,
       t.kv, t.s, t.kurs, v.lcv, v.dig,
       tr.idr, tr.name, tr.dater, 0,
       substr(TranslateDos2Win(d.doc),1,28),
       trunc(d.sdate),
       to_number(d.f_country),
       substr(decode(to_number(d.cmode_code), 40,
                     TranslateDos2Win(d.s_name),
                     TranslateDos2Win(d.r_name)),1,70),
       d.fn, d.dat, d.n
  from tamozhdoc t, customer c, tamozhdoc_reestr tr, tabval v, customs_decl d
 where t.rnk = c.rnk
   and t.kv = v.kv
   and t.idr = tr.idr(+)
   and t.pid is null
   and t.id is null
   and d.idt(+) = t.idt
 union all
select k.rnk, k.nmk, k.okpo, k.nd, decode(to_number(v.cmode_code), 40, 1, 0),
       null, v.cnum_cst||'/'||substr(v.cnum_year,-1,1)||'/'||v.cnum_num, trunc(v.allow_dat),
       v.kv, v.s, v.kurs/power(10,8), t.lcv, t.dig,
       null, null, null, 1,
       substr(TranslateDos2Win(v.doc),1,28),
       trunc(v.sdate),
       to_number(v.f_country),
       substr(decode(to_number(v.cmode_code), 40,
                     TranslateDos2Win(v.s_name),
                     TranslateDos2Win(v.r_name)),1,70),
       v.fn, v.dat, v.n
  from customs_decl v, country c, customer k, tabval t
 where v.kv = t.kv
   and to_number(v.f_country) = c.country
   and v.isnull = 1
   and nvl(v.fl_eik,0) = 0
   and v.idt is null
   and v.f_okpo = k.okpo
   and k.date_off is null
   and exists (select 1 from birja
                where par = 'MC2EIK' and nvl(to_number(val),0) = 1);

PROMPT *** Create  grants  V_TAMOZHDOC_FREE ***
grant SELECT                                                                 on V_TAMOZHDOC_FREE to BARSREADER_ROLE;
grant SELECT                                                                 on V_TAMOZHDOC_FREE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TAMOZHDOC_FREE to START1;
grant SELECT                                                                 on V_TAMOZHDOC_FREE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TAMOZHDOC_FREE.sql =========*** End *
PROMPT ===================================================================================== 
