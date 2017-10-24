

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_GROUPS_STAFF.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_GROUPS_STAFF ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_GROUPS_STAFF 
after insert or update on groups_staff for each row
declare
  l_need_update boolean;
begin
  if :new.approve is not null and :new.approve=1 and :new.revoked is null then
      l_need_update := true;
      if :new.adate1 is not null then
        sec_ctx.set_sec_ctx_que(:new.idu, :new.adate1);
        l_need_update := false;
      end if;
      if :new.adate2 is not null then
        sec_ctx.set_sec_ctx_que(:new.idu, :new.adate2);
        l_need_update := false;
      end if;
      if :new.rdate1 is not null then
        sec_ctx.set_sec_ctx_que(:new.idu, :new.rdate1);
        l_need_update := false;
      end if;
      if :new.rdate2 is not null then
        sec_ctx.set_sec_ctx_que(:new.idu, :new.rdate2);
        l_need_update := false;
      end if;
      if l_need_update then
        sec_ctx.set_sec_ctx_que(:new.idu);
      end if;
  end if;
end;
/
ALTER TRIGGER BARS.TAIU_GROUPS_STAFF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_GROUPS_STAFF.sql =========*** E
PROMPT ===================================================================================== 
