

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/View/V_UPL_ALL_JOBS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_ALL_JOBS ***

  CREATE OR REPLACE FORCE VIEW BARSUPL.V_UPL_ALL_JOBS ("JOB_NAME", "STATE", "DESCRIPT", "IS_ACTIVE", "IS_EXISTS") AS 
  select u.job_name, nvl(j.state,'NOT EXISTS') state,
       u.descript, is_active,
       case when j.state is null then 0 else 1 end is_exists
  from v_upl_scheduler_jobs j,
       upl_autojobs         u
where upper(u.job_name) = j.job_name(+);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/View/V_UPL_ALL_JOBS.sql =========*** End 
PROMPT ===================================================================================== 
