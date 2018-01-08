

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BL_LOST_PASS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BL_LOST_PASS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BL_LOST_PASS ("PASS_SER", "PASS_NUM", "LNAME", "FNAME", "MNAME", "BDATE", "BASE", "INFO_SOURCE", "PASS_DATE", "PASS_OFFICE", "INS_DATE", "USER_ID", "BASE_ID") AS 
  SELECT "PASS_SER", "PASS_NUM", "LNAME", "FNAME", "MNAME", "BDATE", "BASE",
          "INFO_SOURCE", "PASS_DATE", "PASS_OFFICE", "INS_DATE", "USER_ID",
          "BASE_ID"
     FROM bl_lost_pass;

PROMPT *** Create  grants  V_BL_LOST_PASS ***
grant SELECT                                                                 on V_BL_LOST_PASS  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BL_LOST_PASS  to RBL;
grant SELECT                                                                 on V_BL_LOST_PASS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BL_LOST_PASS.sql =========*** End ***
PROMPT ===================================================================================== 
