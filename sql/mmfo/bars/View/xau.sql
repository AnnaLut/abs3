

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/XAU.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view XAU ***

  CREATE OR REPLACE FORCE VIEW BARS.XAU ("FILE_ID", "KODP", "ZNAP") AS 
  select file_id,parameter,value from RNBU_IN_INF_RECORDS;

PROMPT *** Create  grants  XAU ***
grant SELECT                                                                 on XAU             to BARSREADER_ROLE;
grant SELECT                                                                 on XAU             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XAU             to START1;
grant SELECT                                                                 on XAU             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/XAU.sql =========*** End *** ==========
PROMPT ===================================================================================== 
