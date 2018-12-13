PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#Z7_DTL.sql =========*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  view V_NBUR_#Z7_DTL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#Z7_DTL 
  ("REPORT_DATE", "KF", "VERSION_ID", "NBUC", "FIELD_CODE",
   "SEG_01", "SEG_02", "SEG_03", "SEG_04", "SEG_05", 
   "SEG_06", "SEG_07", "SEG_08", "SEG_09", "FIELD_VALUE", 
   "DESCRIPTION", "ACC_ID", "ACC_NUM", "KV", "MATURITY_DATE", 
   "CUST_ID", "ND", "BRANCH", "K040", "CUST_TYPE", 
   "K070", "BLC_CODE_DB", "BLC_CODE_CR", "ACC_TYPE") AS 
  select p.REPORT_DATE
     , p.KF
     , p.VERSION_ID
     , p.NBUC
     , p.FIELD_CODE
     , SUBSTR(p.FIELD_CODE,1,1) as SEG_01
     , SUBSTR(p.FIELD_CODE,2,4) as SEG_02
     , SUBSTR(p.FIELD_CODE,6,1) as SEG_03
     , SUBSTR(p.FIELD_CODE,7,1) as SEG_04
     , SUBSTR(p.FIELD_CODE,8,1) as SEG_05
     , SUBSTR(p.FIELD_CODE,9,1) as SEG_06
     , SUBSTR(p.FIELD_CODE,10,1) as SEG_07
     , SUBSTR(p.FIELD_CODE,11,1) as SEG_08
     , SUBSTR(p.FIELD_CODE,12,3) as SEG_09
     , p.FIELD_VALUE
     , p.DESCRIPTION
     , p.ACC_ID
     , p.ACC_NUM
     , p.KV
     , p.MATURITY_DATE
     , p.CUST_ID
     , p.ND
     , p.BRANCH
     , lpad(NVL(to_char(c.country),'804'), 3, '0') as k040
     , nvl(c.custtype, 0) as cust_type
     , nvl(c.ise,'00000') as k070
     , a.blkd as blc_code_db
     , a.blkk as blc_code_cr
     , a.tip as acc_type     
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
  LEFT OUTER JOIN ACCOUNTS a
    on ( p.KF          = a.KF          and
         p.ACC_ID     =  a.ACC )
 where p.REPORT_CODE = '#A7'
   and v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' );

PROMPT *** Create  grants  V_NBUR_#A7_DTL ***
grant SELECT                                                                 on V_NBUR_#A7_DTL  to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_#A7_DTL  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_#A7_DTL  to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#Z7_DTL.sql =========*** End ***
PROMPT ===================================================================================== 
