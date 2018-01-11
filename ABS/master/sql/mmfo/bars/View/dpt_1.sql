

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DPT_1.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view DPT_1 ***

  CREATE OR REPLACE FORCE VIEW BARS.DPT_1 ("ID", "ND", "DATZ", "DATN", "DATK", "FREQ", "STOP_ID", "RNK", "NMK", "OKPO", "VIDD", "NAM", "BR_ID", "LCV", "DIG", "ACC", "NLS", "KV", "ISP", "S", "PR", "ACCN", "SN", "ACR_DAT", "APL_DAT", "MFOP", "NLSP", "NMSP", "OKPOP", "TTP", "NAZNP", "MFOV", "NLSV", "NMSV", "OKPOV", "DPTV", "ACCV", "SROK", "SROK1", "DD", "BRANCH") AS 
  select d.id, d.nd, d.datz, d.datn, d.datk, d.freq, d.stop_id,
       c.rnk, c.nmk, c.okpo, v.vidd, v.type_name, v.br_id, t.lcv, t.dig,
       d.acc, d.nls, d.kv, d.isp, d.s, d.pr, d.accn, d.sn, d.acr_dat, d.apl_dat,
       d.mfop, d.nlsp, d.nmsp, d.okpop, d.ttp, d.naznp,
       d.mfov, d.nlsv, d.nmsv, d.okpov, d.dptv, d.accv,
       d.srok, d.srok1, to_number(to_char(d.datn, 'dd')), d.branch
  from dpt_0 d, dpt_vidd v, customer c, tabval t
 where c.rnk  = d.rnk
   and d.vidd = v.vidd
   and d.kv   = t.kv
 ;

PROMPT *** Create  grants  DPT_1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_1           to ABS_ADMIN;
grant SELECT                                                                 on DPT_1           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_1           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_1           to DPT;
grant SELECT                                                                 on DPT_1           to START1;
grant SELECT                                                                 on DPT_1           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_1           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DPT_1.sql =========*** End *** ========
PROMPT ===================================================================================== 
