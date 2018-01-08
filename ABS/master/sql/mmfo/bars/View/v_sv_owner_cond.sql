

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_OWNER_COND.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_OWNER_COND ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_OWNER_COND ("ID", "CONDITION", "COND_DOC_NUM", "COND_DOC_DATE") AS 
  select o.id, o.condition, o.cond_doc_num, o.cond_doc_date
  from sv_owner o;

PROMPT *** Create  grants  V_SV_OWNER_COND ***
grant SELECT                                                                 on V_SV_OWNER_COND to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SV_OWNER_COND to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_OWNER_COND.sql =========*** End **
PROMPT ===================================================================================== 
