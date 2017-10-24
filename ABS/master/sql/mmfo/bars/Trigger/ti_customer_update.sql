

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_CUSTOMER_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_CUSTOMER_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TI_CUSTOMER_UPDATE 
before insert on customer_update
for each row
declare
  val_   number;
begin

   -- Репликация: Если изменения пришли из удаленной БД, то ничего не делаем
   if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
   end if;

  if :new.idupd is null then
      select bars_sqnc.get_nextval('s_customer_update') into val_ from dual;
      :new.idupd := val_;
  end if;

   --
   -- Модифицировано для поддержки уникальности идентификатора
   -- при наличии распределенных БД
   --
   -- :new.idupd := :new.idupd * 1000 + to_number(sys_context('bars_context', 'db_id'));


end;
/
ALTER TRIGGER BARS.TI_CUSTOMER_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_CUSTOMER_UPDATE.sql =========*** 
PROMPT ===================================================================================== 
