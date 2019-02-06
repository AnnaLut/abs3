--
-- V_LCS_CLIENT_TRANSFERS  (View)
--

CREATE OR REPLACE FORCE VIEW BARS.V_LCS_CLIENT_TRANSFERS
(
   CODE_IN_SRC1,
   TRANS_CODE,
   NAME,
   SRC_TRANS_ID,
   VAL_NAME,
   SM,
   S_EQ,
   STATUS,
   CRT_DATE,
   FIO,
   DOC,
   DOC_TYPE_ID,
   DOC_TYPE,
   DOC_SERIES,
   DOC_NUMBER,
   CASH,
   LITER_CODE,
   RECIPIENT,
   PURPOSE
)
AS
   SELECT b.code_in_src1,
          t.trans_code,
          ls.name,
          t.src_trans_id,
          val.name val_name,
          ROUND (t.s / 100, 2) AS sm,
          ROUND (t.s_equivalent / 100, 2) AS s_eq,
          DECODE (t.status_id,
                  'NEW', 'Новий',
                  'APPROVED', 'Підтверджений',
                  'CANCELED', 'Скасовано')
             AS status,
          t.crt_date,
          t.fio,
          dt.name || ' ' || t.doc_series || ' ' || t.doc_number AS doc,
          t.doc_type_id,
          dt.name doc_type,
          t.doc_series,
          t.doc_number,
          DECODE (t.cash_acc_flag,  1, 'Ні',  0, 'Так') AS cash,
          val.lcv liter_code,
          t.recipient,
          t.purpose
     FROM lcs_transactions t,
          lcs_branches b,
          tabval$global val,
          lcs_doc_types dt,
          lcs_sources ls
    WHERE     t.branch_id = b.id
          AND val.kv = t.currency_code
          AND dt.id = t.doc_type_id
          AND t.src_id = ls.id;


GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_LCS_CLIENT_TRANSFERS TO BARS_ACCESS_DEFROLE;

GRANT DELETE, INSERT, SELECT, UPDATE ON BARS.V_LCS_CLIENT_TRANSFERS TO START1;

GRANT SELECT ON BARS.V_LCS_CLIENT_TRANSFERS TO WR_REFREAD;