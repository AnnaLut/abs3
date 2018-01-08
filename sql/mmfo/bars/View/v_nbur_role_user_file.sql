

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBUR_ROLE_USER_FILE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBUR_ROLE_USER_FILE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NBUR_ROLE_USER_FILE ("ROLE_ID", "ROLE_NAME", "USR_ID", "USR_NM", "FILE_CODE", "A017", "FILE_NAME") AS 
  select ru.ROLE_ID, ru.ROLE_NAME
     , ru.USR_ID,  ru.USR_NM
     , rf.FILE_CODE, rf.A017, rf.FILE_NAME
  from ( select r.ID as ROLE_ID, r.ROLE_NAME
              , u.ID as USR_ID, u.FIO as USR_NM
           from BARS.ADM_RESOURCE ar
           join ( select rel.GRANTEE_TYPE_ID
                       , rtu.RESOURCE_NAME as G_RESOURCE_NAME
                       , rel.RESOURCE_TYPE_ID
                       , rtr.RESOURCE_NAME as R_RESOURCE_NAME
                    from adm_resource_type_relation rel
                    join adm_resource_type          rtu
                      on ( rtu.ID = rel.GRANTEE_TYPE_ID )
                    join adm_resource_type          rtr
                      on ( rtr.ID = rel.RESOURCE_TYPE_ID )
                   where rtu.RESOURCE_CODE = 'STAFF_USER'
                     and rtr.RESOURCE_CODE = 'STAFF_ROLE'
                ) rur
             on ( rur.GRANTEE_TYPE_ID = ar.GRANTEE_TYPE_ID and rur.RESOURCE_TYPE_ID = ar.RESOURCE_TYPE_ID )
           join BARS.STAFF$BASE u
             on ( u.ID = ar.GRANTEE_ID )
           join BARS.STAFF_ROLE r
             on ( r.ID = ar.RESOURCE_ID )
       ) ru -- зв`язок ролей та користувачів
  join ( select r.ID as ROLE_ID
              , '#'||f.KODF as FILE_CODE, f.A017, f.SEMANTIC as FILE_NAME
           from BARS.ADM_RESOURCE ar
           join ( select rel.GRANTEE_TYPE_ID
                       , rtu.RESOURCE_NAME as G_RESOURCE_NAME
                       , rel.RESOURCE_TYPE_ID
                       , rtr.RESOURCE_NAME as R_RESOURCE_NAME
                    from adm_resource_type_relation rel
                    join adm_resource_type          rtu
                      on ( rtu.ID = rel.GRANTEE_TYPE_ID )
                    join adm_resource_type          rtr
                      on ( rtr.ID = rel.RESOURCE_TYPE_ID )
                   where rtu.RESOURCE_CODE = 'STAFF_ROLE'
                     and rtr.RESOURCE_CODE = 'KLF'
                ) rur
             on ( rur.GRANTEE_TYPE_ID = ar.GRANTEE_TYPE_ID and rur.RESOURCE_TYPE_ID = ar.RESOURCE_TYPE_ID )
           join BARS.STAFF_ROLE r
             on ( r.ID = ar.GRANTEE_ID )
           join BARS.KL_F00$GLOBAL f
             on ( f.ID = ar.RESOURCE_ID )
       ) rf -- зв`язок ролей та файлів звітності
    on ( ru.ROLE_ID = rf.ROLE_ID )
;

PROMPT *** Create  grants  V_NBUR_ROLE_USER_FILE ***
grant SELECT                                                                 on V_NBUR_ROLE_USER_FILE to BARSREADER_ROLE;
grant SELECT                                                                 on V_NBUR_ROLE_USER_FILE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBUR_ROLE_USER_FILE.sql =========*** 
PROMPT ===================================================================================== 
