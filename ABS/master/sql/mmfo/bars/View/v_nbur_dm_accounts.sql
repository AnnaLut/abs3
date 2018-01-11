

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_DM_ACCOUNTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_DM_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_DM_ACCOUNTS ("REPORT_DATE", "KF", "ACC_ID", "ACC_NUM", "ACC_NUM_ALT", "ACC_TYPE", "BRANCH", "KV", "OPEN_DATE", "CLOSE_DATE", "MATURITY_DATE", "CUST_ID", "LIMIT", "PAP", "NBS", "OB22", "R011", "R013", "S180", "S181", "S183", "S240") AS 
  SELECT a.REPORT_DATE
     , a.KF
     , a.ACC_ID
     , a.ACC_NUM
     , a.ACC_NUM_ALT
     , a.ACC_TYPE
     , a.BRANCH
     , a.KV
     , a.OPEN_DATE
     , a.CLOSE_DATE
     , a.MATURITY_DATE
     , a.CUST_ID
     , a.LIMIT
     , a.PAP
     , a.NBS
     , a.OB22
     , a.R011
     , a.R013
     , a.S180
     , a.S181
     , a.S183
     , a.S240
  from NBUR_REF_OBJECTS o
  join NBUR_LST_OBJECTS v
    on ( v.OBJECT_ID = o.ID )
  join NBUR_DM_ACCOUNTS_ARCH a
    on ( a.REPORT_DATE = v.REPORT_DATE and
         a.KF          = v.KF          and
         a.VERSION_ID  = v.VERSION_ID  )
 where o.OBJECT_NAME = 'NBUR_DM_ACCOUNTS'
   and v.OBJECT_STATUS IN ( 'FINISHED', 'BLOCKED' )
;

PROMPT *** Create  grants  V_NBUR_DM_ACCOUNTS ***
grant SELECT                                                                 on V_NBUR_DM_ACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_DM_ACCOUNTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_DM_ACCOUNTS to RPBN002;
grant SELECT                                                                 on V_NBUR_DM_ACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_DM_ACCOUNTS.sql =========*** End
PROMPT ===================================================================================== 
