PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KL_F00_FILENAME.sql =========*** Run 
PROMPT ===================================================================================== 

PROMPT *** Create  view V_KL_F00_FILENAME ***

CREATE OR REPLACE FORCE VIEW BARS.V_KL_F00_FILENAME
(
   KODF,
   A017,
   DATF,
   FILENAME,
   DATZ
)
AS
   SELECT SUBSTR (s.file_code, 2, 2) kodf,
          s.SCHEME_CODE a017,
          f.report_date datf,
          f_createfilename (SUBSTR (s.file_code, 2, 2),
                            s.SCHEME_CODE,
                            f.report_date,
                            f.file_id)
             FILENAME,
          NVL (f.report_date, gl.bd) datz
     FROM V_NBUR_LIST_FORM_FINISHED f, NBUR_REF_FILES s
    WHERE     s.file_code LIKE '#A7'
          AND s.id = f.file_id
          AND f.status_code IN ('FINISHED', 'BLOCKED')
    order by datz;
/
show errors;	

GRANT SELECT ON BARS.V_KL_F00_FILENAME TO BARSREADER_ROLE;

GRANT SELECT, UPDATE ON BARS.V_KL_F00_FILENAME TO BARS_ACCESS_DEFROLE;

GRANT SELECT, UPDATE ON BARS.V_KL_F00_FILENAME TO RPBN002;

PROMPT *** Create  grants  V_KL_F00_FILENAME ***
grant SELECT,UPDATE                                                          on V_KL_F00_FILENAME to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_KL_F00_FILENAME to RPBN002;
grant SELECT,UPDATE                                                          on V_KL_F00_FILENAME to SALGL;
grant SELECT,UPDATE                                                          on V_KL_F00_FILENAME to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KL_F00_FILENAME.sql =========*** End 
PROMPT ===================================================================================== 
