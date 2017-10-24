

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAY_SPLIT_DTL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAY_SPLIT_DTL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAY_SPLIT_DTL ("RNK", "NMK", "ACC", "NLS", "KV", "LCV", "DIG", "FDAT", "REF", "DOC_AMNT", "SPLIT_AMNT", "SALE_TP", "DAY_QTY") AS 
  select c.rnk
     , c.nmk
     , a.acc
     , a.nls
     , a.kv
     , t.lcv
     , t.dig
     , o.fdat
     , o.ref
     , o.S/t.DENOM
     , nvl(sa.AMNT/t.DENOM,0)
     , nvl(sa.SALE_TP,0)
     , ( select count(1)
           from BARS.FDAT f
          where f.FDAT between o.FDAT and BARS.BANKDATE()
       )
  from BARS.ACCOUNTS a
  join BARS.CUSTOMER c
    on ( c.RNK = a.RNK )
  join BARS.TABVAL$GLOBAL t
    on ( t.KV = a.KV )
  join BARS.OPLDOK o
    on ( o.ACC = a.ACC )
  join ( select sa.REF, sa.SALE_TP, sa.AMNT
           from BARS.ZAY_SPLITTING_AMOUNT sa
           left
           join BARS.ZAY_DEBT zd
             on ( zd.REF = sa.REF and zd.SALE_TP = sa.SALE_TP )
          where zd.REF Is Null
       ) sa
    on ( sa.REF = o.REF )
 where a.NBS = '2603'
   and a.kv <> 980
   and o.FDAT between BARS.DAT_NEXT_U(BARS.BANKDATE(),-3) and BARS.BANKDATE()
   and o.DK  = 1
   and o.SOS = 5
;

PROMPT *** Create  grants  V_ZAY_SPLIT_DTL ***
grant SELECT                                                                 on V_ZAY_SPLIT_DTL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ZAY_SPLIT_DTL to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAY_SPLIT_DTL.sql =========*** End **
PROMPT ===================================================================================== 
