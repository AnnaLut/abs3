

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TA$RP_SOCTRUSTEE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TA$RP_SOCTRUSTEE ***

  CREATE OR REPLACE TRIGGER BARS.TA$RP_SOCTRUSTEE 
after insert or update or delete ON BARS.SOCIAL_TRUSTEE for each row
begin
    -- 
    -- Триггер контроля изменений данных offline-отделений
    -- 
    if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
    end if;

    if (inserting) then
        bars_repl_ddbs.check_online_branch(:new.branch);
    else
        bars_repl_ddbs.check_online_branch(:old.branch);
    end if;
end; 




/
ALTER TRIGGER BARS.TA$RP_SOCTRUSTEE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TA$RP_SOCTRUSTEE.sql =========*** En
PROMPT ===================================================================================== 
