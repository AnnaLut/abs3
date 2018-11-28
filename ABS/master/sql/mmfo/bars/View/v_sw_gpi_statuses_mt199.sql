-- Start of DDL Script for View BARS.V_SW_GPI_STATUSES_MT199
-- Generated 27.11.2018 18:18:50 from BARS@COBUSUPABS_DEV_MMFO_DB

CREATE OR REPLACE VIEW v_sw_gpi_statuses_mt199 (
   uetr,
   ref,
   mt,
   status,
   status_description,
   sender,
   receiver,
   currency,
   amount,
   date_out )
AS
SELECT /*+ index (i_swref_swoperque) */
      j  .uetr, swref_199 AS REF, j.mt, s.VALUE AS status,
         s.description AS status_description, j.sender, j.receiver, j.currency,
         j.amount / 100 AS amount, j.date_out
FROM     sw_journal j
         JOIN sw_oper_queue q
             ON q.swref_199 = j.swref
         JOIN sw_statuses s
             ON q.status = s.id
WHERE    j.mt =  199
ORDER BY j.swref
/

-- Grants for View
GRANT SELECT ON v_sw_gpi_statuses_mt199 TO bars_access_defrole
/

-- End of DDL Script for View BARS.V_SW_GPI_STATUSES_MT199

