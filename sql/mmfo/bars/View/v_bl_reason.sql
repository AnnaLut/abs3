

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BL_REASON.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BL_REASON ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BL_REASON ("REASON_ID", "PERSON_ID", "REASON_GROUP", "BASE", "INFO_SOURCE", "COMMENT_TEXT", "INS_DATE", "USER_ID", "BASE_ID", "TYPE_ID", "SVZ_ID") AS 
  SELECT "REASON_ID", "PERSON_ID", "REASON_GROUP", "BASE", "INFO_SOURCE",
          "COMMENT_TEXT", "INS_DATE", "USER_ID", "BASE_ID", "TYPE_ID",
          "SVZ_ID"
     FROM bl_reason;

PROMPT *** Create  grants  V_BL_REASON ***
grant DELETE,INSERT,SELECT,UPDATE                                            on V_BL_REASON     to RBL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BL_REASON.sql =========*** End *** ==
PROMPT ===================================================================================== 
