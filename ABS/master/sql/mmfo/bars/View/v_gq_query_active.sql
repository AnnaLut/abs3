

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_GQ_QUERY_ACTIVE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_GQ_QUERY_ACTIVE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_GQ_QUERY_ACTIVE ("QUERY_ID", "QUERYTYPE_NAME", "USER_ID", "FIO", "REQUEST_DATE", "RESPONSE_DATE", "BRANCH", "QUERY_STATUS", "STATUS") AS 
  select q.query_id, t.querytype_name, q.user_id, s.fio, 
       q.request_date, q.response_date, q.branch, q.query_status, 
	   decode(q.query_status, 0, 'Не оброблен', 1, 'Оброблен', 2, 'Оброблен з помилкою') status 
  from gq_query_active a, gq_query q, gq_query_type t, staff$base s 
 where a.query_id = q.query_id 
   and q.querytype_id = t.querytype_id 
   and q.user_id = s.id

 ;

PROMPT *** Create  grants  V_GQ_QUERY_ACTIVE ***
grant SELECT                                                                 on V_GQ_QUERY_ACTIVE to BARSREADER_ROLE;
grant SELECT                                                                 on V_GQ_QUERY_ACTIVE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_GQ_QUERY_ACTIVE to DPT_ROLE;
grant SELECT                                                                 on V_GQ_QUERY_ACTIVE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_GQ_QUERY_ACTIVE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_GQ_QUERY_ACTIVE.sql =========*** End 
PROMPT ===================================================================================== 
