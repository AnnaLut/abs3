

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SKRYNKA_SYNC_QUEUE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SKRYNKA_SYNC_QUEUE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SKRYNKA_SYNC_QUEUE 
BEFORE INSERT ON SKRYNKA_sync_queue
FOR EACH ROW

BEGIN
  SELECT S_SKRYNKA_sync_queue.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/
ALTER TRIGGER BARS.TBI_SKRYNKA_SYNC_QUEUE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SKRYNKA_SYNC_QUEUE.sql =========
PROMPT ===================================================================================== 
