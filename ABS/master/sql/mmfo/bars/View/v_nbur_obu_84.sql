

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_OBU_84.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_OBU_84 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_OBU_84 ("REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE", "SEG_01", "FIELD_VALUE") AS 
  select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.FIELD_CODE
     , SUBSTR(p.FIELD_CODE,1,2) as SEG_01
     , p.FIELD_VALUE
  from NBUR_AGG_PROTOCOLS_ARCH p
  join NBUR_REF_FILES f
    on ( f.FILE_CODE = p.REPORT_CODE )
  join NBUR_LST_FILES v
    on ( v.REPORT_DATE = p.REPORT_DATE and
         v.KF          = p.KF          and
         v.VERSION_ID  = p.VERSION_ID  and
         v.FILE_ID     = f.ID )           
 where p.REPORT_CODE = '@84'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );

PROMPT *** Create  grants  V_NBUR_OBU_84 ***
grant SELECT                                                                 on V_NBUR_OBU_84   to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_OBU_84   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_OBU_84   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_OBU_84.sql =========*** End *** 
PROMPT ===================================================================================== 
