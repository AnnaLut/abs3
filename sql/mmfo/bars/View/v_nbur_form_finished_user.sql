

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_FORM_FINISHED_USER.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_FORM_FINISHED_USER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_FORM_FINISHED_USER ("REPORT_DATE", "KF", "VERSION_ID", "FILE_ID", "FILE_CODE", "FILE_TYPE", "FILE_NAME", "PERIOD", "START_TIME", "FINISH_TIME", "FIO", "RPT_DT") AS 
  SELECT l.REPORT_DATE,
          l.KF,
          l.VERSION_ID,
          l.FILE_ID,
          f.FILE_CODE,
          DECODE (f.FILE_TYPE, 1, 'Файл НБУ', 'Внутрішній')
             AS FILE_TYPE,
          f.FILE_NAME,
          P.DESCRIPTION AS PERIOD,
          TO_CHAR (l.START_TIME, 'DD/MM/YYYY HH24:MI:SS') AS START_TIME,
          TO_CHAR (l.FINISH_TIME, 'DD/MM/YYYY HH24:MI:SS') AS FINISH_TIME,
          NVL (U.FIO,
               'Автоматичний процес формування')
             AS FIO,
          TO_CHAR (l.REPORT_DATE, 'DD/MM/YYYY') AS RPT_DT
     FROM BARS.NBUR_LST_FILES l
          JOIN BARS.NBUR_REF_FILES f
             ON (f.ID = l.FILE_ID)
          JOIN BARS.NBUR_REF_PERIODS p
             ON (p.PERIOD_TYPE = f.PERIOD_TYPE)
          LEFT JOIN BARS.STAFF$BASE u
             ON (u.ID = l.USER_ID)
    WHERE     l.FILE_STATUS = 'FINISHED'
          -- and l.START_TIME > trunc(SYSDATE)
          AND (   f.FILE_CODE LIKE '@%'
               OR (f.FILE_CODE, f.SCHEME_CODE) IN
                     (SELECT '#' || UPPER (KODF), A017
                        FROM BARS.STAFF_KLF00
                       WHERE ID = BARS.USER_ID ()));

PROMPT *** Create  grants  V_NBUR_FORM_FINISHED_USER ***
grant SELECT                                                                 on V_NBUR_FORM_FINISHED_USER to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_FORM_FINISHED_USER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_FORM_FINISHED_USER to RPBN002;
grant SELECT                                                                 on V_NBUR_FORM_FINISHED_USER to START1;
grant SELECT                                                                 on V_NBUR_FORM_FINISHED_USER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_FORM_FINISHED_USER.sql =========
PROMPT ===================================================================================== 
