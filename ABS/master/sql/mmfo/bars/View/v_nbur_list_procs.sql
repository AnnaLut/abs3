

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_PROCS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_LIST_PROCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_LIST_PROCS ("FILE_ID", "FILE_CODE", "SCHEME_CODE", "FILE_NAME", "FORM_PROC_NAME", "CONTROL_PROC_NAME") AS 
  SELECT f.id file_id,
          f.file_code,
          F.SCHEME_CODE,
          f.file_name,
          LTRIM (P.SCHEME || '.' || P.PROC_NAME, '.') form_proc_name,
          LTRIM (k.SCHEME || '.' || k.PROC_NAME, '.') control_proc_name
     FROM NBUR_REF_FILES f
          LEFT OUTER JOIN NBUR_REF_PROCS p
             ON (    F.ID = p.FILE_ID
                 AND P.PROC_TYPE = 'F'
                 AND P.PROC_ACTIVE = 'Y')
          LEFT OUTER JOIN NBUR_REF_PROCS k
             ON (    F.ID = k.FILE_ID
                 AND k.PROC_TYPE = 'C'
                 AND k.PROC_ACTIVE = 'Y');

PROMPT *** Create  grants  V_NBUR_LIST_PROCS ***
grant SELECT                                                                 on V_NBUR_LIST_PROCS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_LIST_PROCS to RPBN002;
grant SELECT                                                                 on V_NBUR_LIST_PROCS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_PROCS.sql =========*** End 
PROMPT ===================================================================================== 
