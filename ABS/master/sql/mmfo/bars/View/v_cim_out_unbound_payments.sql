CREATE OR REPLACE VIEW V_CIM_OUT_UNBOUND_PAYMENTS
(ref, cust_rnk, cust_okpo, cust_nmk, cust_nd, benef_nmk, acc, nls, pdat, vdat, kv, total_sum, unbound_sum, nazn, op_type_id, op_type, pay_type, pay_type_name, is_vised, direct, direct_name, tt, background_color, attachments_count)
AS
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
          NVL ( (SELECT w1.VALUE
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
          NVL ( (SELECT w1.VALUE
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
          NULL
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
comment on table V_CIM_OUT_UNBOUND_PAYMENTS is 'Нерозібрані вихідні (імпортні) платежі v 1.00.02';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.REF is 'Референс платежу';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.CUST_RNK is 'Реєстраційний номер клієнта';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.CUST_OKPO is 'ЄДРПОУ клієнта';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.CUST_NMK is 'Назва клієнта';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.CUST_ND is '№ договору з клієнтом';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.BENEF_NMK is 'Найменування контрагента';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.ACC is 'ACC рахунку';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.NLS is 'Рахунок';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.PDAT is 'Дата створення локумента';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.VDAT is 'Дата валютування';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.KV is 'Валюта платежу';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.TOTAL_SUM is 'Сума платежу';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.UNBOUND_SUM is 'Частина суми платежу, не прив’язана до жодного з контрактів';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.NAZN is 'Призначення платежу';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.OP_TYPE is 'Тип операції (додатковий реквізит)';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.PAY_TYPE is 'Тип, 0-раніше не прив''язані, 1-відв''язані реальні, 2-відв''язані фантоми';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.PAY_TYPE_NAME is 'Назва типу';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.IS_VISED is 'Признак візи, 0-незавізований,1-завізований';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.DIRECT is 'Напрям платежу 0 - вхідні, 1 - вихідні';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.TT is 'Код операції';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.BACKGROUND_COLOR is 'Колір фону (1 - жовтий, 0 - колір по замовчуванню)';
comment on column V_CIM_OUT_UNBOUND_PAYMENTS.ATTACHMENTS_COUNT is 'Клієнт надав супровідні док. в CORP';


GRANT SELECT ON BARS.V_CIM_OUT_UNBOUND_PAYMENTS TO BARSREADER_ROLE;

GRANT SELECT ON BARS.V_CIM_OUT_UNBOUND_PAYMENTS TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_CIM_OUT_UNBOUND_PAYMENTS TO UPLD;