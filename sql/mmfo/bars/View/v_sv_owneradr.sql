

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_OWNERADR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_OWNERADR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_OWNERADR ("ID", "COD_KR", "INDX", "PUNKT", "PUNKT_UA", "UL", "UL_UA", "BUD", "KORP", "OFF") AS 
  select o.id, o.cod_kr, o.indx, o.punkt, o.punkt_ua, o.ul, o.ul_ua, o.bud, o.korp, o.off
  from sv_owner o;

PROMPT *** Create  grants  V_SV_OWNERADR ***
grant SELECT                                                                 on V_SV_OWNERADR   to BARSREADER_ROLE;
grant SELECT                                                                 on V_SV_OWNERADR   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SV_OWNERADR   to RPBN002;
grant SELECT                                                                 on V_SV_OWNERADR   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_OWNERADR.sql =========*** End *** 
PROMPT ===================================================================================== 
