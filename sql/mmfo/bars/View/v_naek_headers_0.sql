

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NAEK_HEADERS_0.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NAEK_HEADERS_0 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NAEK_HEADERS_0 ("FILE_YEAR", "FILE_NAME", "MAKE_TIME", "LINES_COUNT", "STATE", "RCPT_TIME") AS 
  select "FILE_YEAR","FILE_NAME","MAKE_TIME","LINES_COUNT","STATE","RCPT_TIME" from naek_headers where case when state=0 then 0 else null end = 0
 ;

PROMPT *** Create  grants  V_NAEK_HEADERS_0 ***
grant SELECT                                                                 on V_NAEK_HEADERS_0 to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_NAEK_HEADERS_0 to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_NAEK_HEADERS_0 to TOSS;
grant SELECT                                                                 on V_NAEK_HEADERS_0 to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NAEK_HEADERS_0 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NAEK_HEADERS_0.sql =========*** End *
PROMPT ===================================================================================== 
