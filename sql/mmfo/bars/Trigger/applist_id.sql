

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/APPLIST_ID.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger APPLIST_ID ***

  CREATE OR REPLACE TRIGGER BARS.APPLIST_ID 
before insert on applist
for each row
begin
    :new.id := s_applist.nextval;
end;
/
ALTER TRIGGER BARS.APPLIST_ID ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/APPLIST_ID.sql =========*** End *** 
PROMPT ===================================================================================== 
