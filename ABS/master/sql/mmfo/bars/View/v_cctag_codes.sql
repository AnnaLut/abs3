

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCTAG_CODES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCTAG_CODES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCTAG_CODES ("TAG", "NAME", "TAGTYPE", "TABLE_NAME", "TYPE", "NSISQLWHERE", "EDIT_IN_FORM", "NOT_TO_EDIT", "CODE", "CODE_NAME", "ORD") AS 
  SELECT t."TAG",t."NAME",t."TAGTYPE",t."TABLE_NAME",t."TYPE",t."NSISQLWHERE",t."EDIT_IN_FORM",t."NOT_TO_EDIT",t."CODE", c.name code_name, c.ord
     FROM cc_tag t, cc_tag_codes c
     where t.code = c.code
;

PROMPT *** Create  grants  V_CCTAG_CODES ***
grant SELECT                                                                 on V_CCTAG_CODES   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCTAG_CODES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCTAG_CODES   to RCC_DEAL;
grant SELECT                                                                 on V_CCTAG_CODES   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCTAG_CODES.sql =========*** End *** 
PROMPT ===================================================================================== 
