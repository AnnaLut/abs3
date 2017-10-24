

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_LIST_ITEMS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_LIST_ITEMS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_LIST_ITEMS ("ID", "LIST_CODE", "LIST_ITEM_ID", "LIST_ITEM_CODE", "LIST_ITEM_NAME", "PARENT_LIST_ITEM_ID") AS 
  SELECT t.id
      ,t.list_code
      ,i.list_item_id
      ,i.list_item_code
      ,i.list_item_name
      ,i.parent_list_item_id
  FROM list_type t
  JOIN list_item i
    ON i.list_type_id = t.id
   AND i.is_active = 'Y'
 WHERE t.is_active = 'Y';

PROMPT *** Create  grants  V_LIST_ITEMS ***
grant SELECT                                                                 on V_LIST_ITEMS    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_LIST_ITEMS.sql =========*** End *** =
PROMPT ===================================================================================== 
