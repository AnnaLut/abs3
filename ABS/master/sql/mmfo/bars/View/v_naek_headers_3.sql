

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NAEK_HEADERS_3.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NAEK_HEADERS_3 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NAEK_HEADERS_3 ("FILE_YEAR", "FILE_NAME", "MAKE_TIME", "LINES_COUNT", "STATE", "RCPT_TIME") AS 
  select "FILE_YEAR","FILE_NAME","MAKE_TIME","LINES_COUNT","STATE","RCPT_TIME" from naek_headers where case when state=3 then 3 else null end = 3
 ;

PROMPT *** Create  grants  V_NAEK_HEADERS_3 ***
grant SELECT                                                                 on V_NAEK_HEADERS_3 to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_NAEK_HEADERS_3 to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_NAEK_HEADERS_3 to TOSS;
grant SELECT                                                                 on V_NAEK_HEADERS_3 to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NAEK_HEADERS_3 to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NAEK_HEADERS_3.sql =========*** End *
PROMPT ===================================================================================== 
