

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENT_ACTIVITY.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_SEGMENT_ACTIVITY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_SEGMENT_ACTIVITY ("LIST_ITEM_ID", "LIST_ITEM_CODE", "LIST_ITEM_NAME") AS 
  select li.list_item_id, li.list_item_code, li.list_item_name
from   list_item li
where  li.list_type_id = (select id
                          from   list_type lt
                          where  lt.list_code = 'CUSTOMER_SEGMENT_ACTIVITY');

PROMPT *** Create  grants  V_CUSTOMER_SEGMENT_ACTIVITY ***
grant SELECT                                                                 on V_CUSTOMER_SEGMENT_ACTIVITY to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUSTOMER_SEGMENT_ACTIVITY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_SEGMENT_ACTIVITY to START1;
grant SELECT                                                                 on V_CUSTOMER_SEGMENT_ACTIVITY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_SEGMENT_ACTIVITY.sql =======
PROMPT ===================================================================================== 
