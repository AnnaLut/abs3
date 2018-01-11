

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_OPRUCH_REL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_OPRUCH_REL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_OPRUCH_REL ("REL_ID", "ID", "OWNER_ID_FROM") AS 
  select r.id as rel_id,
       r.owner_id_to as id,
       r.owner_id_from
  from SV_OPRUCH_REL r
      ,SV_OWNER      o
 where r.owner_id_to = o.id;

PROMPT *** Create  grants  V_SV_OPRUCH_REL ***
grant SELECT                                                                 on V_SV_OPRUCH_REL to BARSREADER_ROLE;
grant SELECT                                                                 on V_SV_OPRUCH_REL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SV_OPRUCH_REL to RPBN002;
grant SELECT                                                                 on V_SV_OPRUCH_REL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_OPRUCH_REL.sql =========*** End **
PROMPT ===================================================================================== 
