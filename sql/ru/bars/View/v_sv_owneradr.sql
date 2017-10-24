

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SV_OWNERADR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SV_OWNERADR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SV_OWNERADR ("ID", "COD_KR", "INDX", "PUNKT", "UL", "BUD", "KORP", "OFF") AS 
  select id, cod_kr, indx, punkt, ul, bud, korp, off
  from sv_owner;

PROMPT *** Create  grants  V_SV_OWNERADR ***
grant SELECT                                                                 on V_SV_OWNERADR   to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SV_OWNERADR.sql =========*** End *** 
PROMPT ===================================================================================== 
