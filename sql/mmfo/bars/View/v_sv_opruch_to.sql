

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_OPRUCH_TO.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_OPRUCH_TO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_OPRUCH_TO ("ID", "FULL_NAME") AS 
  select o.id,
       o.nm1 || ' ' || o.nm2 || ' ' || o.nm3 full_name
  from sv_owner     o;

PROMPT *** Create  grants  V_SV_OPRUCH_TO ***
grant SELECT                                                                 on V_SV_OPRUCH_TO  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SV_OPRUCH_TO  to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_OPRUCH_TO.sql =========*** End ***
PROMPT ===================================================================================== 
