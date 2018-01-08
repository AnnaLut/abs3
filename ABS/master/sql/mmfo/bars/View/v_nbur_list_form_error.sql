

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FORM_ERROR.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_LIST_FORM_ERROR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_LIST_FORM_ERROR ("REPORT_DATE", "KF", "VERSION_ID", "FILE_ID", "FILE_CODE", "FILE_TYPE", "FILE_NAME", "PERIOD", "START_TIME", "FINISH_TIME", "STATUS", "FIO", "STATUS_CODE", "VIEW_NM", "FILE_FMT", "LST_ERRORS") AS 
  SELECT l.REPORT_DATE,
          l.KF,
          l.VERSION_ID,
          l.file_id,
          f.file_code,
          f.FILE_TYPE,
          f.FILE_NAME,
          p.DESCRIPTION period,
          TO_CHAR (l.START_TIME, 'DD/MM/YYYY HH24:MI:SS') AS START_TIME,
          TO_CHAR (l.FINISH_TIME, 'DD/MM/YYYY HH24:MI:SS') AS FINISH_TIME,          
          s.DESCRIPTION AS STATUS,
          NVL (u.FIO,
               'Автоматичний процес формування'),
          l.FILE_STATUS AS STATUS_CODE,
          f.VIEW_NM,
          f.FILE_FMT,
          'помилки' LST_ERRORS
     FROM NBUR_LST_FILES l
          JOIN NBUR_REF_FILES f ON (f.ID = l.FILE_ID)
          JOIN NBUR_REF_PERIODS p ON (p.PERIOD_TYPE = f.PERIOD_TYPE)
          JOIN NBUR_REF_STATUS s ON (s.STATUS_TYPE = l.FILE_STATUS)
          LEFT JOIN STAFF$BASE u ON (u.ID = l.USER_ID)
    WHERE l.FILE_STATUS IN ('ERROR');

PROMPT *** Create  grants  V_NBUR_LIST_FORM_ERROR ***
grant SELECT                                                                 on V_NBUR_LIST_FORM_ERROR to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_LIST_FORM_ERROR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_LIST_FORM_ERROR to RPBN002;
grant SELECT                                                                 on V_NBUR_LIST_FORM_ERROR to START1;
grant SELECT                                                                 on V_NBUR_LIST_FORM_ERROR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FORM_ERROR.sql =========***
PROMPT ===================================================================================== 
