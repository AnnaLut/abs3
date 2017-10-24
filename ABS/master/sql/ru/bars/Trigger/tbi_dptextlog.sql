

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPTEXTLOG.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPTEXTLOG ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPTEXTLOG 
before insert on dpt_extension_log
for each row
begin


   -- Репликация: Если изменения пришли из удаленной БД, то ничего не делаем
   if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
   end if;

   if (:new.idupd is null) then
       select s_dptextlog.nextval into :new.idupd from dual;
   end if;

   --
   -- Модифицировано для поддержки уникальности идентификатора
   -- при наличии распределенных БД
   --
   :new.idupd := get_id_ddb(:new.idupd);

end;
/
ALTER TRIGGER BARS.TBI_DPTEXTLOG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPTEXTLOG.sql =========*** End *
PROMPT ===================================================================================== 
