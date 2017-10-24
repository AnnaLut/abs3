

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_EBKC_GROUPS_LEGAL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_EBKC_GROUPS_LEGAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_GROUPS_LEGAL ("ID", "NAME") AS 
  select id, name from EBKC_GROUPS
 where cust_type = 'L'
 order by id;

PROMPT *** Create  grants  V_EBKC_GROUPS_LEGAL ***
grant SELECT                                                                 on V_EBKC_GROUPS_LEGAL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_EBKC_GROUPS_LEGAL.sql =========*** En
PROMPT ===================================================================================== 
