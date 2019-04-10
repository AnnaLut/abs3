PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_sw_gpi_statuses_mt199.sql =========*** Run ***
PROMPT ===================================================================================== 



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
SELECT j.uetr,
       jj.swref AS REF,
       j.mt,
       s.VALUE  AS status,
       s.description  AS status_description,
       j.sender,
       j.receiver,
       j.currency,
       j.amount / 100 AS amount,
       jj.date_out
FROM   sw_journal j
         JOIN sw_journal jj
           ON jj.uetr = j.uetr AND jj.mt =  decode (j.mt, 103, 199, 299)  and jj.io_ind <> j.io_ind
       LEFT JOIN sw_operw ow
           ON ow.swref = jj.swref AND ow.tag = 79
       LEFT JOIN sw_statuses s
           ON s.VALUE = REGEXP_REPLACE (ow.VALUE,   '(^//[^/]+//?)([[:print:]]+)(.+)',  '\2',   1,   1,  'n')
WHERE  j.mt in ( 103, 202)
order by jj.swref
/

-- Grants for View
GRANT SELECT ON v_sw_gpi_statuses_mt199 TO bars_access_defrole
/


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_sw_gpi_statuses_mt199.sql=========*** End *** ======
PROMPT ===================================================================================== 

