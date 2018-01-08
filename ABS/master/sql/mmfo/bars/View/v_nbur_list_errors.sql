

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_ERRORS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_LIST_ERRORS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_LIST_ERRORS ("REPORT_DATE", "KF", "REPORT_CODE", "VERSION_ID", "ERROR_ID", "ERROR_TXT", "USERID", "FILE_ID", "NPP") AS 
  SELECT a."REPORT_DATE",
          a."KF",
          a."REPORT_CODE",
          a."VERSION_ID",
          a."ERROR_ID",
          a."ERROR_TXT",
          a."USERID",
          a."FILE_ID",
          DENSE_RANK() over (partition by REPORT_DATE, KF, REPORT_CODE, VERSION_ID order by REPORT_DATE, KF, REPORT_CODE, VERSION_ID) npp
     FROM (  SELECT s.*
               FROM NBUR_LST_ERRORS s
           ORDER BY 1,
                    2,
                    3,
                    4,
                    5) a;

PROMPT *** Create  grants  V_NBUR_LIST_ERRORS ***
grant SELECT                                                                 on V_NBUR_LIST_ERRORS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_ERRORS.sql =========*** End
PROMPT ===================================================================================== 
