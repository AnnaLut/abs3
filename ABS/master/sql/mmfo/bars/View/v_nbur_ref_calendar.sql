

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_REF_CALENDAR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_REF_CALENDAR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_REF_CALENDAR ("CALENDAR_DATE", "REPORT_DATE", "KF", "STATUS", "FILE_ID", "FILE_CODE", "SCHEME_CODE", "FILE_NAME", "PERIOD") AS 
  SELECT S.CALENDAR_DATE,
          S.REPORT_DATE,
          decode(s.kf, null, 'Âñ³ ô³ë³¿', 'Ô³ë³ÿ '||s.kf) kf,
          s.status,
          s.file_id,
          r.FILE_CODE,
          r.SCHEME_CODE,
          r.FILE_NAME,
          p.description
     FROM NBUR_REF_CALENDAR s,
          nbur_ref_files r,
          NBUR_REF_PERIODS p
    WHERE S.FILE_ID = r.id AND
          r.PERIOD_TYPE = P.PERIOD_TYPE and
          S.CALENDAR_DATE = bankdate;

PROMPT *** Create  grants  V_NBUR_REF_CALENDAR ***
grant SELECT                                                                 on V_NBUR_REF_CALENDAR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_REF_CALENDAR to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_REF_CALENDAR.sql =========*** En
PROMPT ===================================================================================== 
