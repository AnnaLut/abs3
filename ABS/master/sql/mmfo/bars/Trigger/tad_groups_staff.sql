

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAD_GROUPS_STAFF.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAD_GROUPS_STAFF ***

  CREATE OR REPLACE TRIGGER BARS.TAD_GROUPS_STAFF 
after delete on groups_staff for each row
begin
  sec_ctx.set_sec_ctx_que(:old.idu);
end;

/
ALTER TRIGGER BARS.TAD_GROUPS_STAFF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAD_GROUPS_STAFF.sql =========*** En
PROMPT ===================================================================================== 
