

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FILES_ALL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_LIST_FILES_ALL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_LIST_FILES_ALL ("FILE_ID", "FILE_CODE", "SCHEME_CODE", "FILE_NAME", "PERIOD") AS 
  SELECT f.id file_id,
          f.file_code,
          F.SCHEME_CODE,
          f.file_name,
          P.DESCRIPTION period
     FROM NBUR_REF_FILES f, NBUR_REF_PERIODS p
    WHERE F.PERIOD_TYPE = P.PERIOD_TYPE;

PROMPT *** Create  grants  V_NBUR_LIST_FILES_ALL ***
grant SELECT                                                                 on V_NBUR_LIST_FILES_ALL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_LIST_FILES_ALL to RPBN002;
grant SELECT                                                                 on V_NBUR_LIST_FILES_ALL to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FILES_ALL.sql =========*** 
PROMPT ===================================================================================== 
