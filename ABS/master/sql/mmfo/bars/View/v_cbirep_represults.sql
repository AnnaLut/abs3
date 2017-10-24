

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CBIREP_REPRESULTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CBIREP_REPRESULTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CBIREP_REPRESULTS ("QUERY_ID", "REP_ID", "REP_DESC", "KEY_PARAMS", "XML_PARAMS", "STATUS_ID", "STATS_NAME", "STATS_COMM_ID", "STATS_COMM", "CREATION_TIME", "PROC_TIME", "SESSION_ID") AS 
  select cq.id as query_id,
       cq.rep_id,
       r.description as rep_desc,
       cq.key_params,
       cq.xml_params,
       cq.status_id,
       cqs.name as stats_name,
       cqsh.id as stats_comm_id,
       cqsh.comm as stats_comm,
       cq.creation_time,
       case cq.status_id
         when 'PROCESS' then
          round(((sysdate - cq.creation_time) * 24 * 60))
         else
          (select round(((set_time - cq.creation_time) * 24 * 60))
             from cbirep_query_statuses_history
            where query_id = cq.id
              and status_id = 'DONE'
              and status_date >= cq.creation_time)
       end proc_time,
       cq.session_id
  from cbirep_queries                cq,
       cbirep_query_statuses         cqs,
       cbirep_query_statuses_history cqsh,
       reports                       r
 where cq.userid = user_id
   and cq.status_id = cqs.id
   and cq.id = cqsh.query_id
   and cq.status_id = cqsh.status_id
   and cq.creation_time <= cqsh.set_time
   and cq.rep_id = r.id;

PROMPT *** Create  grants  V_CBIREP_REPRESULTS ***
grant SELECT                                                                 on V_CBIREP_REPRESULTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CBIREP_REPRESULTS to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_CBIREP_REPRESULTS to WR_CBIREP;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CBIREP_REPRESULTS.sql =========*** En
PROMPT ===================================================================================== 
