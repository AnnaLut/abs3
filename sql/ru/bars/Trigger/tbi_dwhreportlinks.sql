

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DWHREPORTLINKS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DWHREPORTLINKS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DWHREPORTLINKS BEFORE INSERT or update ON DWH_REPORT_LINKS FOR EACH ROW
DECLARE
   l_codeapp applist.codeapp%type;
   ern  CONSTANT POSITIVE := 338;
   err  EXCEPTION;
   erm  VARCHAR2(80);

BEGIN


   begin
   select codeapp
     into l_codeapp
     from applist
    where codeapp = :new.module_id;
     :NEW.module_id := l_codeapp;
   exception when no_data_found then
      erm := '0903 - Невірно вказано код АРМу';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   end;


END;
/
ALTER TRIGGER BARS.TBI_DWHREPORTLINKS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DWHREPORTLINKS.sql =========*** 
PROMPT ===================================================================================== 
