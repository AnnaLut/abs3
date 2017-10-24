

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V1_BRO.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V1_BRO ***

  CREATE OR REPLACE FORCE VIEW BARS.V1_BRO ("ND", "BRANCH", "NMK", "OKPO", "RNK", "TIP", "NBS", "NLS", "CC_ID", "SOS", "LIMIT", "IR", "SDATE", "WDATE", "B", "E", "FDAT", "PPR", "NPR", "VPR", "TERM", "S180", "SDAT") AS 
  select x.nd, x.branch, c.nmk, c.okpo, c.rnk, a.tip, a.nbs, a.nls,  x.cc_id, x.sos, x.limit, x.ir,  x.sdate, x.wdate, x.B, x.E, x.FDAT,
       x.PPR, -- План - Нараховані проценти по договору
       x.NPR, -- Факт - Нараховані проценти по договору
       Decode ( x.sos,15, x.NPR, 0)  VPR,    --Виплачені % по договору
       x.TERM,
       CASE WHEN x.TERM <=   1 THEN  '2'
            WHEN x.TERM <=   7 THEN  '3'
            WHEN x.TERM <=  21 THEN  '4'
            WHEN x.TERM <=  31 THEN  '5'
            WHEN x.TERM <=  92 THEN  '6'
            WHEN x.TERM <= 183 THEN  '7'
            WHEN x.TERM <= 274 THEN  'A'
            WHEN x.wdate +1 <= add_months( x.sdate , 12 )  THEN  'B'
            WHEN x.wdate +1 <= add_months( x.sdate , 18 )  THEN  'C'
            WHEN x.wdate +1 <= add_months( x.sdate , 24 )  THEN  'D'
            WHEN x.wdate +1 <= add_months( x.sdate , 36 )  THEN  'E'
            WHEN x.wdate +1 <= add_months( x.sdate , 60 )  THEN  'F'
            WHEN x.wdate +1 <= add_months( x.sdate ,120 )  THEN  'G'
            else                                                 'H'
            END  S180,
       sysdate sdat
from customer c, accounts a, nd_acc n,
     (select d.nd, d.branch, d.cc_id, d.sos, d.limit, d.ir,  d.sdate, d.wdate, d.rnk, v.B, v.E, (d.wdate - d.sdate +1) TERM,
            (select min(EFFECTDATE) from cc_deal_update where nd = d.nd and sos >=14) FDAT,
             to_number ( (select txt from nd_txt where nd = d.nd and tag = 'KNL' )) /100 PPR, -- План - Нараховані проценти по договору
             to_number ( (select txt from nd_txt where nd = d.nd and tag = 'KDO' )) /100 NPR -- Факт - Нараховані проценти по договору
      from cc_deal d , V_SFDAT v where d.vidd = 26 and d.wdate >= v.B and d.SDATE <= v.E
     ) x
where  x.rnk  = c.rnk   and a.rnk  = c.rnk   and x.nd   = n.nd   and n.acc  = a.acc ;

PROMPT *** Create  grants  V1_BRO ***
grant SELECT                                                                 on V1_BRO          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V1_BRO          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V1_BRO.sql =========*** End *** =======
PROMPT ===================================================================================== 
