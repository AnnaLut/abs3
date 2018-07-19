PROMPT *** Create  view V_EBKC_QUEUE_COUNT ***

CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_QUEUE_COUNT ("NAME_TYPE", "CUST_TYPE", "COUNT_RNK"
) AS 
select ct.txt as name_type
     , ct.cust_type
     , count(s1.RNK) as count_rnk
  from EBKC_CUST_TYPES ct
  left
  join ( select RNK
              , coalesce( CUST_TYPE, EBKC_PACK.GET_CUSTTYPE( RNK ) ) as CUST_TYPE
           from EBKC_QUEUE_UPDATECARD
       ) s1
    on ( s1.cust_type = ct.cust_type )
 group by ct.txt, ct.cust_type;

show errors;

grant SELECT on V_EBKC_QUEUE_COUNT to BARSREADER_ROLE;
grant SELECT on V_EBKC_QUEUE_COUNT to BARS_ACCESS_DEFROLE;
