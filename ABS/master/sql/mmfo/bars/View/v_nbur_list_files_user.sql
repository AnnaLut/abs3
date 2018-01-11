

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FILES_USER.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_LIST_FILES_USER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_LIST_FILES_USER ("KF", "FILE_ID", "FILE_CODE", "SCHEME_CODE", "FILE_TYPE", "FILE_NAME", "PERIOD", "PROCC", "PROCK") AS 
  SELECT a."KF",
       a."FILE_ID",
       a."FILE_CODE",
       a."SCHEME_CODE",
       a."FILE_TYPE",
       a."FILE_NAME",
       a."PERIOD",
       P.PROC_NAME procc,
       K.PROC_NAME prock
  FROM ( SELECT l.kf,
                f.id file_id,
                f.file_code,
                f.scheme_code,
                f.file_type,
                f.file_name,
                P.DESCRIPTION period
           from NBUR_REF_FILES f
           join NBUR_REF_FILES_LOCAL l
             on ( l.FILE_ID = f.ID )
           join NBUR_REF_PERIODS p
             on ( p.PERIOD_TYPE = f.PERIOD_TYPE )
          where f.FILE_TYPE = 2 -- file_code LIKE '@%'
             or ( f.FILE_CODE, f.SCHEME_CODE ) in ( select FILE_CODE, A017
                                                      from BARS.V_NBUR_ROLE_USER_FILE
                                                     where USR_ID = bars.user_id() )
       ) a
  LEFT OUTER
  JOIN NBUR_REF_PROCS p
    ON ( A.FILE_ID = p.FILE_ID AND P.PROC_TYPE = 'F' AND P.PROC_ACTIVE = 'Y' )
  LEFT OUTER
  JOIN NBUR_REF_PROCS k
    ON ( A.FILE_ID = k.FILE_ID AND k.PROC_TYPE = 'C' AND k.PROC_ACTIVE = 'Y' )
;

PROMPT *** Create  grants  V_NBUR_LIST_FILES_USER ***
grant SELECT                                                                 on V_NBUR_LIST_FILES_USER to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_LIST_FILES_USER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NBUR_LIST_FILES_USER to RPBN002;
grant SELECT                                                                 on V_NBUR_LIST_FILES_USER to START1;
grant SELECT                                                                 on V_NBUR_LIST_FILES_USER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_LIST_FILES_USER.sql =========***
PROMPT ===================================================================================== 
