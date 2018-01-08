

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_0.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_0 ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_0 ("ID", "ND", "DATZ", "DATN", "DATK", "RNK", "VIDD", "FREQ", "STOP_ID", "ACC", "NLS", "KV", "ISP", "S", "PR", "ACCN", "SN", "ACR_DAT", "APL_DAT", "MFOP", "NLSP", "NMSP", "OKPOP", "TTP", "NAZNP", "MFOV", "NLSV", "NMSV", "OKPOV", "DPTV", "ACCV", "SROK", "SROK1", "BRANCH") AS 
  select d.deposit_id, nvl(d.nd, to_char(d.deposit_id)), d.datz,
       d.dat_begin, d.dat_end, d.rnk, d.vidd, d.freq, d.stop_id,
       a.acc, a.nls, a.kv, a.isp, a.ostc, acrn.fproc(a.acc, bankdate),
       i.acra, decode(d.acc, i.acra, 0, fost(i.acra, bankdate)), i.acr_dat, i.apl_dat,
       d.mfo_p, d.nls_p, substr(d.name_p, 1, 38), d.okpo_p, i.ttb, i.nazn,
       d.mfo_d, d.nls_d, d.nms_d, d.okpo_d, d.dpt_d, d.acc_d,
       round(months_between(nvl(d.dat_end, bankdate), d.dat_begin)),
       decode(sign(nvl(d.dat_end, bankdate) - bankdate), 1,
              round(months_between(d.dat_end,bankdate)),
              0),
       d.branch
  from dpt_deposit d, accounts a, int_accn i
 where d.acc = a.acc
   and a.acc = i.acc
   and i.id  = 1
 ;

PROMPT *** Create  grants  DPT_0 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_0           to ABS_ADMIN;
grant SELECT                                                                 on DPT_0           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_0           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_0           to START1;
grant SELECT                                                                 on DPT_0           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_0           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_0.sql =========*** End *** ========
PROMPT ===================================================================================== 
