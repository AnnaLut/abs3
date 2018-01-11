

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STO_FORMED_ORDER_KP190_V_MY.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view STO_FORMED_ORDER_KP190_V_MY ***

  CREATE OR REPLACE FORCE VIEW BARS.STO_FORMED_ORDER_KP190_V_MY ("REGISTRATION_DATE", "NMK", "RNK", "USER_ID", "USER_ORD_CRT", "REG_DATE_CHR", "BRANCH", "PAYMENT_FREQUENCY", "KOL_DAY", "START_DATE", "STOP_DATE", "VAL_PAYER", "PAYER_ACC", "RECEIVER_ACCOUNT", "RECEIVER_NAME", "RECEIVER_EDRPOU", "AMOUNT", "PURPOSE_ORD", "STATE") AS 
  SELECT /*View for report'–еЇстр оформленних доручень за пер≥од',changed_date = '14.04.2015'*/
         NVL (TRUNC (o.registration_date), o.start_date)
             AS registration_date,
          c.nmk,
          c.rnk,
          o.user_id,
          (SELECT fio
             FROM staff$base
            WHERE id = o.user_id)
             AS user_ord_crt,
          TO_CHAR (o.registration_date, 'dd.mm.yyyy') AS reg_date_chr,
          o.branch,
          (SELECT f.name
             FROM freq f
            WHERE f.freq = o.payment_frequency)
             AS payment_frequency,
            TO_DATE (o.stop_date, 'DD\MM\YYYY')
          - TO_DATE (o.start_date, 'DD\MM\YYYY')
             AS kol_day,
          TO_CHAR (o.start_date, 'dd/mm/yyyy') AS start_date,
          NVL (TO_CHAR (o.stop_date, 'dd/mm/yyyy'), '01/01/2999')
             AS stop_date,
          a.kv val_payer,
          a.nls payer_acc,
          CASE
             WHEN o.order_type_id = 1 THEN sep.receiver_account
             WHEN o.order_type_id = 2 THEN sbonf.receiver_account
             WHEN o.order_type_id = 3 THEN sp.receiver_account
             WHEN o.order_type_id = 4 THEN sp.receiver_account
             ELSE NULL
          END
             AS receiver_account,
          CASE
             WHEN o.order_type_id = 1 THEN sep.receiver_name
             WHEN o.order_type_id = 2 THEN sbonf.receiver_name
             WHEN o.order_type_id = 3 THEN sp.receiver_name
             WHEN o.order_type_id = 4 THEN sp.receiver_name
             ELSE NULL
          END
             AS receiver_name,
          CASE
             WHEN o.order_type_id = 1 THEN sep.receiver_edrpou
             WHEN o.order_type_id = 2 THEN sbonf.receiver_edrpou
             WHEN o.order_type_id = 3 THEN sp.receiver_edrpou
             WHEN o.order_type_id = 4 THEN sp.receiver_edrpou
             ELSE NULL
          END
             AS receiver_edrpou,
          CASE
             WHEN o.order_type_id = 1
             THEN
                TO_CHAR (sep.regular_amount, 'FM9999999990.00')
             WHEN o.order_type_id = 2
             THEN
                TO_CHAR (sbonf.regular_amount, 'FM9999999990.00')
             WHEN o.order_type_id = 3
             THEN
                CASE
                   WHEN    sbonc.regular_amount IS NULL
                        OR sbonc.regular_amount = 0
                   THEN
                         'не ф≥ксована, але не б≥льше '
                      || TO_CHAR (sbonc.ceiling_amount, 'FM9999999990.00')
                   ELSE
                      TO_CHAR (sbonc.regular_amount, 'FM9999999990.00')
                END
             WHEN o.order_type_id = 4
             THEN
                TO_CHAR (sbonnc.regular_amount, 'FM9999999990.00')
             ELSE
                NULL
          END
             AS amount,
          CASE
             WHEN o.order_type_id = 1 THEN sep.purpose
             WHEN o.order_type_id = 2 THEN sbonf.purpose
             ELSE NULL
          END
             AS purpose_ord,
          O.STATE
     FROM bars.sto_order o,
          bars.accounts a,
          bars.customer c,
          ---
          bars.sto_sep_order sep,
          bars.sto_sbon_order_free sbonf,
          bars.sto_sbon_order_contr sbonc,
          bars.sto_sbon_order_no_contr sbonnc,
          ---
          bars.sto_product p,
          bars.sto_sbon_product sp
    WHERE     o.cancel_date IS NULL
          AND a.acc = o.payer_account_id
          AND c.rnk = a.rnk
          AND sep.id(+) = o.id
          AND sbonf.id(+) = o.id
          AND sbonc.id(+) = o.id
          AND sbonnc.id(+) = o.id
          AND p.id(+) = o.product_id
          AND sp.id(+) = p.id;

PROMPT *** Create  grants  STO_FORMED_ORDER_KP190_V_MY ***
grant SELECT                                                                 on STO_FORMED_ORDER_KP190_V_MY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_FORMED_ORDER_KP190_V_MY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STO_FORMED_ORDER_KP190_V_MY.sql =======
PROMPT ===================================================================================== 
