

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SOCIALTEMPLATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SOCIALTEMPLATE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SOCIALTEMPLATE ("TYPE_ID", "ID", "NAME", "TEMPLATE", "FLAG_ID", "FLAG_NAME", "PRINT_ON_BLANK") AS 
  SELECT s.type_id, d.ID, d.NAME, d.TEMPLATE, f.ID, f.NAME, d.print_on_blank
     FROM social_templates s, doc_scheme d, dpt_vidd_flags f
    WHERE s.template_id = d.ID AND s.flag_id = f.ID 
 ;

PROMPT *** Create  grants  V_SOCIALTEMPLATE ***
grant SELECT                                                                 on V_SOCIALTEMPLATE to BARSREADER_ROLE;
grant SELECT                                                                 on V_SOCIALTEMPLATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SOCIALTEMPLATE to DPT_ROLE;
grant SELECT                                                                 on V_SOCIALTEMPLATE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SOCIALTEMPLATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SOCIALTEMPLATE.sql =========*** End *
PROMPT ===================================================================================== 
