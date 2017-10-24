

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_PARAMS_BANKDATE_DEPDB.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_PARAMS_BANKDATE_DEPDB ***

  CREATE OR REPLACE TRIGGER BARS.TAU_PARAMS_BANKDATE_DEPDB 
  AFTER UPDATE ON "BARS"."DEPRICATED_PARAMS$BASE"
  REFERENCING FOR EACH ROW
declare
  l_job           binary_integer;
  l_what       varchar2(128);
begin
  if :new.par='BANKDATE' and :old.val<>:new.val then
    l_what := 'begin bars.set_external_bankdate@depdb.ho.obu('''||:new.val||'''); end;';
    sys.dbms_job.submit(job => l_job, what => l_what, next_date => SYSDATE);
  end if;
end;


/
ALTER TRIGGER BARS.TAU_PARAMS_BANKDATE_DEPDB DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_PARAMS_BANKDATE_DEPDB.sql ======
PROMPT ===================================================================================== 
