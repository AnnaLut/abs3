

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_USER_PARTNER_TYPE_TARIFF.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_USER_PARTNER_TYPE_TARIFF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_USER_PARTNER_TYPE_TARIFF ("PARTNER_ID", "TYPE_ID", "TARIFF_ID", "TARIFF_NAME", "MIN_VALUE", "MIN_PERC", "MAX_VALUE", "MAX_PERC", "AMORT") AS 
  SELECT t0.partner_id,
          t0.type_id,
          t0.tariff_id,
          t.name AS tariff_name,
          t.min_value,
          t.min_perc,
          t.max_value,
          t.max_perc,
          t.amort
     FROM (SELECT ptp.partner_id,
                  ptt.type_id,
                  NVL (ptt.tariff_id, ptp.tariff_id) AS tariff_id
             FROM (SELECT pt.partner_id,
                          pt.type_id,
                          (SELECT NVL (ptb.tariff_id, pt.tariff_id)
                             FROM ins_partner_type_branches ptb
                            WHERE SYS_CONTEXT ('bars_context', 'user_branch') LIKE
                                     ptb.branch
                                     || DECODE (ptb.apply_hier, 1, '%', '')
                                  AND (ptb.partner_id = pt.partner_id
                                       OR ptb.partner_id IS NULL)
                                  AND (ptb.type_id = pt.type_id
                                       OR ptb.type_id IS NULL)
                                  AND ROWNUM = 1)
                             AS tariff_id
                     FROM v_ins_partner_types pt) ptt,
                  v_ins_partners ptp
            WHERE ptp.partner_id = ptt.partner_id) t0,
          ins_tariffs t
    WHERE t0.tariff_id = t.id(+);

PROMPT *** Create  grants  V_INS_USER_PARTNER_TYPE_TARIFF ***
grant SELECT                                                                 on V_INS_USER_PARTNER_TYPE_TARIFF to BARSREADER_ROLE;
grant SELECT                                                                 on V_INS_USER_PARTNER_TYPE_TARIFF to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INS_USER_PARTNER_TYPE_TARIFF to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_USER_PARTNER_TYPE_TARIFF.sql ====
PROMPT ===================================================================================== 
