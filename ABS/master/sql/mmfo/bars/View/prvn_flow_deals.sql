

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PRVN_FLOW_DEALS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view PRVN_FLOW_DEALS ***

  CREATE OR REPLACE FORCE VIEW BARS.PRVN_FLOW_DEALS ("SDATE", "WDATE", "ID", "ND", "ACC", "KV", "VIDD", "RNK", "I_CR9", "PR_TR", "VAR_WDATE", "TIP", "DAOS", "DAZS", "KV8", "ACC8", "FL2", "DAT_ADD", "ZDAT", "K", "K1", "OST", "OST8", "OSTQ", "OST8Q", "IR", "IRR0", "SN", "CR9", "SPN", "SNO", "SN8", "SK0", "SK9", "SDI", "S36", "SP", "SD1", "SD2", "SNA", "ADD2", "BAL0", "ZO", "FV_REZB") AS 
  select c.sdate, c.wdate, c.id, c.nd , c.acc , c.kv  ,
       nvl(v.vidd , c.vidd ) VIDD ,
       nvl(v.rnk  , c.rnk  ) RNK  ,
       nvl(v.i_cr9, c.i_cr9) I_CR9,
       nvl(v.pr_tr, c.pr_tr) PR_TR,
       nvl(v.wdate,c.wdate) VAR_WDATE,
       c.tip , c.daos, c.dazs,   c.kv8 , c.acc8, c.fl2, c.dat_add,
       v.zdat, v.k, v.k1, v.ost, v.ost8, v.ostq, v.ost8q, v.ir , v.irr0,
       v.SN  , v.CR9, v.SPN , v.SNO , v.SN8  , v.SK0, v.SK9 , v.SDI , v.S36, v.sp, v.sd1, v.sd2, v.sna,
       0 add2, 0 bal0, v.ZO, v.FV_REZB
 from  bars.prvn_flow_deals_const c,
       bars.prvn_flow_deals_var   v
 where c.id = v.id(+);

PROMPT *** Create  grants  PRVN_FLOW_DEALS ***
grant SELECT                                                                 on PRVN_FLOW_DEALS to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on PRVN_FLOW_DEALS to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on PRVN_FLOW_DEALS to START1;
grant SELECT                                                                 on PRVN_FLOW_DEALS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PRVN_FLOW_DEALS.sql =========*** End **
PROMPT ===================================================================================== 
