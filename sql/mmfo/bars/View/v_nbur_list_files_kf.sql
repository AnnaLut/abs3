

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FILES_KF.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_LIST_FILES_KF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_LIST_FILES_KF ("KF", "FILE_ID", "FILE_CODE", "SCHEME_CODE", "FILE_NAME", "FILE_PATH", "E_ADDRESS") AS 
  SELECT l.kf,
          f.id file_id,
          f.file_code,
          F.SCHEME_CODE,
          f.file_name,
          L.FILE_PATH,
          L.E_ADDRESS
     FROM NBUR_REF_FILES f, NBUR_REF_FILES_LOCAL l
    WHERE F.ID = L.FILE_ID;

PROMPT *** Create  grants  V_NBUR_LIST_FILES_KF ***
grant SELECT                                                                 on V_NBUR_LIST_FILES_KF to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_LIST_FILES_KF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_LIST_FILES_KF to RPBN002;
grant SELECT                                                                 on V_NBUR_LIST_FILES_KF to START1;
grant SELECT                                                                 on V_NBUR_LIST_FILES_KF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FILES_KF.sql =========*** E
PROMPT ===================================================================================== 
