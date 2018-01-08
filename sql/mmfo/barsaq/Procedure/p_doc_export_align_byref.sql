

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Procedure/P_DOC_EXPORT_ALIGN_BYREF.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_DOC_EXPORT_ALIGN_BYREF ***

  CREATE OR REPLACE PROCEDURE BARSAQ.P_DOC_EXPORT_ALIGN_BYREF (p_ref in number)
as 
begin
    for c in (select * from v_doc_statuses where ref=p_ref)
    loop 
        update doc_export set status_id=c.bars_status_id, bank_back_reason=c.back_reason, status_change_time=c.change_time where doc_id=c.doc_id;
        update ibank.v_doc_export set status_id=c.bars_status_id, bank_back_reason=c.back_reason, status_change_time=c.change_time where doc_id=c.doc_id; 
    end loop; 
    commit;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Procedure/P_DOC_EXPORT_ALIGN_BYREF.sql ===
PROMPT ===================================================================================== 
