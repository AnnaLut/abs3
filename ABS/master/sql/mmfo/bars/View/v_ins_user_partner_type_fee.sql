

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_USER_PARTNER_TYPE_FEE.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_USER_PARTNER_TYPE_FEE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_USER_PARTNER_TYPE_FEE ("PARTNER_ID", "TYPE_ID", "FEE_ID", "FEE_NAME", "MIN_VALUE", "PERC_VALUE", "MAX_VALUE") AS 
  SELECT t0.partner_id,
          t0.type_id,
          t0.fee_id,
          t.name AS fee_name,
          t.min_value,
          t.perc_value,
          t.max_value
     FROM (SELECT ptp.partner_id,
                  ptt.type_id,
                  NVL (ptt.fee_id, ptp.fee_id) AS fee_id
             FROM (SELECT pt.partner_id,
                          pt.type_id,
                          (SELECT NVL (ptb.fee_id, pt.FEE_ID)
                             FROM ins_partner_type_branches ptb
                            WHERE SYS_CONTEXT ('bars_context', 'user_branch') LIKE
                                     ptb.branch
                                     || DECODE (ptb.apply_hier, 1, '%', '')
                                  AND (ptb.partner_id = pt.partner_id
                                       OR ptb.partner_id IS NULL)
                                  AND (ptb.type_id = pt.type_id
                                       OR ptb.type_id IS NULL)
                                  AND ROWNUM = 1)
                             AS fee_id
                     FROM v_ins_partner_types pt) ptt,
                  v_ins_partners ptp
            WHERE ptp.partner_id = ptt.partner_id) t0,
          ins_fees t
    WHERE t0.fee_id = t.id(+);

PROMPT *** Create  grants  V_INS_USER_PARTNER_TYPE_FEE ***
grant SELECT                                                                 on V_INS_USER_PARTNER_TYPE_FEE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_USER_PARTNER_TYPE_FEE.sql =======
PROMPT ===================================================================================== 
