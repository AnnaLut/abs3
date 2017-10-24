

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_VOICE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_VOICE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_VOICE ("VOICE_ID", "ID", "OWNER_ID_FROM", "DOC_NUM", "DOC_DATE", "OWNER_NAME_FROM") AS 
  select v.id as voice_id,
       v.owner_id_to as id,
       v.owner_id_from,
       v.doc_num,
       v.doc_date,
       o.nm1 || ' ' || o.nm2 || ' ' || o.nm3   owner_name_from
  from SV_VOICE      v
      ,SV_OWNER      o
 where v.owner_id_to = o.id;

PROMPT *** Create  grants  V_SV_VOICE ***
grant SELECT                                                                 on V_SV_VOICE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SV_VOICE      to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_VOICE.sql =========*** End *** ===
PROMPT ===================================================================================== 
