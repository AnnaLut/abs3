

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_TMP_PRIOCOM_NBS_LIST.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_TMP_PRIOCOM_NBS_LIST ***

  CREATE OR REPLACE TRIGGER BARS.TAI_TMP_PRIOCOM_NBS_LIST 
  AFTER INSERT ON "BARS"."TMP_PRIOCOM_NBS_LIST"
  REFERENCING FOR EACH ROW
  begin
    priocom_audit.trace('insert into tmp_priocom_nbs_list(nbs) values('''||nvl(:new.nbs,'NULL')||''')');
end;



/
ALTER TRIGGER BARS.TAI_TMP_PRIOCOM_NBS_LIST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_TMP_PRIOCOM_NBS_LIST.sql =======
PROMPT ===================================================================================== 
