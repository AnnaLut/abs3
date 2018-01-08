

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/USER_TASKS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view USER_TASKS ***

  CREATE OR REPLACE FORCE VIEW BARS.USER_TASKS ("TASK_ID", "ORD", "NAME", "FUNCTION", "INTEREVAL", "METHOD", "TRIGGER_DATE") AS 
  SELECT
  TASK_LIST.TASK_ID,
  TASK_STAFF.ORD,
  TASK_LIST.NAME,
  TASK_LIST.FUNCTION,
  TASK_STAFF.INTERVAL,
  TASK_STAFF.METHOD,
  TASK_STAFF.TRIGGER_DATE
FROM
  TASK_LIST,TASK_STAFF,STAFF
WHERE
  TASK_LIST.TASK_ID=TASK_STAFF.TASK_ID AND
  TASK_STAFF.ID=STAFF.ID AND UPPER(STAFF.LOGNAME)=USER
 ;

PROMPT *** Create  grants  USER_TASKS ***
grant SELECT                                                                 on USER_TASKS      to BARSREADER_ROLE;
grant SELECT                                                                 on USER_TASKS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on USER_TASKS      to TASK_LIST;
grant SELECT                                                                 on USER_TASKS      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/USER_TASKS.sql =========*** End *** ===
PROMPT ===================================================================================== 
