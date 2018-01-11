

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_OUT_UNBOUND_PAYMENTS.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_OUT_UNBOUND_PAYMENTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_OUT_UNBOUND_PAYMENTS ("REF", "CUST_RNK", "CUST_OKPO", "CUST_NMK", "CUST_ND", "BENEF_NMK", "ACC", "NLS", "PDAT", "VDAT", "KV", "TOTAL_SUM", "UNBOUND_SUM", "NAZN", "OP_TYPE_ID", "OP_TYPE", "PAY_TYPE", "PAY_TYPE_NAME", "IS_VISED", "DIRECT", "DIRECT_NAME", "TT", "BACKGROUND_COLOR", "ATTACHMENTS_COUNT") AS 
  SELECT ip.REF,
          c.rnk,
          c.okpo,
          c.nmkk,
          c.nd,
          ip.nam_b,
          a.acc,
          a.nls,
          ip.pdat,
          ip.vdat,
          ip.kv,
          ROUND (ip.s / 100, 2),
          ROUND ( (ip.s - cim_mgr.get_payments_bound_sum (ip.REF)) / 100, 2),
          ip.nazn,
          (SELECT TO_NUMBER (VALUE)
             FROM operw
            WHERE tag = 'CIMTO' AND REF = ip.REF),
          (SELECT type_name
             FROM cim_operation_types
            WHERE type_id = (SELECT TO_NUMBER (VALUE)
                               FROM operw
                              WHERE tag = 'CIMTO' AND REF = ip.REF)),
          0,
          pt.type_name,
          0,
          1,
          dn.type_name,
          ip.tt,
          NVL (
             (SELECT CASE
                        WHEN    w1.VALUE IS NULL
                             OR w3.VALUE IS NULL
                             OR w3.VALUE IS NULL
                        THEN
                           1
                        ELSE
                           0
                     END
                FROM operw w1
                     LEFT OUTER JOIN operw w2
                        ON w2.tag = 'D2#70' AND w2.REF = w1.REF
                     LEFT OUTER JOIN operw w3
                        ON w3.tag = 'D3#70' AND w3.REF = w1.REF
               WHERE w1.tag = 'KOD2C' AND w1.REF = ip.REF),
             1)
             AS background_color,
          NVL ( (SELECT TO_NUMBER (w1.VALUE)
                   FROM operw w1
                  WHERE w1.tag = 'ATT_D' AND w1.REF = ip.REF),
               0)
             AS attachments_count
     FROM v_cim_all_payments ip
          JOIN accounts a
             ON     (   ip.branch LIKE
                           SYS_CONTEXT ('bars_context', 'user_branch_mask')
                     OR a.branch LIKE
                           SYS_CONTEXT ('bars_context', 'user_branch_mask'))
                AND a.kf = ip.mfoa
                AND a.kv = ip.kv
                AND a.nls = ip.nlsa
          JOIN customer c ON c.rnk = a.rnk,
          (SELECT type_name
             FROM cim_payment_types
            WHERE type_id = 0) pt,
          (SELECT type_name
             FROM cim_types
            WHERE type_id = 1) dn
    WHERE ip.direct = 1
   UNION ALL
   SELECT o.REF,
          c.rnk,
          c.okpo,
          c.nmkk,
          c.nd,
          o.nam_b,
          a.acc,
          a.nls,
          o.pdat,
          o.vdat,
          o.kv,
          ROUND (o.s / 100, 2),
          ROUND (pb.s / 100, 2),
          o.nazn,
          (SELECT TO_NUMBER (VALUE)
             FROM operw
            WHERE tag = 'CIMTO' AND REF = pb.REF),
          (SELECT type_name
             FROM cim_operation_types
            WHERE type_id = (SELECT TO_NUMBER (VALUE)
                               FROM operw
                              WHERE tag = 'CIMTO' AND REF = pb.REF)),
          0,
          pt.type_name,
          1,
          1,
          dn.type_name,
          o.tt,
          NVL (
             (SELECT CASE
                        WHEN    w1.VALUE IS NULL
                             OR w3.VALUE IS NULL
                             OR w3.VALUE IS NULL
                        THEN
                           1
                        ELSE
                           0
                     END
                FROM operw w1
                     LEFT OUTER JOIN operw w2
                        ON w2.tag = 'D2#70' AND w2.REF = w1.REF
                     LEFT OUTER JOIN operw w3
                        ON w3.tag = 'D3#70' AND w3.REF = w1.REF
               WHERE w1.tag = 'KOD2C' AND w1.REF = pb.REF),
             1)
             AS background_color,
          NVL ( (SELECT TO_NUMBER (w1.VALUE)
                   FROM operw w1
                  WHERE w1.tag = 'ATT_D' AND w1.REF = pb.REF),
               0)
             AS attachments_count
     FROM cim_payments_bound pb
          JOIN oper o ON o.REF = pb.REF
          JOIN accounts a ON a.kf = o.mfoa AND a.kv = o.kv AND a.nls = o.nlsa
          JOIN customer c ON c.rnk = a.rnk,
          (SELECT type_name
             FROM cim_payment_types
            WHERE type_id = 0) pt,
          (SELECT type_name
             FROM cim_types
            WHERE type_id = 1) dn
    WHERE     pb.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
          AND pb.delete_date IS NULL
          AND pb.direct = 1
          AND pb.contr_id IS NULL
   UNION ALL
   SELECT fb.fantom_id,
          o.rnk,
          c.okpo,
          c.nmkk,
          c.nd,
          b.benef_name,
          NULL,
          NULL,
          o.bank_date,
          o.val_date,
          o.kv,
          ROUND (o.s / 100, 2),
          ROUND (fb.s / 100, 2),
          o.details,
          o.oper_type,
          (SELECT type_name
             FROM cim_operation_types
            WHERE type_id = o.oper_type),
          o.payment_type,
          (SELECT type_name
             FROM cim_payment_types
            WHERE type_id = o.payment_type),
          1,
          1,
          dn.type_name,
          NULL,
          0,
          0
     FROM cim_fantoms_bound fb,
          cim_fantom_payments o,
          cim_beneficiaries b,
          customer c,
          (SELECT type_name
             FROM cim_types
            WHERE type_id = 1) dn
    WHERE     o.benef_id = b.benef_id
          AND o.rnk = c.rnk
          AND fb.fantom_id = o.fantom_id
          AND fb.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
          AND fb.delete_date IS NULL
          AND fb.direct = 1
          AND fb.contr_id IS NULL;

PROMPT *** Create  grants  V_CIM_OUT_UNBOUND_PAYMENTS ***
grant SELECT                                                                 on V_CIM_OUT_UNBOUND_PAYMENTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_CIM_OUT_UNBOUND_PAYMENTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CIM_OUT_UNBOUND_PAYMENTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_OUT_UNBOUND_PAYMENTS.sql ========
PROMPT ===================================================================================== 
