

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBD_DPT_DEPOSIT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBD_DPT_DEPOSIT ***

  CREATE OR REPLACE TRIGGER BARS.TBD_DPT_DEPOSIT 
BEFORE DELETE ON dpt_deposit
FOR EACH ROW
BEGIN
    --
    -- Триггер контроля изменений данных offline-отделений
    --
    if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
    end if;

  -- очитка доп.реквизитов вклада
  DELETE FROM dpt_depositw WHERE dpt_id = :OLD.deposit_id;
END;
/
ALTER TRIGGER BARS.TBD_DPT_DEPOSIT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBD_DPT_DEPOSIT.sql =========*** End
PROMPT ===================================================================================== 
