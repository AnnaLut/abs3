

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_OWNER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_OWNER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_OWNER ("ID", "NM1", "NM2", "NM3", "NM_UA", "TYPE", "COD", "OZN", "OWNER_OZN", "NAT", "POS", "REL_TYPE", "NBU_DOC_NUM", "NBU_DOC_DATE", "DOC", "ADR", "UCH", "OPRUCH", "OWNER_GROUP", "CONDITION", "VOICE", "MANAGER") AS 
  select o.id, o.nm1, o.nm2, o.nm3, o.nm_ua, o.type, o.cod, o.ozn, o.owner_ozn, o.nat, o.pos, o.rel_type,
       o.nbu_doc_num, o.nbu_doc_date,
       'Документ' doc, 'Адреса' adr, 'Участь' uch, 'Опосередкована участь' opruch,
       'Належить до групи' owner_group,
       'Обставини вирішального впливу' condition, 'Передані голоси' voice, 'Керівник' manager
from sv_owner o;

PROMPT *** Create  grants  V_SV_OWNER ***
grant SELECT                                                                 on V_SV_OWNER      to BARSREADER_ROLE;
grant SELECT                                                                 on V_SV_OWNER      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SV_OWNER      to RPBN002;
grant SELECT                                                                 on V_SV_OWNER      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_OWNER.sql =========*** End *** ===
PROMPT ===================================================================================== 
