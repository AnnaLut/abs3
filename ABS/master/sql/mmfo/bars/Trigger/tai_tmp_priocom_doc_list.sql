

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_TMP_PRIOCOM_DOC_LIST.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_TMP_PRIOCOM_DOC_LIST ***

  CREATE OR REPLACE TRIGGER BARS.TAI_TMP_PRIOCOM_DOC_LIST 
  AFTER INSERT ON "BARS"."TMP_PRIOCOM_DOC_LIST"
  REFERENCING FOR EACH ROW
  begin
    priocom_audit.trace('insert into tmp_priocom_doc_list(docid) values('||nvl(to_char(:new.docid),'NULL')||')');
end;



/
ALTER TRIGGER BARS.TAI_TMP_PRIOCOM_DOC_LIST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_TMP_PRIOCOM_DOC_LIST.sql =======
PROMPT ===================================================================================== 
