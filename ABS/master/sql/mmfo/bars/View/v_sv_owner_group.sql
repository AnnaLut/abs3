

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_OWNER_GROUP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_OWNER_GROUP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_OWNER_GROUP ("ID", "GROUP_ID", "GROUP_REASON", "GROUP_DOC_NUM", "GROUP_DOC_DATE") AS 
  select o.id, o.group_id, o.group_reason, o.group_doc_num, o.group_doc_date
  from sv_owner o;

PROMPT *** Create  grants  V_SV_OWNER_GROUP ***
grant SELECT                                                                 on V_SV_OWNER_GROUP to BARSREADER_ROLE;
grant SELECT                                                                 on V_SV_OWNER_GROUP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SV_OWNER_GROUP to RPBN002;
grant SELECT                                                                 on V_SV_OWNER_GROUP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_OWNER_GROUP.sql =========*** End *
PROMPT ===================================================================================== 
