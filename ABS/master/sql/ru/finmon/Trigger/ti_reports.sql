

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TI_REPORTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_REPORTS ***

  CREATE OR REPLACE TRIGGER FINMON.TI_REPORTS 
BEFORE INSERT ON FINMON.REPORTS FOR EACH ROW
BEGIN
  if (:new.id is null) then
  	 select S_REPORTS.nextval into :new.id from dual;
  end if;
END;
/
ALTER TRIGGER FINMON.TI_REPORTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TI_REPORTS.sql =========*** End **
PROMPT ===================================================================================== 
