

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/AD_REPORTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger AD_REPORTS ***

  CREATE OR REPLACE TRIGGER FINMON.AD_REPORTS 
BEFORE DELETE ON FINMON.REPORTS FOR EACH ROW
begin
 --delete from REPORTS_EXT  where REPID = old.ID;
 --delete from REPORTS_TYPE where    ID = old.ID;
 null;
end;
/
ALTER TRIGGER FINMON.AD_REPORTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/AD_REPORTS.sql =========*** End **
PROMPT ===================================================================================== 
