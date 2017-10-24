

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FORM_ALL.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_LIST_FORM_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_LIST_FORM_ALL ("REPORT_DATE", "KF", "VERSION_ID", "FILE_ID", "FILE_CODE", "FILE_TYPE", "FILE_NAME", "PERIOD", "START_TIME", "FINISH_TIME", "STATUS", "FIO", "STATUS_CODE") AS 
  SELECT L.REPORT_DATE,
          l.kf,
          L.VERSION_ID,
          l.file_id,
          f.file_code,
          f.FILE_TYPE,
          f.FILE_NAME,
          P.DESCRIPTION period,
          round(L.START_TIME, 'mi') START_TIME,
          round(L.FINISH_TIME, 'mi') FINISH_TIME,
          S.DESCRIPTION status,
          nvl(U.FIO, 'Автоматичний процес формування'),
          L.FILE_STATUS status_code
     FROM NBUR_LST_FILES l,
          NBUR_REF_FILES f,
          NBUR_REF_PERIODS p,
          NBUR_REF_STATUS s,
          STAFF$BASE u
    WHERE     L.FILE_ID = F.ID
          AND L.FILE_STATUS = S.STATUS_TYPE
          AND F.PERIOD_TYPE = P.PERIOD_TYPE
          AND L.USER_ID = u.id(+);

PROMPT *** Create  grants  V_NBUR_LIST_FORM_ALL ***
grant SELECT                                                                 on V_NBUR_LIST_FORM_ALL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_LIST_FORM_ALL to RPBN002;
grant SELECT                                                                 on V_NBUR_LIST_FORM_ALL to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FORM_ALL.sql =========*** E
PROMPT ===================================================================================== 
