
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/type/t_sync_docs.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARSAQ.T_SYNC_DOCS as object
  ( bank_ref     		number,
    doc_id       		integer,
    status_id    		number,
    status_change_time  date,
    pdat                date,
    back_reason  		varchar2(220))
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/type/t_sync_docs.sql =========*** End *** 
 PROMPT ===================================================================================== 
 