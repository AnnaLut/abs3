

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/View/V_PFU_FILE_KVIT1.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PFU_FILE_KVIT1 ***

  CREATE OR REPLACE FORCE VIEW PFU.V_PFU_FILE_KVIT1 ("ENV_ID", "FILE_ID", "FILE_NAME", "PAYMENT_DATE", "COUNT_LINES", "SUM", "STATE") AS 
  select tab.envelope_request_id as "ENV_ID",
       tab.id                  as "FILE_ID",
       tab.file_name           as "FILE_NAME",
       tab.payment_date        as "PAYMENT_DATE",
       tab.check_lines_count   as "COUNT_LINES",
       tab.check_sum           as "SUM",
       tab.state               as "STATE"
  from table(pfu_utl.get_rec_to_kvit1) tab;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/View/V_PFU_FILE_KVIT1.sql =========*** End **
PROMPT ===================================================================================== 
