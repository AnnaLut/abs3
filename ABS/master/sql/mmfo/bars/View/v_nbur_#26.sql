

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#26.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_#26 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#26 ("REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE", "SEG_01", "SEG_02", "SEG_03", "SEG_04", "SEG_05", "SEG_06", "SEG_07", "SEG_08", "SEG_09", "SEG_10", "SEG_11", "FIELD_VALUE") AS 
  select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.FIELD_CODE
     , SUBSTR(p.FIELD_CODE,1,2) as SEG_01
     , SUBSTR(p.FIELD_CODE,3,3) as SEG_02
     , SUBSTR(p.FIELD_CODE,6,10) as SEG_03
     , SUBSTR(p.FIELD_CODE,16,4) as SEG_04
     , SUBSTR(p.FIELD_CODE,20,1) as SEG_05
     , SUBSTR(p.FIELD_CODE,21,1) as SEG_06
     , SUBSTR(p.FIELD_CODE,22,3) as SEG_07
     , SUBSTR(p.FIELD_CODE,25,1) as SEG_08
     , SUBSTR(p.FIELD_CODE,26,1) as SEG_09
     , SUBSTR(p.FIELD_CODE,27,1) as SEG_10
     , SUBSTR(p.FIELD_CODE,28,1) as SEG_11
     , p.FIELD_VALUE
  from NBUR_AGG_PROTOCOLS_ARCH p
  join NBUR_REF_FILES f
    on ( f.FILE_CODE = p.REPORT_CODE )
  join NBUR_LST_FILES v
    on ( v.REPORT_DATE = p.REPORT_DATE and
         v.KF          = p.KF          and
         v.VERSION_ID  = p.VERSION_ID  and
         v.FILE_ID     = f.ID )           
 where p.REPORT_CODE = '#26'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );

PROMPT *** Create  grants  V_NBUR_#26 ***
grant SELECT                                                                 on V_NBUR_#26      to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_#26      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_#26      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#26.sql =========*** End *** ===
PROMPT ===================================================================================== 
