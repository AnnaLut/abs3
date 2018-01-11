

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_CURACCOUNTS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_CURACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_CURACCOUNTS ("BID_ID", "RNK", "ACC", "NLS", "KV", "NMS", "DESCR", "SELECTED") AS 
  select b.id as bid_id,
       cd.rnk,
       a.acc,
       a.nls,
       a.kv,
       a.nms,
       a.nls || '(' || t.lcv || ') ' || a.nms as descr,
       case
         when wcs_utl.get_answ(b.id, 'PI_CURACC_ACCNO') = a.acc then
          1
         else
          0
       end as selected
  from wcs_bids b, cc_deal cd, accounts a, tabval t
 where b.id = cd.nd
   and cd.rnk = a.rnk
   and a.nls like '2620%'
   and a.kv = 980
   and a.dazs is null
   and a.kv = t.kv
 order by b.id, a.nls;

PROMPT *** Create  grants  V_WCS_BID_CURACCOUNTS ***
grant SELECT                                                                 on V_WCS_BID_CURACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BID_CURACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_CURACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_CURACCOUNTS.sql =========*** 
PROMPT ===================================================================================== 
