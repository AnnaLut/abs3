

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#F4_DTL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_#F4_DTL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#F4_DTL ("REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE", "SEG_01", "SEG_02", "SEG_03", "SEG_04", "SEG_05", "SEG_06", "SEG_07", "SEG_08", "SEG_09", "SEG_10", "SEG_11", "FIELD_VALUE", "DESCRIPTION", "ACC_ID", "ACC_NUM", "KV", "MATURITY_DATE", "CUST_ID", "CUST_CODE", "CUST_NAME", "ND", "AGRM_NUM", "BEG_DT", "END_DT", "REF", "BRANCH") AS 
  select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.FIELD_CODE
     , SUBSTR(p.FIELD_CODE,1,1) as SEG_01
     , SUBSTR(p.FIELD_CODE,2,1) as SEG_02
     , SUBSTR(p.FIELD_CODE,3,4) as SEG_03
     , SUBSTR(p.FIELD_CODE,7,1) as SEG_04
     , SUBSTR(p.FIELD_CODE,8,1) as SEG_05
     , SUBSTR(p.FIELD_CODE,9,2) as SEG_06
     , SUBSTR(p.FIELD_CODE,11,1) as SEG_07
     , SUBSTR(p.FIELD_CODE,12,1) as SEG_08
     , SUBSTR(p.FIELD_CODE,13,2) as SEG_09
     , SUBSTR(p.FIELD_CODE,15,3) as SEG_10
     , SUBSTR(p.FIELD_CODE,18,1) as SEG_11
     , p.FIELD_VALUE
     , p.DESCRIPTION
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.MATURITY_DATE
     , p.CUST_ID
     , c.OKPO CUST_CODE
     , c.NMK  CUST_NAME
     , p.ND
     , a.CC_ID AGRM_NUM
     , a.SDATE BEG_DT
     , a.WDATE END_DT
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
  LEFT OUTER JOIN CUSTOMER c
    on ( p.KF          = c.KF          and
         p.CUST_ID     = c.RNK )
  LEFT OUTER JOIN CC_DEAL a 
    on ( p.KF          = a.KF          and
         p.nd          = a.ND )
 where p.REPORT_CODE = '#F4'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );

PROMPT *** Create  grants  V_NBUR_#F4_DTL ***
grant SELECT                                                                 on V_NBUR_#F4_DTL  to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_#F4_DTL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_#F4_DTL  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#F4_DTL.sql =========*** End ***
PROMPT ===================================================================================== 
