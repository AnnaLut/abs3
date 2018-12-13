PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_#Z7_TMP_DTL.sql =========*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  view V_NBUR_#Z7_TMP_DTL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_#Z7_TMP_DTL 
  ("SEG_01", "SEG_02", "SEG_03", "SEG_04", "SEG_05", 
   "SEG_06", "SEG_07", "SEG_08", "SEG_09", "FIELD_VALUE", 
   "DESCRIPTION", "ACC_ID", "ACC_NUM", "KV", "MATURITY_DATE", 
   "CUST_ID", "ND", "BRANCH", "K040", "CUST_TYPE", 
   "K070", "BLC_CODE_DB", "BLC_CODE_CR", "ACC_TYPE") AS 
  select SUBSTR(p.KODP,1,1) as SEG_01
     , SUBSTR(p.KODP,2,4) as SEG_02
     , SUBSTR(p.KODP,6,1) as SEG_03
     , SUBSTR(p.KODP,7,1) as SEG_04
     , SUBSTR(p.KODP,8,1) as SEG_05
     , SUBSTR(p.KODP,9,1) as SEG_06
     , SUBSTR(p.KODP,10,1) as SEG_07
     , SUBSTR(p.KODP,11,1) as SEG_08
     , SUBSTR(p.KODP,12,3) as SEG_09
     , p.ZNAP
     , p.COMM
     , p.ACC
     , p.NLS
     , p.KV
     , p.MDATE
     , p.RNK
     , p.ND
     , p.TOBO
     , lpad(NVL(to_char(c.country),'804'), 3, '0') as k040
     , nvl(c.custtype, 0) as cust_type
     , nvl(c.ise,'00000') as k070
     , a.blkd as blc_code_db
     , a.blkk as blc_code_cr
     , a.tip as acc_type     
  from RNBU_TRACE p
  LEFT OUTER JOIN CUSTOMER c
    on ( p.RNK     = c.RNK )
  LEFT OUTER JOIN ACCOUNTS a
    on ( p.ACC     =  a.ACC );

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_#Z7_TMP_DTL.sql =========*** End ***
PROMPT ===================================================================================== 
