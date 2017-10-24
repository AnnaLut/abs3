

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_QUEUE_FORM_ALL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_QUEUE_FORM_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_QUEUE_FORM_ALL ("REPORT_DATE", "KF", "FILE_ID", "FILE_CODE", "FILE_TYPE", "FILE_NAME", "PERIOD", "TIME", "FIO", "STATUS") AS 
  SELECT L.REPORT_DATE,
          l.kf,
          l.id file_id,
          f.file_code,
          decode(f.FILE_TYPE, 1, 'Файл НБУ','Внутрішній') FILE_TYPE,
          f.FILE_NAME,
          P.DESCRIPTION period,
          to_char(ROUND (L.DATE_START, 'mi'), 'dd.mm.yyyy hh24:mi:ss') time,
          nvl(U.FIO, 'Автоматичний процес формування'),
          decode(L.STATUS, 0, 'Очікування (близько '||
                           decode(l.proc_type, 1, f_nbur_get_wait_time(1),
                                     f_nbur_get_wait_time(2)) || ' хв.)'
                   , 'Формування') status 
     FROM NBUR_QUEUE_FORMS l,
          NBUR_REF_FILES f,
          NBUR_REF_PERIODS p,
          STAFF$BASE u
    WHERE L.ID = F.ID 
      AND F.PERIOD_TYPE = P.PERIOD_TYPE 
      AND L.USER_ID = u.id(+)
      and l.KF = sys_context('bars_context','user_mfo');

PROMPT *** Create  grants  V_NBUR_QUEUE_FORM_ALL ***
grant SELECT                                                                 on V_NBUR_QUEUE_FORM_ALL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_QUEUE_FORM_ALL to RPBN002;
grant SELECT                                                                 on V_NBUR_QUEUE_FORM_ALL to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_QUEUE_FORM_ALL.sql =========*** 
PROMPT ===================================================================================== 
