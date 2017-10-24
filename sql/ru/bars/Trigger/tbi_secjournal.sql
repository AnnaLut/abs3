

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SECJOURNAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SECJOURNAL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SECJOURNAL 
before insert on sec_journal
for each row
begin

    --
    -- Триггер контроля изменений данных offline-отделений
    --
    if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
    end if;

    if (:new.rec_id is null) then
        select s_secjournal.nextval into :new.rec_id from dual;
    end if;
end;
/
ALTER TRIGGER BARS.TBI_SECJOURNAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SECJOURNAL.sql =========*** End 
PROMPT ===================================================================================== 
