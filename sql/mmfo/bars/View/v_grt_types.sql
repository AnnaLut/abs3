

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GRT_TYPES.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GRT_TYPES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GRT_TYPES ("TYPE_ID", "GROUP_ID", "TYPE_NAME", "GROUP_NAME") AS 
  select t.type_id, g.group_id, t.type_name, g.group_name
  from grt_types t, grt_groups g
 where t.group_id = g.group_id;

PROMPT *** Create  grants  V_GRT_TYPES ***
grant SELECT                                                                 on V_GRT_TYPES     to BARSREADER_ROLE;
grant SELECT                                                                 on V_GRT_TYPES     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_GRT_TYPES     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GRT_TYPES.sql =========*** End *** ==
PROMPT ===================================================================================== 
