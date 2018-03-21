

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_SESSION_HISTORY.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_SESSION_HISTORY ***

CREATE OR REPLACE FORCE VIEW BARS.V_NBU_SESSION_HISTORY AS 
select * from nbu_gateway.v_nbu_session_history;

PROMPT *** Create  grants  V_NBU_SESSION_HISTORY ***
grant FLASHBACK,SELECT                                                       on V_NBU_SESSION_HISTORY to WR_REFREAD;

grant SELECT                                  on V_NBU_SESSION_HISTORY   to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_SESSION_HISTORY.sql =========*** 
PROMPT ===================================================================================== 
