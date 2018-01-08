

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_BONUSES_FREE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_BONUSES_FREE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_BONUSES_FREE ("DPT_ID", "BONUS_ID", "BONUS_NAME", "BONUS_CODE") AS 
  SELECT d.deposit_id, b.bonus_id, b.bonus_code, b.bonus_name
  FROM v_dpt_vidd_bonuses b, dpt_deposit d
 WHERE b.type_id = d.vidd
   AND b.bonus_activity = 'Y'
   AND b.rec_activity = 'Y'
   AND b.bonus_id NOT IN (SELECT v.bonus_id
                            FROM v_dpt_bonus_requests v
                           WHERE v.dpt_id = d.deposit_id)
 ;

PROMPT *** Create  grants  V_DPT_BONUSES_FREE ***
grant SELECT                                                                 on V_DPT_BONUSES_FREE to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_BONUSES_FREE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_BONUSES_FREE to DPT_ROLE;
grant SELECT                                                                 on V_DPT_BONUSES_FREE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_BONUSES_FREE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_BONUSES_FREE.sql =========*** End
PROMPT ===================================================================================== 
