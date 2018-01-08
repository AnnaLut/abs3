

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/W4_PORTFOLIO_ACTIVE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view W4_PORTFOLIO_ACTIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.W4_PORTFOLIO_ACTIVE ("ND", "BRANCH", "CARD_CODE", "ACC_ACC", "ACC_NLS", "ACC_KV", "ACC_LCV", "ACC_OB22", "ACC_TIP", "ACC_TIPNAME", "ACC_OST", "ACC_DAOS", "ACC_DAZS", "CUST_RNK") AS 
  SELECT o.nd,
         a.branch,
         o.card_code,
         a.acc,
         a.nls,
         a.kv,
         t.lcv,
         a.ob22,
         a.tip,
         s.name,
         a.ostc / POWER( 10, 2 ) ost,
         a.daos,
         a.dazs,
         a.rnk
    from W4_ACC o
   inner join ACCOUNTS      a on ( a.acc = o.acc_pk )
   inner join TIPS          s on ( s.tip = a.tip )
   inner join TABVAL$GLOBAL t on ( t.kv  = a.kv )
   where a.dazs Is Null;

PROMPT *** Create  grants  W4_PORTFOLIO_ACTIVE ***
grant SELECT                                                                 on W4_PORTFOLIO_ACTIVE to BARSREADER_ROLE;
grant SELECT                                                                 on W4_PORTFOLIO_ACTIVE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on W4_PORTFOLIO_ACTIVE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/W4_PORTFOLIO_ACTIVE.sql =========*** En
PROMPT ===================================================================================== 
