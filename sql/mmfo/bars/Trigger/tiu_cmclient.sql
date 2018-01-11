

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CMCLIENT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CMCLIENT ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CMCLIENT 
instead of update ON BARS.CM_CLIENT for each row
begin
   if :new.oper_status not in (2,3,10) then
      raise_application_error (-20000, 'Недопустимый статус операции ' || :new.oper_status);
   end if;
   update cm_client_que
      set datemod     = :new.datemod,
          oper_status = :new.oper_status,
          resp_txt    = :new.resp_txt
    where id = :new.id;
   if :new.oper_status = 3 then
      delete from cm_client_que where id = :new.id;
   end if;
end;
/
ALTER TRIGGER BARS.TIU_CMCLIENT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CMCLIENT.sql =========*** End **
PROMPT ===================================================================================== 
