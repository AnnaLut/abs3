PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/v_sw_gpi_statuses.sql =========*** START
PROMPT ===================================================================================== 

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
SELECT
         bars_swift.get_document_ref (j.swref)  ref,
         j.mt AS mt103,
         j.io_ind AS io_ind_103,
         j.swref AS swref_103,
         j.date_in AS date_input_103,
         j.date_out AS date_output_103,
         j.vdate AS vdate_103,
         j.sender AS sender_103,
         j.receiver AS receiver_103,
         (SELECT regexp_replace (value , '([^[:cntrl:]]+)[[:cntrl:]]+\d?/? *([^[:cntrl:]]*)[[:cntrl:]]+(.*)', '\2', 1,1,'n')  FROM   sw_operw w WHERE  w.swref = j.swref AND w.tag = 50)  AS payer_103,
         nvl( j.payee , (SELECT regexp_replace (value , '([^[:cntrl:]]+)[[:cntrl:]]+\d?/? *([^[:cntrl:]]*)[[:cntrl:]]*(.*)', '\2', 1,1,'n') FROM   sw_operw w  WHERE  w.swref = j.swref AND w.tag = 59)    ) AS payee_103,
         (SELECT  regexp_replace (value , '/([^[:cntrl:]]+?)[[:cntrl:]](.+)', '\1', 1,1,'n')  FROM   sw_operw w WHERE  w.swref = j.swref AND w.tag = 50) as   sender_account,
         j.amount / 100 AS amount,
         j.currency,
         j.sti,
         j.uetr,
         j.statusvalue  as status_code,
         s.DESCRIPTION  as status_description
FROM (
select j.* ,
  (SELECT  MIN( regexp_replace (VALUE, '(^//[^/]+//?)([[:print:]]+)(.+)', '\2',1,1,'n') )
          KEEP (DENSE_RANK FIRST  ORDER BY date_in DESC)
        FROM   sw_journal jj, sw_operw ow
        WHERE      jj.swref = ow.swref
               AND jj.uetr = j.uetr
               AND jj.mt = decode (j.mt, 103, 199, 299)
               --- исключаем странные 199 со статусами INVA/X003, INVA/X002 ...
               and jj.io_ind <> j.io_ind
               AND ow.tag = 79) as statusvalue
from sw_journal j
 where j.mt in (103, 202)
) j left join   sw_statuses s  ON j.statusvalue = s.VALUE
/

-- Grants for View
GRANT SELECT ON v_sw_gpi_statuses TO bars_access_defrole
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/v_sw_gpi_statuses.sql =========*** End
PROMPT ===================================================================================== 



