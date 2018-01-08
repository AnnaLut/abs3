

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FORM_FINISHED.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_LIST_FORM_FINISHED ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_LIST_FORM_FINISHED ("REPORT_DATE", "KF", "VERSION_ID", "FILE_ID", "FILE_CODE", "FILE_TYPE", "FILE_NAME", "PERIOD", "START_TIME", "FINISH_TIME", "STATUS", "FIO", "STATUS_CODE", "VIEW_NM", "FILE_FMT") AS 
  SELECT l.REPORT_DATE,
          l.KF,
          l.VERSION_ID,
          l.file_id,
          f.file_code,
          f.FILE_TYPE,
          f.FILE_NAME,
          p.DESCRIPTION period,
          cast( l.START_TIME  as date) as START_TIME,
          cast( l.FINISH_TIME as date) as FINISH_TIME,
          s.DESCRIPTION as STATUS,
          nvl(u.FIO,'Автоматичний процес формування'),
          l.FILE_STATUS as STATUS_CODE,
          f.VIEW_NM,
          f.FILE_FMT
     from NBUR_LST_FILES l
     join NBUR_REF_FILES f
       on ( f.ID = l.FILE_ID )
     join NBUR_REF_PERIODS p
       on ( p.PERIOD_TYPE = f.PERIOD_TYPE )
     join NBUR_REF_STATUS s
       on ( s.STATUS_TYPE = l.FILE_STATUS )
     left
     join STAFF$BASE u
       on ( u.ID = l.USER_ID )
    WHERE l.FILE_STATUS in ('FINISHED', 'BLOCKED', 'STOPPED');

PROMPT *** Create  grants  V_NBUR_LIST_FORM_FINISHED ***
grant SELECT                                                                 on V_NBUR_LIST_FORM_FINISHED to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_LIST_FORM_FINISHED to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_LIST_FORM_FINISHED to RPBN002;
grant SELECT                                                                 on V_NBUR_LIST_FORM_FINISHED to START1;
grant SELECT                                                                 on V_NBUR_LIST_FORM_FINISHED to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FORM_FINISHED.sql =========
PROMPT ===================================================================================== 
