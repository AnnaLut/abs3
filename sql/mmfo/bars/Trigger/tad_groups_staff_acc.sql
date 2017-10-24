

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAD_GROUPS_STAFF_ACC.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAD_GROUPS_STAFF_ACC ***

  CREATE OR REPLACE TRIGGER BARS.TAD_GROUPS_STAFF_ACC 
after delete on groups_staff_acc for each row
begin
  for c in (select idu from groups_staff where idg=:old.idg) loop
    sec_ctx.set_sec_ctx_que(c.idu);
  end loop;
end;

/
ALTER TRIGGER BARS.TAD_GROUPS_STAFF_ACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAD_GROUPS_STAFF_ACC.sql =========**
PROMPT ===================================================================================== 
