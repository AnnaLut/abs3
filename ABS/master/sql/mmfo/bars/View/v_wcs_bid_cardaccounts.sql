

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_CARDACCOUNTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_CARDACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_CARDACCOUNTS ("BID_ID", "RNK", "ACC", "NLS", "KV", "NMS", "DAOS", "DESCR") AS 
  select b.id as bid_id,
       b.rnk,
       a.acc,
       a.nls,
       a.kv,
       a.nms,
       a.daos,
       a.nls || '(' || t.lcv || ', ' || to_char(a.daos, 'dd.mm.yyyy') || ') ' ||
       a.nms as descr
  from wcs_bids b, accounts a, tabval t
 where b.rnk = a.rnk
   and a.nbs = '2625'
   and a.tip like 'W4%'
   and a.dazs is null
   and a.kv = t.kv
 order by b.id, a.nls;

PROMPT *** Create  grants  V_WCS_BID_CARDACCOUNTS ***
grant SELECT                                                                 on V_WCS_BID_CARDACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BID_CARDACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_CARDACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_CARDACCOUNTS.sql =========***
PROMPT ===================================================================================== 
