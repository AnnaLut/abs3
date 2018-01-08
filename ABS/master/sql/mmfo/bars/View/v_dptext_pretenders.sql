

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPTEXT_PRETENDERS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPTEXT_PRETENDERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPTEXT_PRETENDERS ("DPT_ID", "DPT_NUM", "DPT_DAT", "DAT_BEGIN", "DAT_END", "BRANCH", "VIDD_CODE", "VIDD_NAME", "RATE", "CUST_ID", "CUST_NAME", "CUST_IDCODE", "DOC_SERIAL", "DOC_NUM", "DOC_ISSUED", "DOC_DATE", "DPT_ACCNUM", "DPT_CURCODE", "DPT_SALDO", "INT_ACCNUM", "INT_CURCODE", "INT_SALDO") AS 
  select d.deposit_id, d.nd, d.datz, d.dat_begin, d.dat_end, d.branch,
       v.vidd, v.type_name, dpt_web.get_dptrate (a1.acc, a1.kv, d.limit, bankdate),
       c.rnk, c.nmk, c.okpo, p.ser, p.numdoc, p.organ, p.pdate,
       a1.nls, t.lcv, a1.ostc, a2.nls, t.lcv, a2.ostc
  from dpt_deposit  d,
       dpt_vidd     v,
       customer     c,
       person       p,
       int_accn     i,
       saldo        a1,
       saldo        a2,
       tabval       t
 where d.acc        = a1.acc
   and d.acc        = i.acc
   and i.id         = 1
   and i.acra       = a2.acc
   and a1.kv        = t.kv
   and d.vidd       = v.vidd
   and d.rnk        = c.rnk
   and c.rnk        = p.rnk
   and v.fl_dubl    = 2
   and d.dat_begin <= bankdate
   and d.dat_end   >= bankdate
   and not exists (select 1
                     from dpt_extrefusals r
                    where r.dptid = d.deposit_id
                      and nvl(r.req_state, 0) >= 0);

PROMPT *** Create  grants  V_DPTEXT_PRETENDERS ***
grant SELECT                                                                 on V_DPTEXT_PRETENDERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPTEXT_PRETENDERS to DPT_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPTEXT_PRETENDERS.sql =========*** En
PROMPT ===================================================================================== 
