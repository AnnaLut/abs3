

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DWH_CBIREP_QUERIES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DWH_CBIREP_QUERIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DWH_CBIREP_QUERIES ("ID", "USERID", "REP_ID", "KEY_PARAMS", "FILE_NAMES", "CREATION_TIME", "STATUS_ID", "STATUS_DATE", "SESSION_ID", "JOB_ID", "STATUS_NAME", "REPORT_NAME") AS 
  select q.id,
          q.userid,
          q.rep_id,
          DWH_CBIREP.PARSE_PARAMS(q.key_params) key_params,
		  q.file_names,
          q.creation_time,
          q.status_id,
          q.status_date,
          q.session_id,
          q.job_id,
          qs.name,
          r.name
     from dwh_cbirep_queries q
          join dwh_cbirep_query_statuses qs on q.status_id = qs.id
      join dwh_reports r on r.id = q.rep_id
     where q.userid = user_id;

PROMPT *** Create  grants  V_DWH_CBIREP_QUERIES ***
grant SELECT                                                                 on V_DWH_CBIREP_QUERIES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DWH_CBIREP_QUERIES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DWH_CBIREP_QUERIES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DWH_CBIREP_QUERIES.sql =========*** E
PROMPT ===================================================================================== 
