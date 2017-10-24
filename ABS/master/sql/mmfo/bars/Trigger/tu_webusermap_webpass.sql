

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_WEBUSERMAP_WEBPASS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_WEBUSERMAP_WEBPASS ***

  CREATE OR REPLACE TRIGGER BARS.TU_WEBUSERMAP_WEBPASS 
before update of webpass on web_usermap
for each row
BEGIN

    --
    -- Триггер контроля изменений данных offline-отделений
    --
    if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
    end if;

    :NEW.CHGDATE := sysdate;

END tu_webusermap_webpass;




/
ALTER TRIGGER BARS.TU_WEBUSERMAP_WEBPASS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_WEBUSERMAP_WEBPASS.sql =========*
PROMPT ===================================================================================== 
