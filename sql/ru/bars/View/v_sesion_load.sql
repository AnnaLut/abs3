

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SESION_LOAD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SESION_LOAD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SESION_LOAD ("SID", "USERNAME", "CLIENT_INFO", "STATUS", "TIMES") AS 
  SELECT SID,
            username,
            client_info,
            status,
            CASE
               WHEN status = 'ACTIVE'
               THEN
                     TRUNC (LAST_CALL_ET / 60 / 60, 0)
                  || 'год.'
                  || MOD (TRUNC (LAST_CALL_ET / 60, 0), 60)
                  || 'хв.'
                  || LPAD (MOD (LAST_CALL_ET, 60), 2, '0')
                  || 'сек.'
               ELSE
                  NULL
            END
               AS times
       FROM sys.v_$session
      WHERE     UPPER (client_info) LIKE 'STG_LOAD%RUNNING'
            AND prev_sql_id IS NOT NULL
   ORDER BY action;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SESION_LOAD.sql =========*** End *** 
PROMPT ===================================================================================== 
