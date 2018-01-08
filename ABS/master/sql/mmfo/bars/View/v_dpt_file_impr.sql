

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_FILE_IMPR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_FILE_IMPR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_FILE_IMPR ("KF", "FILE_DT", "FILE_TP", "FILE_QTY", "USR_ID") AS 
  select fh.KF
     , fh.DAT              as FILE_DT
     , fh.TYPE_ID          as FILE_TP
     , count(fh.HEADER_ID) as FILE_QTY
     , fh.USR_ID
  from DPT_FILE_HEADER fh
 where fh.KF = sys_context('bars_context','user_mfo')
   and fh.DAT >= add_months(trunc(sysdate,'MM'),-6)
   and fh.TYPE_ID in ( 1, 2 )
   and fh.USR_ID = USER_ID
 group by fh.KF, fh.DAT, fh.USR_ID, fh.TYPE_ID;

PROMPT *** Create  grants  V_DPT_FILE_IMPR ***
grant SELECT                                                                 on V_DPT_FILE_IMPR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_FILE_IMPR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_FILE_IMPR.sql =========*** End **
PROMPT ===================================================================================== 
