

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_VISA.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OPER_VISA ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OPER_VISA 
before insert on oper_visa
for each row
declare bars number;
begin

   -- Репликация: Если изменения пришли из удаленной БД, то ничего не делаем
   if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
   end if;


    select s_visa.nextval into bars from dual;
    :new.sqnc := bars;

   --
   -- Модифицировано для поддержки уникальности идентификатора
   -- при наличии распределенных БД
   --
   :new.sqnc := get_id_ddb(:new.sqnc);
   --
   --
end;
/
ALTER TRIGGER BARS.TBI_OPER_VISA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_VISA.sql =========*** End *
PROMPT ===================================================================================== 
