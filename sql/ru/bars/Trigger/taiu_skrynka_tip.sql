

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_SKRYNKA_TIP.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_SKRYNKA_TIP ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_SKRYNKA_TIP 
AFTER INSERT OR UPDATE
ON SKRYNKA_TIP
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
BEGIN

update skrynka_sync_queue
set msg_status = 'OUTDATE', msg_time = sysdate
where obj_id = :New.O_SK
and SYNC_TYPE = 'TIP'
and msg_status in ('NEW', 'ERROR');

insert into SKRYNKA_sync_queue(sync_type, obj_id, msg_status, msg_time )
values('TIP', :New.O_SK , 'NEW', sysdate );


   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END ;
/
ALTER TRIGGER BARS.TAIU_SKRYNKA_TIP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_SKRYNKA_TIP.sql =========*** En
PROMPT ===================================================================================== 
