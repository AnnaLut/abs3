CREATE OR REPLACE FORCE VIEW BARS.V_OW_INST_SUB_PAY
(
   CHAIN_IDT,
   SEQ_NUMBER,
   ST_ID,
   ST_NAME,
   EFF_DATE,
   REP_DATE,
   TOTAL_AMOUNT,
   SUM_PRINC,
   PAID,
   OVERDUE_AMOUNT,
   SUM_INT,
   SUM_FEE
)
AS
   SELECT p.chain_idt,
          p.seq_number,
          d.st_id,
          d.st_name,
          p.eff_date,
          p.rep_date,
          p.total_amount,
          sp.sum_PRINC,
          p.total_amount - p.amount_to_pay AS paid,
          p.overdue_amount,
          sp.sum_int,
          sp.sum_fee
     FROM ow_inst_portions p
          JOIN
          (  SELECT chain_idt,
                    idp,
                    SUM (
                       CASE
                          WHEN code = 'INT' THEN total_amount - amount_to_pay
                          ELSE 0
                       END)
                       AS sum_int,
                    SUM (
                       CASE
                          WHEN code = 'FEE' THEN total_amount - amount_to_pay
                          ELSE 0
                       END)
                       AS sum_fee,
                    SUM (
                       CASE
                          WHEN code = 'PRINCIPAL'
                          THEN
                             total_amount - amount_to_pay
                          ELSE
                             0
                       END)
                       AS sum_PRINC
               FROM ow_inst_sub_p
           GROUP BY chain_idt, idp) sp
             ON p.chain_idt = sp.chain_idt AND p.seq_number = sp.idp
          LEFT JOIN ow_inst_status_dict d ON d.st_sid = p.status;
/
GRANT SELECT ON BARS.V_OW_INST_SUB_PAY TO BARS_ACCESS_DEFROLE;
/