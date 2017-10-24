

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_AUTHS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_AUTHS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_AUTHS ("SUBPRODUCT_ID", "AUTH_ID", "AUTH_NAME", "QUEST_CNT") AS 
  select sa.subproduct_id, sa.auth_id, a.auth_name, a.quest_cnt
  from wcs_subproduct_authorizations sa, v_wcs_authorizations a
 where sa.auth_id = a.auth_id;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_AUTHS ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_AUTHS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_AUTHS.sql =========***
PROMPT ===================================================================================== 
