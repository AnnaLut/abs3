

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_STAFF_SUBSTITUTE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_STAFF_SUBSTITUTE ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_STAFF_SUBSTITUTE 
after insert or update on staff_substitute for each row
declare
  l_need_update boolean;
begin
  l_need_update := true;
  if :new.date_start is not null then
    create_job_update_sec_ctx(:new.id_who,  :new.date_start);
    create_job_update_sec_ctx(:new.id_whom, :new.date_start);
    l_need_update := false;
  end if;
  if :new.date_finish is not null then
    create_job_update_sec_ctx(:new.id_who,  :new.date_finish);
    create_job_update_sec_ctx(:new.id_whom, :new.date_finish);
    l_need_update := false;
  end if;
  if l_need_update then
    create_job_update_sec_ctx(:new.id_who);
    create_job_update_sec_ctx(:new.id_whom);
  end if;
end;
/
ALTER TRIGGER BARS.TAIU_STAFF_SUBSTITUTE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_STAFF_SUBSTITUTE.sql =========*
PROMPT ===================================================================================== 
