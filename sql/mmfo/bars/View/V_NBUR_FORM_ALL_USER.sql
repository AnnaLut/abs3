PROMPT View V_NBUR_FORM_ALL_USER;
CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_FORM_ALL_USER
(
   REPORT_DATE,
   KF,
   VERSION_ID,
   FILE_ID,
   FILE_CODE,
   FILE_TYPE,
   FILE_NAME,
   PERIOD,
   START_TIME,
   FINISH_TIME,
   FIO,
   RPT_DT,
   FILE_N,
   FILE_B
)
AS
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
          TO_CHAR (l.REPORT_DATE, 'DD/MM/YYYY') AS RPT_DT,
          L.FILE_NAME FILE_N,
          L.FILE_BODY FILE_B
     FROM BARS.NBUR_LST_FILES l
          JOIN BARS.NBUR_REF_FILES f ON (f.ID = l.FILE_ID)
          JOIN BARS.NBUR_REF_PERIODS p ON (p.PERIOD_TYPE = f.PERIOD_TYPE)
          LEFT JOIN BARS.STAFF$BASE u ON (u.ID = l.USER_ID)
    WHERE     l.FILE_STATUS in ('INVALID', 'FINISHED')
          AND (   f.FILE_CODE LIKE '@%'
               OR (f.FILE_CODE, f.SCHEME_CODE) IN (SELECT '#' || UPPER (KODF),
                                                          A017
                                                     FROM BARS.STAFF_KLF00
                                                    WHERE ID =
                                                             BARS.USER_ID ()));


Prompt Privs on VIEW V_NBUR_FORM_ALL_USER TO BARSREADER_ROLE to BARSREADER_ROLE;
GRANT SELECT ON BARS.V_NBUR_FORM_ALL_USER TO BARSREADER_ROLE;

Prompt Privs on VIEW V_NBUR_FORM_ALL_USER TO BARS_ACCESS_DEFROLE to BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_NBUR_FORM_ALL_USER TO BARS_ACCESS_DEFROLE;

Prompt Privs on VIEW V_NBUR_FORM_ALL_USER TO RPBN002 to RPBN002;
GRANT SELECT ON BARS.V_NBUR_FORM_ALL_USER TO RPBN002;

Prompt Privs on VIEW V_NBUR_FORM_ALL_USER TO START1 to START1;
GRANT SELECT ON BARS.V_NBUR_FORM_ALL_USER TO START1;

Prompt Privs on VIEW V_NBUR_FORM_ALL_USER TO UPLD to UPLD;
GRANT SELECT ON BARS.V_NBUR_FORM_ALL_USER TO UPLD;
