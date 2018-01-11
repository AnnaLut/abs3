

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIG_JOB.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIG_JOB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIG_JOB ("JOB", "LOG_USER", "PRIV_USER", "SCHEMA_USER", "LAST_DATE", "LAST_SEC", "THIS_DATE", "THIS_SEC", "NEXT_DATE", "NEXT_SEC", "TOTAL_TIME", "BROKEN", "INTERVAL", "FAILURES", "WHAT", "NLS_ENV", "MISC_ENV", "INSTANCE", "BRANCH") AS 
  SELECT "JOB",
          "LOG_USER",
          "PRIV_USER",
          "SCHEMA_USER",
          "LAST_DATE",
          "LAST_SEC",
          "THIS_DATE",
          "THIS_SEC",
          "NEXT_DATE",
          "NEXT_SEC",
          "TOTAL_TIME",
          "BROKEN",
          "INTERVAL",
          "FAILURES",
          "WHAT",
          "NLS_ENV",
          "MISC_ENV",
          "INSTANCE",
          --sys_context('bars_context','user_branch') branch
          '/'||substr (what,31,6)||'/' branch
     FROM dba_jobs
    WHERE LOWER (what) LIKE 'cig_mgr.collect_data%';

PROMPT *** Create  grants  V_CIG_JOB ***
grant SELECT                                                                 on V_CIG_JOB       to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIG_JOB       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIG_JOB       to CIG_ROLE;
grant SELECT                                                                 on V_CIG_JOB       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIG_JOB.sql =========*** End *** ====
PROMPT ===================================================================================== 
