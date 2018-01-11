

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_GROUPS_PRIVATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_GROUPS_PRIVATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_GROUPS_PRIVATE ("ID", "NAME") AS 
  select id, name from EBKC_GROUPS
 where cust_type = 'P'
 order by id;

PROMPT *** Create  grants  V_EBKC_GROUPS_PRIVATE ***
grant SELECT                                                                 on V_EBKC_GROUPS_PRIVATE to BARSREADER_ROLE;
grant SELECT                                                                 on V_EBKC_GROUPS_PRIVATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_EBKC_GROUPS_PRIVATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_GROUPS_PRIVATE.sql =========*** 
PROMPT ===================================================================================== 
