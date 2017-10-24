

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAD_STAFF_SUBSTITUTE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAD_STAFF_SUBSTITUTE ***

  CREATE OR REPLACE TRIGGER BARS.TAD_STAFF_SUBSTITUTE 
after delete on staff_substitute for each row
begin
  create_job_update_sec_ctx(:old.id_who);
  create_job_update_sec_ctx(:old.id_whom);
end;




/
ALTER TRIGGER BARS.TAD_STAFF_SUBSTITUTE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAD_STAFF_SUBSTITUTE.sql =========**
PROMPT ===================================================================================== 
