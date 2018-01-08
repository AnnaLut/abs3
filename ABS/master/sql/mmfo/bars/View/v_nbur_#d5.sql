

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#D5.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_#D5 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#D5 ("REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE", "SEG_01", "SEG_02", "SEG_03", "SEG_04", "SEG_05", "SEG_06", "SEG_07", "SEG_08", "SEG_09", "SEG_10", "SEG_11", "SEG_12", "SEG_13", "SEG_14", "SEG_15", "SEG_16", "SEG_17", "FIELD_VALUE") AS 
  select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.FIELD_CODE
     , SUBSTR(p.FIELD_CODE,1,1) as SEG_01
     , SUBSTR(p.FIELD_CODE,2,1) as SEG_02
     , SUBSTR(p.FIELD_CODE,3,4) as SEG_03
     , SUBSTR(p.FIELD_CODE,7,1) as SEG_04
     , SUBSTR(p.FIELD_CODE,8,2) as SEG_05
     , SUBSTR(p.FIELD_CODE,10,1) as SEG_06
     , SUBSTR(p.FIELD_CODE,11,1) as SEG_07
     , SUBSTR(p.FIELD_CODE,12,1) as SEG_08
     , SUBSTR(p.FIELD_CODE,13,1) as SEG_09
     , SUBSTR(p.FIELD_CODE,14,2) as SEG_10
     , SUBSTR(p.FIELD_CODE,16,1) as SEG_11
     , SUBSTR(p.FIELD_CODE,17,3) as SEG_12
     , SUBSTR(p.FIELD_CODE,20,3) as SEG_13
     , SUBSTR(p.FIELD_CODE,23,1) as SEG_14
     , SUBSTR(p.FIELD_CODE,24,2) as SEG_15
     , SUBSTR(p.FIELD_CODE,26,1) as SEG_16
     , SUBSTR(p.FIELD_CODE,27,1) as SEG_17
     , p.FIELD_VALUE
  from NBUR_AGG_PROTOCOLS_ARCH p
  join NBUR_REF_FILES f
    on ( f.FILE_CODE = p.REPORT_CODE )
  join NBUR_LST_FILES v
    on ( v.REPORT_DATE = p.REPORT_DATE and
         v.KF          = p.KF          and
         v.VERSION_ID  = p.VERSION_ID  and
         v.FILE_ID     = f.ID )           
 where p.REPORT_CODE = '#D5'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );

PROMPT *** Create  grants  V_NBUR_#D5 ***
grant SELECT                                                                 on V_NBUR_#D5      to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_#D5      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_#D5      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#D5.sql =========*** End *** ===
PROMPT ===================================================================================== 
