

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_FILE_SCHEDULE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_FILE_SCHEDULE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_FILE_SCHEDULE ("FILE_ID", "FILE_CODE", "SCHEME_CODE", "FILE_NAME", "PERIOD_TYPE", "DAYS_FORM", "DATE_START", "DATE_FINISH") AS 
  SELECT s.file_id,
          r.FILE_CODE,
          r.SCHEME_CODE,
          r.FILE_NAME,
          p.description,
          s.days_form,
          s.date_start,
          s.date_finish
     FROM NBUR_REF_FILE_SCHEDULE s,
          nbur_ref_files r,
          NBUR_REF_PERIODS p
    WHERE S.FILE_ID = r.id and
        r.PERIOD_TYPE = P.PERIOD_TYPE;

PROMPT *** Create  grants  V_NBUR_FILE_SCHEDULE ***
grant SELECT                                                                 on V_NBUR_FILE_SCHEDULE to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_FILE_SCHEDULE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_FILE_SCHEDULE to RPBN002;
grant SELECT                                                                 on V_NBUR_FILE_SCHEDULE to START1;
grant SELECT                                                                 on V_NBUR_FILE_SCHEDULE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_FILE_SCHEDULE.sql =========*** E
PROMPT ===================================================================================== 
