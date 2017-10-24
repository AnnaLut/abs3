

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_CASHNBS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_CASHNBS ***

  CREATE OR REPLACE TRIGGER BARS.TAI_CASHNBS 
after insert or delete or update on cash_nbs
for each row
declare
   l_txt varchar2(200);
begin
   if inserting then
      bars_audit.info('cash_nbs: обновление справочника CASH_NBS. Вставка записи: '||:new.nbs||'('||:new.ob22||')');
   else
       if deleting then
           bars_audit.info('cash_nbs: обновление справочника CASH_NBS. Удаление записи: '||:old.nbs||'('||:old.ob22||')');
       else
           bars_audit.info('cash_nbs: обновление справочника CASH_NBS. '||:old.nbs||'->'||:new.nbs||'('||:old.ob22||'->'||:new.ob22||')');
       end if;
   end if;
end;
/
ALTER TRIGGER BARS.TAI_CASHNBS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_CASHNBS.sql =========*** End ***
PROMPT ===================================================================================== 
