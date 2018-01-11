

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_INTPAYPRETENDERS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_INTPAYPRETENDERS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_INTPAYPRETENDERS ("DPT_ID", "DPT_NUM", "DPT_DAT", "BRANCH", "BRANCHNAME", "TYPE_ID", "TYPE_NAME", "DATBEG", "DATEND", "ACCID", "ACCNUM", "CURID", "SALDO_FACT", "SALDO_PLAN", "ACRDAT", "FREQID", "FREQNAME", "RCVMFO", "RCVACC", "INTPAYDATE") AS 
  select d.deposit_id, d.nd, d.datz, d.branch, b.name,
       v.vidd, v.type_name, d.dat_begin, d.dat_end,
       a.acc, a.nls, a.kv, a.ostc, a.ostb, i.acr_dat,
       d.freq, f.name, d.mfo_p, d.nls_p,
       dpt.get_intpaydate (bankdate,
                           d.dat_begin,
                           d.dat_end,
                           d.freq,
                           decode(v.amr_metr, 0, 0, 1),
                           decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                           1)
  from dpt_deposit d,
       dpt_vidd    v,
       freq        f,
       branch      b,
       int_accn    i,
       accounts    a
 where d.vidd   = v.vidd
   and d.freq   = f.freq
   and d.branch = b.branch
   and d.acc    = i.acc
   and i.id     = 1
   and i.acra   = a.acc
   and dpt.get_intpaydate (bankdate,
                           d.dat_begin,
                           d.dat_end,
                           d.freq,
                           decode(v.amr_metr, 0, 0, 1),
                           decode(nvl(d.cnt_dubl, 0), 0, 0, 1),
                           1)
       between dat_next_u (to_date(bankdate), -1) + 1 and bankdate;

PROMPT *** Create  grants  V_DPT_INTPAYPRETENDERS ***
grant SELECT                                                                 on V_DPT_INTPAYPRETENDERS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_INTPAYPRETENDERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_INTPAYPRETENDERS to DPT_ADMIN;
grant SELECT                                                                 on V_DPT_INTPAYPRETENDERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_INTPAYPRETENDERS.sql =========***
PROMPT ===================================================================================== 
