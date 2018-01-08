

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/STO_FORMED_ORDER_190_V.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view STO_FORMED_ORDER_190_V ***

  CREATE OR REPLACE FORCE VIEW BARS.STO_FORMED_ORDER_190_V ("REGISTRATION_DATE", "NMK", "RNK", "USER_ID", "USER_ORD_CRT", "REG_DATE_CHR", "BRANCH", "BRANCH_CRT_ORD", "BRANCH_ACC_OPEN", "PAYMENT_FREQUENCY", "START_DATE", "STOP_DATE", "HOLIDAY_SHIFT", "VAL_PAYER", "PAYER_ACC", "RECEIVER_ACCOUNT", "RECEIVER_NAME", "RECEIVER_EDRPOU", "AMOUNT", "PURPOSE_ORD") AS 
  SELECT /*View for report'Реєстр оформленних доручень за період',changed_date = '14.04.2015'*/
         NVL(TRUNC (o.registration_date),o.start_date) AS registration_date,
          c.nmk,
          c.rnk,
          o.user_id,
          (SELECT fio
             FROM staff$base
            WHERE id = o.user_id)
             AS user_ord_crt,
          TO_CHAR (o.registration_date, 'dd.mm.yyyy') AS reg_date_chr,
          o.branch,
          (SELECT bp.val
             FROM branch_parameters bp
            WHERE bp.branch = o.branch AND bp.tag = 'NAME_BRANCH')
             AS branch_crt_ord,
          (SELECT bp.val
             FROM branch_parameters bp
            WHERE bp.branch = a.branch AND bp.tag = 'NAME_BRANCH')
             AS branch_acc_open,
          (SELECT f.name
             FROM freq f
            WHERE f.freq = o.payment_frequency)
             AS payment_frequency,
          TO_CHAR (o.start_date, 'dd.mm.yyyy') AS start_date,
          NVL (TO_CHAR (o.stop_date, 'dd.mm.yyyy'),
               'без обмеження')
             AS stop_date,
          CASE o.holiday_shift
             WHEN -1 THEN 'до вихідних'
             WHEN 1 THEN 'після вихідних'
             ELSE ''
          END
             AS holiday_shift,
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
                         'не фіксована, але не більше '
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
             AS purpose_ord
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
          AND sp.id(+) = p.id
   UNION ALL
   SELECT /*данные из страрого модуля, со временем необходимость в этих данных отпадет*/
         TRUNC (d.stmp) AS registration_date,
          c.nmk,
          l.rnk,
          NULL AS user_id,
          NULL AS user_ord_crt,
          TO_CHAR (d.stmp, 'dd.mm.yyyy') AS reg_date_chr,
          l.branch,
          (SELECT bp.val
             FROM branch_parameters bp
            WHERE bp.branch = l.branch AND bp.tag = 'NAME_BRANCH')
             AS branch_crt_ord,
          (SELECT bp.val
             FROM branch_parameters bp
            WHERE bp.branch = a.branch AND bp.tag = 'NAME_BRANCH')
             AS branch_acc_open,
          (SELECT f.name
             FROM freq f
            WHERE f.freq = d.freq)
             AS payment_frequency,
          TO_CHAR (d.dat1, 'dd.mm.yyyy') AS start_date,
          NVL (TO_CHAR (d.dat1, 'dd.mm.yyyy'), 'без обмеження')
             AS stop_date,
          CASE d.wend
             WHEN -1 THEN 'до вихідних'
             WHEN 1 THEN 'після вихідних'
             ELSE ''
          END
             AS holiday_shift,
          d.kva AS val_payer,
          d.nlsa AS payer_acc,
          d.nlsb AS receiver_account,
          d.polu AS receiver_name,
          d.okpo AS receiver_edrpou,
          NVL (TO_CHAR ( (SELECT d.fsum
                            FROM DUAL
                           WHERE REGEXP_LIKE (d.fsum, '^[[:digit:]]+$')),
                        'FM9999999990.00'),
               'формула')
             AS amount,
          d.nazn AS purpose_ord
     FROM sto_lst l,
          sto_det d,
          customer c,
          accounts a
    WHERE c.rnk = l.rnk AND l.ids = d.ids AND d.kva = a.kv AND a.nls = d.nlsa;

PROMPT *** Create  grants  STO_FORMED_ORDER_190_V ***
grant SELECT                                                                 on STO_FORMED_ORDER_190_V to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/STO_FORMED_ORDER_190_V.sql =========***
PROMPT ===================================================================================== 
