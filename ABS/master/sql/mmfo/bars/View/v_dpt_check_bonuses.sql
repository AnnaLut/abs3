

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_CHECK_BONUSES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_CHECK_BONUSES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_CHECK_BONUSES ("VIDD", "DEPOSIT_ID", "RNK", "OST", "CNT_DUBL", "ACC", "BDATE", "BR", "OP", "IR", "BR_NEW", "METHOD_ID", "BONUS2", "BONUS4", "BONUS00") AS 
  WITH bonus_base
     AS (SELECT dpt_type,
                dbs.val,
                dbs.s s0,
                  NVL (LEAD (dbs.s) OVER (ORDER BY dbs.s), 9999999999999999)
                - 1
                   s
           FROM dpt_bonus_settings dbs)
  SELECT DISTINCT
         dc.vidd,
         deposit_id,
         rnk,
         GREATEST (dc.LIMIT * 100, fost (dc.acc, dc.dat_begin)) ost,
         cnt_dubl,
         acc,
         dc.dat_begin bdate,
         (SELECT br
            FROM int_ratn
           WHERE acc = dc.acc AND bdat = dc.dat_begin)
            br,
         (SELECT op
            FROM int_ratn
           WHERE acc = dc.acc AND bdat = dc.dat_begin)
            op,
         (SELECT ir
            FROM int_ratn
           WHERE acc = dc.acc AND bdat = dc.dat_begin)
            ir,
         (SELECT base_rate
            FROM dpt_vidd_extdesc de
           WHERE     type_id = (SELECT extension_id
                                  FROM dpt_vidd dv
                                 WHERE dv.vidd = dc.vidd)
                 AND ext_num =
                        (SELECT MIN (ext_num)
                           FROM dpt_vidd_extdesc de1
                          WHERE     de.type_id = de1.type_id
                                AND DE1.EXT_NUM <= dc.cnt_dubl))
            br_new,
         (SELECT method_id
            FROM dpt_vidd_extdesc de
           WHERE     type_id = (SELECT extension_id
                                  FROM dpt_vidd dv
                                 WHERE dv.vidd = dc.vidd)
                 AND ext_num =
                        (SELECT MIN (ext_num)
                           FROM dpt_vidd_extdesc de1
                          WHERE     de.type_id = de1.type_id
                                AND DE1.EXT_NUM <= dc.cnt_dubl))
            method_id,            
            f_get_dptbonus(2, dc.deposit_id) bonus2,
            f_get_dptbonus(4, dc.deposit_id) bonus4,
         (SELECT CASE WHEN method_id < 8 THEN indv_rate END
            FROM dpt_vidd_extdesc de
           WHERE     type_id = (SELECT extension_id
                                  FROM dpt_vidd dv
                                 WHERE dv.vidd = dc.vidd)
                 AND ext_num =
                        (SELECT MIN (ext_num)
                           FROM dpt_vidd_extdesc de1
                          WHERE     de.type_id = de1.type_id
                                AND DE1.EXT_NUM <= dc.cnt_dubl))
            bonus00
    FROM dpt_deposit_clos dc, dpt_vidd dv, bonus_base bb
   WHERE     action_id = 3
         AND when >= DATE '2017-02-28'
         AND dc.vidd = dv.vidd
         AND bb.dpt_type = dv.type_id(+) and dc.deposit_id = 480535501 
ORDER BY dc.dat_begin;

PROMPT *** Create  grants  V_DPT_CHECK_BONUSES ***
grant SELECT                                                                 on V_DPT_CHECK_BONUSES to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_CHECK_BONUSES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_CHECK_BONUSES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_CHECK_BONUSES.sql =========*** En
PROMPT ===================================================================================== 
