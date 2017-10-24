

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_GROUPS_STAFF_ACC.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_GROUPS_STAFF_ACC ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_GROUPS_STAFF_ACC 
after insert or update on groups_staff_acc for each row
begin
  for c in (select idu from groups_staff where idg=:new.idg) loop
    sec_ctx.set_sec_ctx_que(c.idu);
  end loop;
end;
/
ALTER TRIGGER BARS.TAIU_GROUPS_STAFF_ACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_GROUPS_STAFF_ACC.sql =========*
PROMPT ===================================================================================== 
