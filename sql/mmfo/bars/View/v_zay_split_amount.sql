

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_SPLIT_AMOUNT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_SPLIT_AMOUNT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_SPLIT_AMOUNT ("RNK", "NMK", "ACC", "KV", "LCV", "DIG", "NLS", "FDAT", "REF", "AMNT", "IS_SPLIT") AS 
  select c.rnk
     , c.nmk
     , a.acc
     , a.kv
     , t.lcv
     , t.dig
     , a.nls
     , o.fdat
     , o.ref
     , o.S/t.DENOM
     , nvl2(sa.REF,least(sa.QTY,2),0)
  from BARS.ACCOUNTS a
  join BARS.CUSTOMER c
    on ( c.RNK = a.RNK )
  join BARS.TABVAL$GLOBAL t
    on ( t.KV = a.KV )
  join BARS.OPLDOK o
    on ( o.ACC = a.ACC )
  left
  join ( select unique REF
           from BARS.ZAY_DEBT
       ) z
    on ( z.REF = o.REF )
  left
  join ( select REF
              , count(1) as QTY
           from BARS.ZAY_SPLITTING_AMOUNT
          group by REF
       ) sa
    on ( sa.REF =  o.REF )
 where a.NBS = '2603'
   and a.kv <> 980
   and o.FDAT between dat_next_u(bankdate,-1) and bankdate
   and o.DK  = 1
   and o.SOS = 5
   and z.REF Is Null
;

PROMPT *** Create  grants  V_ZAY_SPLIT_AMOUNT ***
grant SELECT                                                                 on V_ZAY_SPLIT_AMOUNT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_SPLIT_AMOUNT to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_SPLIT_AMOUNT.sql =========*** End
PROMPT ===================================================================================== 
