

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOC_SCHEME_NOTFR.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOC_SCHEME_NOTFR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOC_SCHEME_NOTFR ("ID", "NAME", "PRINT_ON_BLANK", "TEMPLATE", "HEADER", "FOOTER", "HEADER_EX", "D_CLOSE", "FR", "FILE_NAME") AS 
  select "ID","NAME","PRINT_ON_BLANK","TEMPLATE","HEADER","FOOTER","HEADER_EX","D_CLOSE","FR","FILE_NAME" from doc_scheme where fr = 0;

PROMPT *** Create  grants  V_DOC_SCHEME_NOTFR ***
grant SELECT                                                                 on V_DOC_SCHEME_NOTFR to BARSREADER_ROLE;
grant SELECT                                                                 on V_DOC_SCHEME_NOTFR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOC_SCHEME_NOTFR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOC_SCHEME_NOTFR.sql =========*** End
PROMPT ===================================================================================== 
