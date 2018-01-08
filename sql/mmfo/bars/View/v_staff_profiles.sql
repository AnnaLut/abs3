

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_STAFF_PROFILES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_STAFF_PROFILES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_STAFF_PROFILES ("PROFILE", "PWD_EXPIRE_TIME", "PWD_GRACE_TIME", "PWD_REUSE_MAX", "PWD_REUSE_TIME", "PWD_VERIFY_FUNC", "PWD_LOCK_TIME", "USER_MAX_LOGIN", "USER_MAX_SESSION") AS 
  select "PROFILE","PWD_EXPIRE_TIME","PWD_GRACE_TIME","PWD_REUSE_MAX","PWD_REUSE_TIME","PWD_VERIFY_FUNC","PWD_LOCK_TIME","USER_MAX_LOGIN","USER_MAX_SESSION" from staff_profiles
readonly
 ;

PROMPT *** Create  grants  V_STAFF_PROFILES ***
grant SELECT                                                                 on V_STAFF_PROFILES to ABS_ADMIN;
grant SELECT                                                                 on V_STAFF_PROFILES to BARSREADER_ROLE;
grant SELECT                                                                 on V_STAFF_PROFILES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_STAFF_PROFILES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_STAFF_PROFILES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_STAFF_PROFILES.sql =========*** End *
PROMPT ===================================================================================== 
