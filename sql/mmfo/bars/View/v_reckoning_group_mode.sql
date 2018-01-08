

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RECKONING_GROUP_MODE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RECKONING_GROUP_MODE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RECKONING_GROUP_MODE ("ID", "CODE", "NAME") AS 
  select li.list_item_id id, li.list_item_code code, li.list_item_name name
from   list_item li
join   list_type lt on lt.id = li.list_type_id
where  lt.list_code = 'RECKONING_GROUPING_MODE' and
       li.is_active = 'Y';

PROMPT *** Create  grants  V_RECKONING_GROUP_MODE ***
grant SELECT                                                                 on V_RECKONING_GROUP_MODE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RECKONING_GROUP_MODE.sql =========***
PROMPT ===================================================================================== 
