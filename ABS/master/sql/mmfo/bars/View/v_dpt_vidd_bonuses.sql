

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_VIDD_BONUSES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_VIDD_BONUSES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_VIDD_BONUSES ("TYPE_ID", "TYPE_CODE", "TYPE_NAME", "TYPE_ACTIVITY", "BONUS_ID", "BONUS_CODE", "BONUS_NAME", "BONUS_ACTIVITY", "REC_RANG", "REC_FINALLY", "REC_CONDITION", "REC_ACTIVITY") AS 
  SELECT v.vidd, v.type_cod, v.type_name, decode(v.flag, 0, 'N', 'Y'),
       b.bonus_id, b.bonus_code, b.bonus_name, b.bonus_activity,
       bv.rec_rang, bv.rec_finally, bv.rec_condition, bv.rec_activity
  FROM dpt_vidd v, dpt_vidd_bonuses bv, dpt_bonuses b
 WHERE v.vidd = bv.vidd
   AND bv.bonus_id = b.bonus_id
UNION ALL
SELECT v.vidd, v.type_cod, v.type_name, decode(v.flag, 0, 'N', 'Y'),
       b.bonus_id, b.bonus_code, b.bonus_name, b.bonus_activity,
       null, null, null, null
  FROM dpt_vidd v, dpt_bonuses b
 WHERE v.vidd NOT IN (SELECT bv.vidd
                        FROM dpt_vidd_bonuses bv
                       WHERE bv.bonus_id = b.bonus_id)
 ;

PROMPT *** Create  grants  V_DPT_VIDD_BONUSES ***
grant SELECT                                                                 on V_DPT_VIDD_BONUSES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_VIDD_BONUSES to DPT_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_VIDD_BONUSES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_VIDD_BONUSES.sql =========*** End
PROMPT ===================================================================================== 
