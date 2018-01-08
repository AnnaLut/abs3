

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOC_TEMPLATES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOC_TEMPLATES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOC_TEMPLATES ("ID", "NAME", "PRINT_ON_BLANK", "TEMPLATE", "FR", "FILE_NAME") AS 
  select
  id,
  name,
  print_on_blank,
  template,
  fr,
  file_name
from doc_scheme
where d_close is null;

PROMPT *** Create  grants  V_DOC_TEMPLATES ***
grant SELECT                                                                 on V_DOC_TEMPLATES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOC_TEMPLATES.sql =========*** End **
PROMPT ===================================================================================== 
