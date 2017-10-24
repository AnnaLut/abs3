

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_CUSTOMER_UPD.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_CUSTOMER_UPD ***

  CREATE OR REPLACE TRIGGER BARS.TI_CUSTOMER_UPD 
before insert on customer_update
for each row
begin

   -- Репликация: Если изменения пришли из удаленной БД, то ничего не делаем
   if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
   end if;

  :new.doneby:= user_name;

end;
/
ALTER TRIGGER BARS.TI_CUSTOMER_UPD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_CUSTOMER_UPD.sql =========*** End
PROMPT ===================================================================================== 
