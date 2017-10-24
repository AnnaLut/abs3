

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#D9.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_#D9 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#D9 ("REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE", "SEG_01", "SEG_02", "SEG_03", "SEG_04", "SEG_05", "FIELD_VALUE", "ERROR_MSG", "ADJ_IND") AS 
  select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.FIELD_CODE
     , SUBSTR(p.FIELD_CODE,1,3) as SEG_01
     , SUBSTR(p.FIELD_CODE,4,10) as SEG_02
     , SUBSTR(p.FIELD_CODE,14,10) as SEG_03
     , SUBSTR(p.FIELD_CODE,25,1) as SEG_04
     , SUBSTR(p.FIELD_CODE,26,1) as SEG_05
     , p.FIELD_VALUE
     , p.ERROR_MSG
     , p.ADJ_IND
  from NBUR_AGG_PROTOCOLS_ARCH p
  join NBUR_REF_FILES f
    on ( f.FILE_CODE = p.REPORT_CODE )
  join NBUR_LST_FILES v
    on ( v.REPORT_DATE = p.REPORT_DATE and
         v.KF          = p.KF          and
         v.VERSION_ID  = p.VERSION_ID  and
         v.FILE_ID     = f.ID )           
 where p.REPORT_CODE = '#D9'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );

PROMPT *** Create  grants  V_NBUR_#D9 ***
grant SELECT                                                                 on V_NBUR_#D9      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#D9.sql =========*** End *** ===
PROMPT ===================================================================================== 
