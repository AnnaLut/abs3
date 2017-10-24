

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOC_SCHEME_FR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOC_SCHEME_FR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOC_SCHEME_FR ("ID", "NAME", "PRINT_ON_BLANK", "TEMPLATE", "HEADER", "FOOTER", "HEADER_EX", "D_CLOSE", "FR", "FILE_NAME") AS 
  select "ID","NAME","PRINT_ON_BLANK","TEMPLATE","HEADER","FOOTER","HEADER_EX","D_CLOSE","FR","FILE_NAME" from doc_scheme where fr = 1;

PROMPT *** Create  grants  V_DOC_SCHEME_FR ***
grant SELECT                                                                 on V_DOC_SCHEME_FR to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOC_SCHEME_FR.sql =========*** End **
PROMPT ===================================================================================== 
