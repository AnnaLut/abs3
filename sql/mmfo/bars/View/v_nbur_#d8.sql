

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#D8.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_#D8 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#D8 ("REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE", "SEG_01", "SEG_02", "SEG_03", "SEG_04", "SEG_05", "SEG_06", "SEG_07", "SEG_08", "SEG_09", "FIELD_VALUE") AS 
  select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.FIELD_CODE
     , SUBSTR(p.FIELD_CODE,1,3) as SEG_01
     , SUBSTR(p.FIELD_CODE,4,10) as SEG_02
     , SUBSTR(p.FIELD_CODE,14,4) as SEG_03
     , SUBSTR(p.FIELD_CODE,18,4) as SEG_04
     , SUBSTR(p.FIELD_CODE,22,3) as SEG_05
     , SUBSTR(p.FIELD_CODE,25,2) as SEG_06
     , SUBSTR(p.FIELD_CODE,27,1) as SEG_07
     , SUBSTR(p.FIELD_CODE,28,1) as SEG_08
     , SUBSTR(p.FIELD_CODE,29,2) as SEG_09
     , p.FIELD_VALUE
  from NBUR_AGG_PROTOCOLS_ARCH p
  join NBUR_REF_FILES f
    on ( f.FILE_CODE = p.REPORT_CODE )
  join NBUR_LST_FILES v
    on ( v.REPORT_DATE = p.REPORT_DATE and
         v.KF          = p.KF          and
         v.VERSION_ID  = p.VERSION_ID  and
         v.FILE_ID     = f.ID )           
 where p.REPORT_CODE = '#D8'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );

PROMPT *** Create  grants  V_NBUR_#D8 ***
grant SELECT                                                                 on V_NBUR_#D8      to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_#D8      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_#D8      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#D8.sql =========*** End *** ===
PROMPT ===================================================================================== 
