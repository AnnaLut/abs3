-- Start of DDL Script for View BARS.V_SW_GPI_STATUSES
-- Generated 28.11.2018 16:20:58 from BARS@COBUSUPABS_DEV_MMFO_DB

CREATE OR REPLACE VIEW v_sw_gpi_statuses (
   ref,
   mt103,
   io_ind_103,
   swref_103,
   date_input_103,
   date_output_103,
   vdate_103,
   sender_103,
   receiver_103,
   payer_103,
   payee_103,
   sender_account,
   amount,
   currency,
   sti,
   uetr,
   status_code,
   status_description )
AS
SELECT   q.REF,
         j.mt AS mt103,
         j.io_ind AS io_ind_103,
         q.swref AS swref_103,
         j.date_in AS date_input_103,
         j.date_out AS date_output_103,
         j.vdate AS vdate_103,
         j.sender AS sender_103,
         j.receiver AS receiver_103,
         j.payer AS payer_103,
         j.payee AS payee_103,
         (SELECT REGEXP_replace (VALUE, '(/*)([^[:cntrl:]]+)(.*)' ,'\2',1,1,'n')
          FROM   sw_operw w
          WHERE  w.swref = q.swref AND w.tag = 50)
             sender_account,
         j.amount / 100 AS amount,
         j.currency,
         j.sti,
         j.uetr,

         s.VALUE AS status_code,
         s.description AS status_description
FROM     sw_oper_queue q
         INNER JOIN sw_journal j
             ON j.swref = q.swref
         INNER JOIN sw_statuses s
             ON q.status = s.id
         LEFT JOIN oper o
             ON o.REF = q.REF
---  left join sw_journal j2 on j2.swref=q.swref_199

WHERE    q.swref_199 = (SELECT MAX (swref_199)
                        FROM   sw_oper_queue qq
                        WHERE  qq.swref = q.swref)
/

-- Grants for View
GRANT SELECT ON v_sw_gpi_statuses TO bars_access_defrole
/

-- End of DDL Script for View BARS.V_SW_GPI_STATUSES

