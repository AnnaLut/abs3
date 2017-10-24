

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_OWNERDOC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_OWNERDOC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_OWNERDOC ("ID", "DOC_SER", "DOC_NUM", "DOC_DATE", "DOC_ORGAN", "BDATE", "DORG") AS 
  select id, ps_sr, ps_nm, ps_dt, ps_org, bdate, dorg
  from sv_owner;

PROMPT *** Create  grants  V_SV_OWNERDOC ***
grant SELECT                                                                 on V_SV_OWNERDOC   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SV_OWNERDOC   to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_OWNERDOC.sql =========*** End *** 
PROMPT ===================================================================================== 
