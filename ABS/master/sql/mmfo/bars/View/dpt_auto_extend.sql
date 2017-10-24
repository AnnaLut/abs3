

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_AUTO_EXTEND.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_AUTO_EXTEND ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_AUTO_EXTEND ("DPT_ID", "ND", "DAT_BEGIN_OLD", "DAT_END_OLD", "ACC", "NLS", "KV", "NMS", "OST", "DAT_START", "RNK", "NMK", "OKPO", "VIDD", "TYPE_NAME", "TERM_M", "TERM_D", "TERM_DUBL", "DAT_BEGIN_NEW", "DAT_END_NEW", "DATX", "EXTENSION_ID", "CNT_DUBL", "CNT_EXT_INT", "DAT_EXT_INT", "ACCN", "IR", "OP", "BR", "BR_ID") AS 
  select dep.deposit_id, dep.nd, dep.dat_begin, dep.dat_end,
       dep.acc, dep.nls, dep.kv, dep.nms, dep.ostc, dep.daos, c.rnk, c.nmk, c.okpo,
       dep.vidd, dep.type_name, dep.duration, dep.duration_days, dep.term_dubl,
       dep.datbeg_new, dep.datend_new, dep.datx, dep.extension_id,
       dep.cnt_dubl, dep.cnt_ext_int, nvl(dep.dat_ext_int, dep.datbeg_new),
       i.acra, r.ir, o.semantic, getbrat(bankdate, r.br, dep.kv, dep.ostc), r.br
  from
      (select deposit_id, nd, dat_begin, dat_end, rnk,
              acc, nls, kv, nms, ostc, daos,
              vidd, type_name, term_dubl, extension_id,
              duration, duration_days,
              datbeg_new,
              dpt.get_datend_uni(datbeg_new, duration, duration_days, vidd) datend_new,
              decode(term_dubl,
                     0,
                     to_date(null),
                     dpt.get_datend_uni(daos,
                                        duration * (1 + term_dubl),
                                        duration_days * (1 + term_dubl),
                                        vidd)) datx,
              cnt_dubl, cnt_ext_int, dat_ext_int
         from
             (select d.deposit_id, d.nd, d.dat_begin, d.dat_end, d.rnk,
                     s.acc, s.nls, s.kv, substr(s.nms, 1, 38) nms, s.ostc, s.daos,
                     v.vidd, v.type_name, nvl(v.term_dubl, 0) term_dubl, v.extension_id,
                    (case when v.term_type = 1
                          then nvl(v.duration, 0)
                          else 0
                     end) duration,
                    (case when v.term_type = 1
                          then nvl(v.duration_days, 0)
                          else (d.dat_end - d.dat_begin)
                     end) duration_days,
                     (d.dat_end + x.dd) datbeg_new,
                     nvl(d.cnt_dubl, 0) cnt_dubl,
                     nvl(d.cnt_ext_int, 0) cnt_ext_int,
                     d.dat_ext_int
                from dpt_deposit d,
                     saldo       s,
                     dpt_vidd    v,
                    (select to_number(val) dd from params where par = 'DPT_EXTD') x
               where d.acc     = s.acc
                 and d.vidd    = v.vidd
                 and v.fl_dubl = 1)  ) dep,
       customer c,
       int_accn i,
       int_ratn r,
       int_op   o
 where dep.rnk = c.rnk
   and dep.datbeg_new <= bankdate
   and dep.datend_new >  dep.datbeg_new
   and dep.acc  = i.acc
   and i.id     = 1
   and r.acc    = i.acc
   and r.id     = i.id
   and r.bdat   = (select max(bdat) from int_ratn where acc = r.acc and id = r.id and bdat <= bankdate)
   and r.op     = o.op(+)
   and dep.ostc > 0
   and (dep.term_dubl = 0 or dep.term_dubl > dep.cnt_dubl or dep.datend_new <= dep.datx)
 ;

PROMPT *** Create  grants  DPT_AUTO_EXTEND ***
grant SELECT                                                                 on DPT_AUTO_EXTEND to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_AUTO_EXTEND to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_AUTO_EXTEND to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_AUTO_EXTEND.sql =========*** End **
PROMPT ===================================================================================== 
