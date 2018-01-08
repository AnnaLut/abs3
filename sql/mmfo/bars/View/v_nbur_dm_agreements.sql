

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_DM_AGREEMENTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_DM_AGREEMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_DM_AGREEMENTS ("REPORT_DATE", "KF", "AGRM_ID", "AGRM_NUM", "AGRM_TP", "AGRM_STE", "BEG_DT", "END_DT", "PRTFL_TP", "CCY_ID") AS 
  SELECT a.REPORT_DATE
     , a.KF
     , a.AGRM_ID
     , a.AGRM_NUM
     , a.AGRM_TP
     , a.AGRM_STE
     , a.BEG_DT
     , a.END_DT
     , a.PRTFL_TP
     , a.CCY_ID
  from NBUR_REF_OBJECTS o
  join NBUR_LST_OBJECTS v
    on ( v.OBJECT_ID = o.ID )
  join NBUR_DM_AGREEMENTS_ARCH a
    on ( a.REPORT_DATE = v.REPORT_DATE and
         a.KF          = v.KF          and
         a.VERSION_ID  = v.VERSION_ID  )
 where o.OBJECT_NAME = 'NBUR_DM_AGREEMENTS'
   and v.OBJECT_STATUS IN ( 'FINISHED', 'BLOCKED' )
;

PROMPT *** Create  grants  V_NBUR_DM_AGREEMENTS ***
grant SELECT                                                                 on V_NBUR_DM_AGREEMENTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_DM_AGREEMENTS.sql =========*** E
PROMPT ===================================================================================== 
