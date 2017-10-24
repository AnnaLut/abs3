

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_TELLER_QUEUE_TT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_TELLER_QUEUE_TT ***

  CREATE OR REPLACE TRIGGER BARS.TAU_TELLER_QUEUE_TT 
after update of sos ON BARS.OPER
for each row
 WHEN (
(new.sos in ( 5) and old.sos in (0, 1)) or
(old.sos in ( 5) and new.sos in ( -1))
      ) declare
l_tt tts.tt%type;
l_tell TELLER_STAFF.ID%type;
BEGIN

 begin
 select 1
   into l_tell
   from oper_visa ov,
        teller_staff t

  where
          ov.userid = T.ID
      and ov.status = 2
      and :new.ref=  ov.ref
      and t.status =1
      and t.id = :new.USERID;

 EXCEPTION WHEN NO_DATA_FOUND THEN l_tell:=0;
 end;

 begin
   select tt
    into l_tt
    from TELLER_TT
   where tt = :new.tt;



 if   (:new.sos in ( 5) and :old.sos in (0, 1)) then
      insert into TELLER_QUEUE (ref, MSG_STATUS,STATUS_TELL ) values ( :new.ref, 'NEW',l_tell );
 elsif (:old.sos in ( 5) and :new.sos in ( -1)) then
      insert into TELLER_QUEUE (ref, MSG_STATUS,STATUS_TELL ) values ( :new.ref, 'STORNO',l_tell );
 end if;



 EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
 end;
end;
/
ALTER TRIGGER BARS.TAU_TELLER_QUEUE_TT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_TELLER_QUEUE_TT.sql =========***
PROMPT ===================================================================================== 
