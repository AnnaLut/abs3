

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GQQUERY_QUEUE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GQQUERY_QUEUE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GQQUERY_QUEUE ("QUERY_ID", "QUERYTYPE_ID", "QUERY_STATUS", "REQUEST_DATE", "REQUEST", "RESPONSE_DATE", "RESPONSE", "BRANCH", "USER_ID") AS 
  select "QUERY_ID","QUERYTYPE_ID","QUERY_STATUS","REQUEST_DATE","REQUEST","RESPONSE_DATE","RESPONSE","BRANCH","USER_ID"
  from gq_query
 where decode(query_status, 0, 1, null) = 1
 ;

PROMPT *** Create  grants  V_GQQUERY_QUEUE ***
grant SELECT                                                                 on V_GQQUERY_QUEUE to BARSREADER_ROLE;
grant SELECT                                                                 on V_GQQUERY_QUEUE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_GQQUERY_QUEUE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GQQUERY_QUEUE.sql =========*** End **
PROMPT ===================================================================================== 
