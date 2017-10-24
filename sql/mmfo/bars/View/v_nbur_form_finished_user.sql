

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_FORM_FINISHED_USER.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_FORM_FINISHED_USER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_FORM_FINISHED_USER ("REPORT_DATE", "KF", "VERSION_ID", "FILE_ID", "FILE_CODE", "FILE_TYPE", "FILE_NAME", "PERIOD", "START_TIME", "FINISH_TIME", "FIO", "RPT_DT") AS 
  select l.REPORT_DATE,
       l.KF,
       l.VERSION_ID,
       l.FILE_ID,
       f.FILE_CODE,
       DECODE(f.FILE_TYPE, 1, 'Файл НБУ', 'Внутрішній') as FILE_TYPE,
       f.FILE_NAME,
       P.DESCRIPTION as PERIOD,
       to_char(l.START_TIME, 'DD/MM/YYYY HH24:MI:SS') as START_TIME,
       to_char(l.FINISH_TIME,'DD/MM/YYYY HH24:MI:SS') as FINISH_TIME,
       nvl(U.FIO,'Автоматичний процес формування') as FIO,
       to_char(l.REPORT_DATE,'DD/MM/YYYY') as RPT_DT
  from BARS.NBUR_LST_FILES l
  join BARS.NBUR_REF_FILES f
    on ( f.ID = l.FILE_ID )
  join BARS.NBUR_REF_PERIODS p
    on ( p.PERIOD_TYPE = f.PERIOD_TYPE )
  left
  join BARS.STAFF$BASE u
    on ( u.ID = l.USER_ID )
 where l.FILE_STATUS = 'FINISHED'
-- and l.START_TIME > trunc(SYSDATE)
   and ( f.FILE_CODE like '@%' OR (f.FILE_CODE,f.SCHEME_CODE) IN ( select '#'||upper(KODF), A017
                                                                     from BARS.STAFF_KLF00
                                                                    where ID = BARS.USER_ID() )
       );

PROMPT *** Create  grants  V_NBUR_FORM_FINISHED_USER ***
grant SELECT                                                                 on V_NBUR_FORM_FINISHED_USER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_FORM_FINISHED_USER to RPBN002;
grant SELECT                                                                 on V_NBUR_FORM_FINISHED_USER to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_FORM_FINISHED_USER.sql =========
PROMPT ===================================================================================== 
