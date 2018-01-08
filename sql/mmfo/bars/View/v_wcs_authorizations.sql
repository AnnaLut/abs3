

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_AUTHORIZATIONS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_AUTHORIZATIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_AUTHORIZATIONS ("AUTH_ID", "AUTH_NAME", "AUTH_DESC", "QUEST_CNT") AS 
  select a.id as auth_id,
       a.name as auth_name,
       a.id || ' - ' || a.name as auth_desc,
       (select count(*)
          from wcs_authorization_questions aq
         where aq.auth_id = a.id) as quest_cnt
  from wcs_authorizations a
 order by a.id;

PROMPT *** Create  grants  V_WCS_AUTHORIZATIONS ***
grant SELECT                                                                 on V_WCS_AUTHORIZATIONS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_AUTHORIZATIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_AUTHORIZATIONS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_AUTHORIZATIONS.sql =========*** E
PROMPT ===================================================================================== 
