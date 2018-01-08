

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BRATES_LAST_VALUE_KF.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BRATES_LAST_VALUE_KF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BRATES_LAST_VALUE_KF ("BR_ID", "BDATE", "KV", "S", "RATE", "KF") AS 
  SELECT br_id,
          bdate,
          kv,
          s,
          rate,
          CASE branch WHEN  '/' THEN f_ourmfo
          ELSE SUBSTR (branch, 2, 6) END kf
     FROM BR_TIER_EDIT
     where ( br_id, kv, bdate ) in ( select br_id, kv, max(bdate)
                                   from BR_TIER_EDIT
                                  group by br_id, kv )
   UNION ALL
   SELECT br_id,
          bdate,
          kv,
          0,
          rate,
          CASE branch WHEN  '/' THEN f_ourmfo
          ELSE SUBSTR (branch, 2, 6) END kf
     FROM BR_normal_EDIT
     where ( br_id, kv, bdate ) in ( select br_id, kv, max(bdate)
                                   from br_normal_edit
                                  group by br_id, kv );

PROMPT *** Create  grants  V_BRATES_LAST_VALUE_KF ***
grant SELECT                                                                 on V_BRATES_LAST_VALUE_KF to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BRATES_LAST_VALUE_KF.sql =========***
PROMPT ===================================================================================== 
