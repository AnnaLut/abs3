PROMPT *** Create  view V_NBUR_LIST_FILES_USER ***

create or replace force view V_NBUR_LIST_FILES_USER
( KF
, FILE_ID
, FILE_CODE
, SCHEME_CODE
, FILE_TYPE
, FILE_NAME
, FILE_FMT_LIST
, PERIOD
, PROCC
, PROCK
) AS 
SELECT a.KF,
       a.FILE_ID,
       a.FILE_CODE,
       a.SCHEME_CODE,
       a.FILE_TYPE,
       a.FILE_NAME,
       a.FILE_FMT_LIST,
       a.PERIOD,
       P.PROC_NAME as PROCC,
       K.PROC_NAME as PROCK
  FROM ( SELECT l.KF
              , f.ID as FILE_ID
              , f.FILE_CODE
              , f.SCHEME_CODE
              , f.FILE_TYPE
              , f.FILE_NAME
              , nvl2(NULLIF(x.FILE_FMT,f.FILE_FMT),(f.FILE_FMT||','||x.FILE_FMT),f.FILE_FMT) as FILE_FMT_LIST
              , p.DESCRIPTION as PERIOD
           from NBUR_REF_FILES f
           join NBUR_REF_FILES_LOCAL l
             on ( l.FILE_ID = f.ID )
           join NBUR_REF_PERIODS p
             on ( p.PERIOD_TYPE = f.PERIOD_TYPE )
           left outer 
           join nbur_lnk_files_files ff 
           on (f.id = ff.file_id)
           left outer
           join NBUR_REF_FILES x
             on ( x.id = ff.file_dep_id )
          where f.FILE_TYPE = 2 -- file_code LIKE '@%'
             or ( f.FILE_CODE, f.SCHEME_CODE ) in ( select FILE_CODE, A017
                                                      from V_NBUR_ROLE_USER_FILE
                                                     where USR_ID = USER_ID() )
       ) a
  LEFT OUTER
  JOIN NBUR_REF_PROCS p
    ON ( A.FILE_ID = p.FILE_ID AND P.PROC_TYPE = 'F' AND P.PROC_ACTIVE = 'Y' )
  LEFT OUTER
  JOIN NBUR_REF_PROCS k
    ON ( A.FILE_ID = k.FILE_ID AND k.PROC_TYPE = 'C' AND k.PROC_ACTIVE = 'Y' )
;

show errors;

PROMPT *** Create  grants  V_NBUR_LIST_FILES_USER ***

grant SELECT on V_NBUR_LIST_FILES_USER to BARS_ACCESS_DEFROLE;
grant SELECT on V_NBUR_LIST_FILES_USER to RPBN002;
grant SELECT on V_NBUR_LIST_FILES_USER to START1;
