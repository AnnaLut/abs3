

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TECHACCTEMPLATES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TECHACCTEMPLATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TECHACCTEMPLATES ("ID", "NAME", "TEMPLATE", "PRINT_ON_BLANK") AS 
  SELECT d.id, d.name, d.template, d.print_on_blank
  FROM doc_scheme d, doc_root dv, cc_vidd v
 WHERE d.id = dv.id AND dv.vidd = v.vidd AND v.sps = 2
 ;

PROMPT *** Create  grants  V_TECHACCTEMPLATES ***
grant SELECT                                                                 on V_TECHACCTEMPLATES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_TECHACCTEMPLATES to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_TECHACCTEMPLATES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TECHACCTEMPLATES.sql =========*** End
PROMPT ===================================================================================== 
