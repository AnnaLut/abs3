

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBM_DEPOSIT_ACCOUNTS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBM_DEPOSIT_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBM_DEPOSIT_ACCOUNTS ("ID", "CUR_ID", "CUR_CODE", "CUST_ID", "CUST_NAME", "TYPE_ID", "TYPE_NAME", "RATE", "REPLENISH_ACC_NUMBER", "REPLENISH_ACC_NAME", "REPLENISH_ACC_CURRENCY_ID", "REPLENISH_ACC_CURRENCY_CODE", "REPLENISH_TAX_CODE", "REPLENISH_BANK_CODE", "REPLENISH_BANK_NAME", "INTEREST_ACCRUAL", "INTEREST_PAID", "INTEREST_ACC_NUM", "INTEREST_ACC_NAME", "INTEREST_ACC_CUR_ID", "INTEREST_ACC_CUR_CODE", "TRANSFER_BANK_ID", "TRANSFER_ACC_NUM", "TRANSFER_ACC_NAME", "TRANSFER_CUST_CODE", "BALANCE", "BEGIN_DATE", "END_DATE", "BRANCH_ID", "BRANCH_NAME", "TERM_ADD", "TERM_ADD_DATE", "MIN_ADD_SUM", "EXTENSION_ID", "IS_CAPITALIZATION", "MAX_PROLONGATIONS", "IS_PROLONGATION", "IS_MONEY_BOX", "COMMENTS", "IS_REPLENISHED") AS 
  SELECT dpa.dpt_id AS id,
          dpa.dpt_curid AS cur_id,
          dpa.dpt_curcode AS cur_code,
          dpa.cust_id AS cust_id,
          dpa.cust_name AS cust_name,
          dpa.vidd_code AS type_id,
          TRIM (
             REPLACE (
                REPLACE (REPLACE (dpa.vidd_name, dpa.vidd_code, ''),
                         dpa.int_curcode,
                         ''),
                'RUR',
                ''))
             AS type_name,
          dpa.rate AS rate,
          dpa.dpt_accnum as replenish_acc_number,
          dpa.dpt_accname as replenish_acc_name,
          dpa.dpt_curid as replenish_acc_currency_id,
          dpa.dpt_curcode as replenish_acc_currency_code,
          dpa.cust_idcode as replenish_tax_code,
          ad.kf as replenish_bank_code,
          adbb.nb as replenish_bank_name,
          dpa.int_kos AS interest_accrual,
          dpa.int_dos AS interest_paid,
          dpa.int_accnum AS interest_acc_num,
          dpa.int_accname AS interest_acc_name,
          dpa.int_curid AS interest_acc_cur_id,
          dpa.int_curcode AS interest_acc_cur_code,
          dpa.dptrcp_mfo AS transfer_bank_id,
          dpa.dptrcp_acc AS transfer_acc_num,
          dpa.dptrcp_name AS transfer_acc_name,
          dpa.dptrcp_idcode AS transfer_cust_code,
          dpa.dpt_saldo AS balance,
          dpa.dat_begin AS begin_date,
          dpa.dat_end AS end_date,
          dpa.branch_id AS branch_id,
          dpa.branch_name AS branch_name,
          v.term_add AS term_add,
          DECODE (
             v.term_add,
             NVL (v.term_add, 0), TO_DATE (NULL),
               ADD_MONTHS (dpa.dat_begin, TRUNC (v.term_add))
             + TRUNC (MOD (v.term_add, 1)))
             AS term_add_date,
          v.LIMIT AS min_add_sum,
          v.extension_id AS extension_id,
          v.comproc AS is_capitalization,
          NVL (v.term_dubl, 0) AS max_prolongations,
          (CASE
              WHEN     v.fl_dubl = 2
                   AND (SELECT COUNT (1)
                          FROM dpt_extrefusals
                         WHERE dptid = dpa.dpt_id) = 0
              THEN
                 1
              ELSE
                 0
           END)
             AS is_prolongation,
          (CASE
              WHEN dpa.vidd_code IN (216,
                                     217,
                                     218,
                                     174)
              THEN
                 1
              ELSE
                 0
           END)
             AS is_money_box,
          dpa.dpt_comments AS comments,
          (select decode( count(1), 0, 0 , 1)
                from dpt_tts_vidd v,
                     op_rules o,
                     dpt_deposit d
               where v.vidd = d.vidd
                 and v.tt = o.tt
                 and o.tag = 'DPTOP'
                 and o.val = '1'
                 and o.tt like 'DP%'
                 and d.deposit_id = dpa.dpt_id) as is_replenished
     FROM
        v_dpt_portfolio_active dpa
        join dpt_vidd v on (dpa.vidd_code = v.vidd)
        JOIN ACCOUNTS ad ON (ad.ACC = dpa.dpt_accid)
        JOIN BANKS$BASE adbb ON (adbb.mfo = ad.kf)

   UNION ALL

   SELECT d.DPU_ID AS id,
          ad.KV AS cur_id,
          t.LCV AS cur_code,
          d.RNK AS cust_id,
          c.NMK AS cust_name,
          v.VIDD AS type_id,
          v.NAME AS type_name,
          dpt.fproc (d.acc, SYSDATE) AS rate,
          ad.nls as replenish_acc_number,
          ad.nms as replenish_acc_name,
          ad.kv as replenish_acc_currency_id,
          t.lcv as replenish_acc_currency_code,
          adc.okpo as replenish_tax_code,
          ad.kf as replenish_bank_code,
          adbb.nb as replenish_bank_name,
          ai.kos AS interest_accrual,
          ai.dos AS interest_paid,
          ai.nls AS interest_acc_num,
          ai.NMS AS interest_acc_name,
          ai.KV AS interest_acc_cur_id,
          t.LCV AS interest_acc_cur_code,                          -- тимчасово
          d.MFO_D AS transfer_bank_id,
          d.NLS_D AS transfer_acc_num,
          d.NMS_D AS transfer_acc_name,
          c.OKPO AS transfer_cust_code,
          ad.OSTC AS balance,
          d.dat_begin AS begin_date,
          d.dat_end AS end_date,
          d.branch AS branch_id,
          b.name AS branch_name,
          v.TERM_ADD AS TERM_ADD,
          DECODE (
             v.term_add,
             NVL (v.term_add, 0), TO_DATE (NULL),
               ADD_MONTHS (d.dat_begin, TRUNC (v.term_add))
             + TRUNC (MOD (v.term_add, 1) ))
             AS term_add_date,
          v.LIMIT AS min_add_sum,
          0 AS extension_id,                                       -- тимчасово
          v.COMPROC AS is_capitalization,
          0 AS max_prolongations,                                  -- тимчасово
          v.FL_AUTOEXTEND AS is_prolongation,
          0 AS is_money_box,                                     -- ХЗ що це???
          d.COMMENTS AS comments,
		  (select decode( count(1), 0, 0 , 1)
                from dpt_tts_vidd v,
                     op_rules o,
                     dpt_deposit d
               where v.vidd = d.vidd
                 and v.tt = o.tt
                 and o.tag = 'DPTOP'
                 and o.val = '1'
                 and o.tt like 'DP%'
                 and d.deposit_id = d.DPU_ID) as is_replenished
     FROM DPU_DEAL d
          JOIN ACCOUNTS ad ON (ad.ACC = d.ACC)
          JOIN CUSTOMER adc ON (adc.rnk = ad.rnk)
          JOIN BANKS$BASE adbb ON (adbb.mfo = ad.kf)
          JOIN INT_ACCN i ON (i.ACC = d.ACC AND i.ID = 1)
          JOIN ACCOUNTS ai ON (ai.ACC = i.ACRA)
          JOIN CUSTOMER c ON (c.rnk = d.rnk)
          JOIN DPU_VIDD v ON (v.vidd = d.vidd)
          JOIN TABVAL$GLOBAL t ON (t.KV = ad.KV)
          JOIN BRANCH b ON (b.BRANCH = d.BRANCH)
    WHERE d.CLOSED = 0;

PROMPT *** Create  grants  V_MBM_DEPOSIT_ACCOUNTS ***
grant SELECT                                                                 on V_MBM_DEPOSIT_ACCOUNTS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBM_DEPOSIT_ACCOUNTS.sql =========***
PROMPT ===================================================================================== 
