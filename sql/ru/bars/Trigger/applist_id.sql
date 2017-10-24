

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/APPLIST_ID.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger APPLIST_ID ***

  CREATE OR REPLACE TRIGGER BARS.APPLIST_ID 
BEFORE INSERT ON APPLIST
FOR EACH ROW
BEGIN
  :new.id := applistnextid;
END APPLIST_ID;
/
ALTER TRIGGER BARS.APPLIST_ID ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/APPLIST_ID.sql =========*** End *** 
PROMPT ===================================================================================== 
