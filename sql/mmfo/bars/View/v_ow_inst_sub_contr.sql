CREATE OR REPLACE FORCE VIEW BARS.V_OW_INST_SUB_CONTR
(
   CHAIN_IDT,
   ND,
   ST_ID,
   ST_NAME,
   TOTAL_AMOUNT,
   AMOUNT_TO_PAY,
   TENOR,
   PAID_PARTS,
   WAITING_PARTS,
   OVD_PARTS,
   OVD_PARTS_SUM,
   SUB_INT_RATE,
   EFF_RATE,
   SUB_FEE_RATE,
   POSTING_DATE,
   PAY_B_DATE,
   END_DATE_P,
   END_DATE_F,
   OVD_90_DAYS
)
AS
   SELECT t.chain_idt,
          t.nd,
          d.st_id,
          d.st_name,
          t.total_amount,
          t.amount_to_pay,
          t.tenor,
          p.paid_parts,
          p.waiting_parts,
          p.ovd_parts,
          p.OVD_PARTS_SUM,
          t.sub_int_rate,
          t.eff_rate,
          t.sub_fee_rate,
          t.posting_date,
          t.pay_b_date,
          t.end_date_p,
          t.end_date_f,
          t.ovd_90_days
     FROM ow_inst_totals t
          LEFT JOIN
          (  SELECT chain_idt,
                    COUNT (CASE WHEN p.status = 'PAID' THEN 1 ELSE NULL END)
                       AS paid_parts,
                    COUNT (CASE WHEN p.status = 'WAITING' THEN 1 ELSE NULL END)
                       AS waiting_parts,
                    COUNT (CASE WHEN p.status = 'OVD' THEN 1 ELSE NULL END)
                       AS ovd_parts,
                    SUM (
                       CASE
                          WHEN p.status = 'OVD' THEN p.overdue_amount
                          ELSE 0
                       END)
                       AS OVD_PARTS_SUM
               FROM ow_inst_portions p
           GROUP BY chain_idt) p
             ON p.chain_idt = t.chain_idt
          LEFT JOIN ow_inst_status_dict d ON d.st_sid = t.status;
/
GRANT SELECT ON BARS.V_OW_INST_SUB_CONTR TO BARS_ACCESS_DEFROLE;
/