

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_2FX_DTL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_2FX_DTL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_2FX_DTL ("REPORT_DATE", "KF", "NBUC", "VERSION_ID", "FIELD_CODE", "EKP", "D110", "K014", "K019", "K030", "K040", "K044", "KU", "R030", "T070_1", "T070_2", "T100", "DESCRIPTION", "ACC_ID", "ACC_NUM", "KV", "CUST_ID", "CUST_CODE", "CUST_NAME", "REF", "BRANCH") AS 
  select p.REPORT_DATE
        ,p.KF
        ,p.NBUC
        ,V.VERSION_ID
        ,P.EKP||'|'||P.D110||'|'||P.K014||'|'||P.K019||'|'||
         P.K030||'|'||P.K040||'|'||P.K044||'|'||P.KU||'|'||P.R030 as FIELD_CODE
        ,P.EKP
        ,P.D110
        ,P.K014
        ,P.K019
        ,P.K030
        ,P.K040
        ,P.K044
        ,P.KU
        ,P.R030
        ,P.T070_1
        ,P.T070_2
        ,P.T100
        ,P.DESCRIPTION
        ,p.ACC_ID
        ,p.ACC_NUM
        ,p.KV
        ,p.CUST_ID
        ,c.OKPO CUST_CODE
        ,c.NMK  CUST_NAME
        ,p.REF
        ,p.BRANCH
    from NBUR_LOG_F2FX P
    join NBUR_REF_FILES f
      on f.FILE_CODE = '2FX'
    join NBUR_LST_FILES V
      on v.REPORT_DATE = p.REPORT_DATE
     and v.KF = p.KF
     and v.VERSION_ID = p.VERSION_ID
     and v.FILE_ID = f.ID
     left join customer c
      on p.KF = c.KF
     and p.CUST_ID = c.RNK
    where v.FILE_STATUS IN ( 'FINISHED', 'BLOCKED' )
;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_2FX_DTL.sql =========*** End ***
PROMPT ===================================================================================== 
