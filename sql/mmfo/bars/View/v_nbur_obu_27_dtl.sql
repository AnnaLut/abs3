

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_OBU_27_DTL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_OBU_27_DTL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_OBU_27_DTL ("REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE", "SEG_01", "SEG_02", "SEG_03", "SEG_04", "SEG_05", "FIELD_VALUE", "DESCRIPTION", "ACC_ID", "ACC_NUM", "KV", "MATURITY_DATE", "CUST_ID", "CUST_CODE", "CUST_NAME", "ND", "AGRM_NUM", "BEG_DT", "END_DT", "REF", "BRANCH") AS 
  select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.FIELD_CODE
     , SUBSTR(p.FIELD_CODE,1,2) as SEG_01
     , SUBSTR(p.FIELD_CODE,3,4) as SEG_02
     , SUBSTR(p.FIELD_CODE,7,2) as SEG_03
     , SUBSTR(p.FIELD_CODE,9,3) as SEG_04
     , SUBSTR(p.FIELD_CODE,12,1) as SEG_05
     , p.FIELD_VALUE
     , p.DESCRIPTION
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.MATURITY_DATE
     , p.CUST_ID
     , c.CUST_CODE
     , c.CUST_NAME
     , p.ND
     , a.AGRM_NUM
     , a.BEG_DT
     , a.END_DT
     , p.REF
     , p.BRANCH
  from NBUR_DETAIL_PROTOCOLS_ARCH p
  join NBUR_REF_FILES f
    on ( f.FILE_CODE = p.REPORT_CODE )
  join NBUR_LST_FILES v
    on ( v.REPORT_DATE = p.REPORT_DATE and
         v.KF          = p.KF          and
         v.VERSION_ID  = p.VERSION_ID  and
         v.FILE_ID     = f.ID )           
  left outer
  join V_NBUR_DM_CUSTOMERS c
    on ( p.REPORT_DATE = c.REPORT_DATE and
         p.KF          = c.KF          and
         p.CUST_ID    = c.CUST_ID )
  left outer
  join V_NBUR_DM_AGREEMENTS a
    on ( p.REPORT_DATE = a.REPORT_DATE and
         p.KF          = a.KF          and
         p.nd          = a.AGRM_ID )
 where p.REPORT_CODE = '@27'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );

PROMPT *** Create  grants  V_NBUR_OBU_27_DTL ***
grant SELECT                                                                 on V_NBUR_OBU_27_DTL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_OBU_27_DTL.sql =========*** End 
PROMPT ===================================================================================== 
