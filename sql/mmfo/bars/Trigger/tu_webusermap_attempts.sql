

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_WEBUSERMAP_ATTEMPTS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_WEBUSERMAP_ATTEMPTS ***

  CREATE OR REPLACE TRIGGER BARS.TU_WEBUSERMAP_ATTEMPTS 
before update of attempts on web_usermap
for each row
declare
    l_attempts number(4);
BEGIN

    --
    -- Триггер контроля изменений данных offline-отделений
    --
    if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
    end if;

    select to_number(val)
    into l_attempts
    from bars.web_barsconfig
    where key = 'CustomAuthentication.Password.Attempts';

    if (:NEW.attempts >= l_attempts) then
       :NEW.blocked := 1;
       :NEW.attempts := 0;
    end if;
END tu_webusermap_attempts;




/
ALTER TRIGGER BARS.TU_WEBUSERMAP_ATTEMPTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_WEBUSERMAP_ATTEMPTS.sql =========
PROMPT ===================================================================================== 
