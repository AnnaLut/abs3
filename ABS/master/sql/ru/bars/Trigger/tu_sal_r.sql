

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_SAL_R.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_SAL_R ***

  CREATE OR REPLACE TRIGGER BARS.TU_SAL_R 
before insert or update on accounts
for each row
begin

   -- Репликация: Если это обновление, то ничего не делаем
   if (dbms_mview.i_am_a_refresh = true) then
       return;
   end if;

   if (dbms_reputil.from_remote = true) then
       gl.bDate := :new.bdate;
   else
       :new.bdate := gl.bDate;
   end if;


end;
/
ALTER TRIGGER BARS.TU_SAL_R ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_SAL_R.sql =========*** End *** ==
PROMPT ===================================================================================== 
