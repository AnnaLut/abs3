

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_QUEUE_FORM_ALL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_QUEUE_FORM_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_QUEUE_FORM_ALL ("REPORT_DATE", "KF", "FILE_ID", "FILE_CODE", "FILE_TYPE", "FILE_NAME", "PERIOD", "TIME", "FIO", "STATUS") AS 
  SELECT L.REPORT_DATE,
          l.kf,
          l.id file_id,
          f.file_code,
          DECODE (f.FILE_TYPE, 1, 'Файл НБУ', 'Внутрішній')
             FILE_TYPE,
          f.FILE_NAME,
          P.DESCRIPTION period,
          TO_CHAR (ROUND (L.DATE_START, 'mi'), 'dd.mm.yyyy hh24:mi:ss') time,
          NVL (U.FIO,
               'Автоматичний процес формування'),
          DECODE (
             L.STATUS,
             0,    'Очікування (близько '
                || f_nbur_get_wait_time ((case when l.proc_type = 1 then 1
                                               when l.proc_type = 2 and f.PERIOD_TYPE in ('D', 'T') then 2
                                               else 3
                                          end))
                || ' хв.)',
             'Формування')
             status
     FROM NBUR_QUEUE_FORMS l,
          NBUR_REF_FILES f,
          NBUR_REF_PERIODS p,
          STAFF$BASE u
    WHERE     L.ID = F.ID
          AND F.PERIOD_TYPE = P.PERIOD_TYPE
          AND L.USER_ID = u.id(+)
          AND l.KF = SYS_CONTEXT ('bars_context', 'user_mfo');

PROMPT *** Create  grants  V_NBUR_QUEUE_FORM_ALL ***
grant SELECT                                                                 on V_NBUR_QUEUE_FORM_ALL to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_QUEUE_FORM_ALL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_QUEUE_FORM_ALL to RPBN002;
grant SELECT                                                                 on V_NBUR_QUEUE_FORM_ALL to START1;
grant SELECT                                                                 on V_NBUR_QUEUE_FORM_ALL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_QUEUE_FORM_ALL.sql =========*** 
PROMPT ===================================================================================== 
