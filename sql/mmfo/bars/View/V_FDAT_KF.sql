

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FDAT_KF.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FDAT_KF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FDAT_KF ("KF", "CLOSSED") AS 
  select MV_KF.KF
     , nvl2( FDAT_KF.KF, 1, 0 ) as CLOSSED
  from MV_KF
  left outer
  join FDAT_KF
    on ( FDAT_KF.KF = MV_KF.KF )
;

PROMPT *** Create  grants  V_FDAT_KF ***
grant SELECT                                                                 on V_FDAT_KF       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FDAT_KF       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FDAT_KF.sql =========*** End *** ====
PROMPT ===================================================================================== 
