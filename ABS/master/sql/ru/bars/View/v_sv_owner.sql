

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_OWNER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_OWNER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_OWNER ("ID", "NM1", "NM2", "NM3", "TYPE", "COD", "OZN", "POS", "DOC", "ADR", "UCH") AS 
  select id, nm1, nm2, nm3, type, cod, ozn, pos,
       'Документ' doc, 'Адреса' adr, 'Участь' uch
from sv_owner;

PROMPT *** Create  grants  V_SV_OWNER ***
grant SELECT                                                                 on V_SV_OWNER      to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_OWNER.sql =========*** End *** ===
PROMPT ===================================================================================== 
