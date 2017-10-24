

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPTEXT_REFUSREQS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPTEXT_REFUSREQS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPTEXT_REFUSREQS ("DPT_ID", "DPT_NUM", "DPT_DAT", "DAT_BEGIN", "DAT_END", "BRANCH", "VIDD_CODE", "VIDD_NAME", "RATE", "CUST_ID", "CUST_NAME", "CUST_IDCODE", "DOC_SERIAL", "DOC_NUM", "DOC_ISSUED", "DOC_DATE", "DPT_ACCNUM", "DPT_CURCODE", "DPT_SALDO", "INT_ACCNUM", "INT_CURCODE", "INT_SALDO", "REQ_USERID", "REQ_USER", "REQ_BNKDAT", "REQ_SYSDAT") AS 
  select d.deposit_id, d.nd, d.datz, d.dat_begin, d.dat_end, d.branch,
       v.vidd, v.type_name, dpt_web.get_dptrate (a1.acc, a1.kv, d.limit, bankdate),
       c.rnk, c.nmk, c.okpo, p.ser, p.numdoc, p.organ, p.pdate,
       a1.nls, t.lcv, a1.ostc, a2.nls, t.lcv, a2.ostc,
       r.req_userid, s.fio, r.req_bnkdat, r.req_sysdat
  from dpt_extrefusals r,
       dpt_deposit     d,
       dpt_vidd        v,
       customer        c,
       person          p,
       int_accn        i,
       saldo           a1,
       saldo           a2,
       tabval          t,
       staff$base      s
 where r.dptid      = d.deposit_id
   and d.acc        = a1.acc
   and d.acc        = i.acc
   and i.id         = 1
   and i.acra       = a2.acc
   and a1.kv        = t.kv
   and d.vidd       = v.vidd
   and d.rnk        = c.rnk
   and c.rnk        = p.rnk
   and r.req_userid = s.id
   and v.fl_dubl    = 2
   and d.dat_begin <= bankdate
   and d.dat_end   >= bankdate
   and r.req_state is null;

PROMPT *** Create  grants  V_DPTEXT_REFUSREQS ***
grant SELECT                                                                 on V_DPTEXT_REFUSREQS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPTEXT_REFUSREQS to DPT_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPTEXT_REFUSREQS.sql =========*** End
PROMPT ===================================================================================== 
