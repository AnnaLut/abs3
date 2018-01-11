

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KL_F00_FILENAME.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KL_F00_FILENAME ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KL_F00_FILENAME ("KODF", "A017", "DATF", "FILENAME", "DATZ") AS 
  select substr(s.file_code, 2, 2) kodf,
           s.SCHEME_CODE a017,
           f.report_date datf,
           f_createfilename (substr(s.file_code, 2, 2), s.SCHEME_CODE, f.report_date, f.file_id) FILENAME,
        NVL (f.report_date, gl.bd) datz
    from V_NBUR_LIST_FORM_FINISHED f, 
         NBUR_REF_FILES s
    where s.file_code like '#A7' and
          s.id = f.file_id and
          f.status_code in ('FINISHED', 'BLOCKED');

PROMPT *** Create  grants  V_KL_F00_FILENAME ***
grant SELECT                                                                 on V_KL_F00_FILENAME to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_KL_F00_FILENAME to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_KL_F00_FILENAME to RPBN002;
grant SELECT,UPDATE                                                          on V_KL_F00_FILENAME to SALGL;
grant SELECT,UPDATE                                                          on V_KL_F00_FILENAME to START1;
grant SELECT                                                                 on V_KL_F00_FILENAME to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KL_F00_FILENAME.sql =========*** End 
PROMPT ===================================================================================== 
