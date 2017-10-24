

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_SKRYNKA_ND_SYNC.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_SKRYNKA_ND_SYNC ***

  CREATE OR REPLACE TRIGGER BARS.TIU_SKRYNKA_ND_SYNC 
   AFTER INSERT OR UPDATE
   ON BARS.SKRYNKA_ND
   for each row
DECLARE
BEGIN

update skrynka_sync_queue
set msg_status = 'OUTDATE', msg_time = sysdate
where obj_id = :NEW.ND
and SYNC_TYPE = 'ND'
and msg_status in ('NEW', 'ERROR');


 insert into skrynka_sync_queue (SYNC_TYPE, OBJ_ID, msg_status, msg_time)
   values ('ND',  :NEW.ND, 'NEW', sysdate);

END;
/
ALTER TRIGGER BARS.TIU_SKRYNKA_ND_SYNC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_SKRYNKA_ND_SYNC.sql =========***
PROMPT ===================================================================================== 
