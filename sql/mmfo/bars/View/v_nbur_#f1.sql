

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#F1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_#F1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#F1 ("REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE", "SEG_01", "SEG_02", "SEG_03", "SEG_04", "SEG_05", "SEG_06", "FIELD_VALUE", "ERROR_MSG", "ADJ_IND") AS 
  select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.FIELD_CODE
     , SUBSTR(p.FIELD_CODE,1,1) as SEG_01
     , SUBSTR(p.FIELD_CODE,2,2) as SEG_02
     , SUBSTR(p.FIELD_CODE,4,1) as SEG_03
     , SUBSTR(p.FIELD_CODE,5,3) as SEG_04
     , SUBSTR(p.FIELD_CODE,8,3) as SEG_05
     , SUBSTR(NBUC,1,12) as SEG_06
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
 where p.REPORT_CODE = '#F1'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );

PROMPT *** Create  grants  V_NBUR_#F1 ***
grant SELECT                                                                 on V_NBUR_#F1      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#F1.sql =========*** End *** ===
PROMPT ===================================================================================== 
