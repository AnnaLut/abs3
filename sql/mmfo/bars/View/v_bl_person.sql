

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BL_PERSON.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BL_PERSON ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BL_PERSON ("PERSON_ID", "INN", "LNAME", "FNAME", "MNAME", "BDATE", "INN_DATE", "INS_DATE", "USER_ID", "BASE_ID") AS 
  SELECT "PERSON_ID", "INN", "LNAME", "FNAME", "MNAME", "BDATE", "INN_DATE",
          "INS_DATE", "USER_ID", "BASE_ID"
     FROM bl_person;

PROMPT *** Create  grants  V_BL_PERSON ***
grant SELECT                                                                 on V_BL_PERSON     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BL_PERSON     to RBL;
grant SELECT                                                                 on V_BL_PERSON     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BL_PERSON.sql =========*** End *** ==
PROMPT ===================================================================================== 
