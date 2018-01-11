

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BL_PASSPORT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BL_PASSPORT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BL_PASSPORT ("PASSPORT_ID", "PERSON_ID", "PASS_SER", "PASS_NUM", "PASS_DATE", "PASS_OFFICE", "PASS_REGION", "INS_DATE", "USER_ID", "BASE_ID") AS 
  SELECT "PASSPORT_ID", "PERSON_ID", "PASS_SER", "PASS_NUM", "PASS_DATE",
          "PASS_OFFICE", "PASS_REGION", "INS_DATE", "USER_ID", "BASE_ID"
     FROM bl_passport;

PROMPT *** Create  grants  V_BL_PASSPORT ***
grant SELECT                                                                 on V_BL_PASSPORT   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BL_PASSPORT   to RBL;
grant SELECT                                                                 on V_BL_PASSPORT   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BL_PASSPORT.sql =========*** End *** 
PROMPT ===================================================================================== 
