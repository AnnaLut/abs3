

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BRATES_VALUE_KF.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BRATES_VALUE_KF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BRATES_VALUE_KF ("BR_ID", "BDATE", "KV", "S", "RATE", "KF") AS 
  SELECT br_id,
          bdate,
          kv,
          s,
          rate,
          CASE branch WHEN  '/' THEN f_ourmfo
          ELSE SUBSTR (branch, 2, 6) END kf
     FROM BR_TIER_EDIT
   UNION ALL
   SELECT br_id,
          bdate,
          kv,
          0,
          rate,
          CASE branch WHEN  '/' THEN f_ourmfo
          ELSE SUBSTR (branch, 2, 6) END kf
     FROM BR_normal_EDIT;

PROMPT *** Create  grants  V_BRATES_VALUE_KF ***
grant SELECT                                                                 on V_BRATES_VALUE_KF to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BRATES_VALUE_KF.sql =========*** End 
PROMPT ===================================================================================== 
