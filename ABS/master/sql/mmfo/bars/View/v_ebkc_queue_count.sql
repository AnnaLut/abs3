

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_QUEUE_COUNT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_QUEUE_COUNT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_QUEUE_COUNT ("NAME_TYPE", "CUST_TYPE", "COUNT_RNK") AS 
  select ct.txt as name_type
     , ct.cust_type
     , count(s1.RNK) as count_rnk
  from EBKC_CUST_TYPES ct
  left
  join ( select rnk
              , nvl(cust_type, ebkc_pack.get_custtype(rnk)) as cust_type
           from ebkc_queue_updatecard
          union all
         select rnk, 'I'
           from ebk_queue_updatecard
       ) s1
    on ( s1.cust_type = ct.cust_type )
  group by ct.txt, ct.cust_type;

PROMPT *** Create  grants  V_EBKC_QUEUE_COUNT ***
grant SELECT                                                                 on V_EBKC_QUEUE_COUNT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_QUEUE_COUNT.sql =========*** End
PROMPT ===================================================================================== 
