

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_USER_PARTNER_TYPE_LIMIT.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_USER_PARTNER_TYPE_LIMIT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_USER_PARTNER_TYPE_LIMIT ("PARTNER_ID", "TYPE_ID", "LIMIT_ID", "LIMIT_NAME", "SUM_VALUE", "PERC_VALUE") AS 
  SELECT t0.partner_id,
          t0.type_id,
          t0.limit_id,
          t.name AS limit_name,
          t.sum_value,
          t.perc_value
     FROM (SELECT ptp.partner_id,
                  ptt.type_id,
                  NVL (ptt.limit_id, ptp.limit_id) AS limit_id
             FROM (SELECT pt.partner_id,
                          pt.type_id,
                          (SELECT NVL (ptb.limit_id, pt.limit_id)
                             FROM ins_partner_type_branches ptb
                            WHERE SYS_CONTEXT ('bars_context', 'user_branch') LIKE
                                     ptb.branch
                                     || DECODE (ptb.apply_hier, 1, '%', '')
                                  AND (ptb.partner_id = pt.partner_id
                                       OR ptb.partner_id IS NULL)
                                  AND (ptb.type_id = pt.type_id
                                       OR ptb.type_id IS NULL)
                                  AND ROWNUM = 1)
                             AS limit_id
                     FROM v_ins_partner_types pt) ptt,
                  v_ins_partners ptp
            WHERE ptp.partner_id = ptt.partner_id) t0,
          ins_limits t
    WHERE t0.limit_id = t.id(+);

PROMPT *** Create  grants  V_INS_USER_PARTNER_TYPE_LIMIT ***
grant SELECT                                                                 on V_INS_USER_PARTNER_TYPE_LIMIT to BARSREADER_ROLE;
grant SELECT                                                                 on V_INS_USER_PARTNER_TYPE_LIMIT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INS_USER_PARTNER_TYPE_LIMIT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_USER_PARTNER_TYPE_LIMIT.sql =====
PROMPT ===================================================================================== 
