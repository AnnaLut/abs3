

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/View/V_DOC_EXPORT_STREAMS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOC_EXPORT_STREAMS ***

  CREATE OR REPLACE FORCE VIEW BARSAQ.V_DOC_EXPORT_STREAMS ("DOC_ID", "DOC_XML", "BANK_ID", "TYPE_ID", "STATUS_ID", "STATUS_CHANGE_TIME", "BANK_ACCEPT_DATE", "BANK_REF", "BANK_BACK_DATE", "BANK_BACK_REASON", "BANK_BACK_REASON_AUX", "BANK_SYSERR_DATE", "BANK_SYSERR_MSG") AS 
  select doc_id,doc_xml,bank_id,type_id,status_id,status_change_time,bank_accept_date,bank_ref,bank_back_date,bank_back_reason,bank_back_reason_aux,bank_syserr_date,bank_syserr_msg from doc_export;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/View/V_DOC_EXPORT_STREAMS.sql =========***
PROMPT ===================================================================================== 
