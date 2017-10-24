

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FORM_ACCESSED.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_LIST_FORM_ACCESSED ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_LIST_FORM_ACCESSED ("REPORT_DATE", "KF", "VERSION_ID", "FILE_ID", "FILE_CODE", "SCHEME_CODE", "FILE_TYPE", "FILE_NAME", "PERIOD", "START_TIME", "FINISH_TIME", "STATUS", "FIO", "STATUS_CODE") AS 
  SELECT l.report_date,
          l.kf,
          l.version_id,
          l.file_id,
          f.file_code,
          f.scheme_code,
          f.file_type,
          f.file_name,
          p.description period,
          round(l.start_time, 'mi') start_time,
          round(l.finish_time, 'mi') finish_time,
          s.description status,
          nvl(u.fio, 'Автоматичний процес формування'),
          L.FILE_STATUS status_code
     FROM NBUR_LST_FILES l,
          NBUR_REF_FILES f,
          NBUR_REF_PERIODS p,
          NBUR_REF_STATUS s,
          STAFF$BASE u
    WHERE L.FILE_ID = F.ID
      AND L.FILE_STATUS = S.STATUS_TYPE
      AND F.PERIOD_TYPE = P.PERIOD_TYPE
      AND L.USER_ID = u.id(+)
      and l.file_status in ('FINISHED', 'INVALID', 'BLOCKED');

PROMPT *** Create  grants  V_NBUR_LIST_FORM_ACCESSED ***
grant SELECT                                                                 on V_NBUR_LIST_FORM_ACCESSED to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_LIST_FORM_ACCESSED to RPBN002;
grant SELECT                                                                 on V_NBUR_LIST_FORM_ACCESSED to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FORM_ACCESSED.sql =========
PROMPT ===================================================================================== 
