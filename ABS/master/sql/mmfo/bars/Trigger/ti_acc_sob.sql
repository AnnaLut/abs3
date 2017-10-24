

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_ACC_SOB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_ACC_SOB ***

  CREATE OR REPLACE TRIGGER BARS.TI_ACC_SOB 
before insert on acc_sob
for each row
declare
l_id   acc_sob.id%type;
begin

   -- Репликация: Если изменения пришли из удаленной БД, то ничего не делаем
   if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
   end if;


   --
   -- Модифицировано для поддержки уникальности идентификатора
   -- при наличии распределенных БД
   --
   select s_acc_sob.nextval into l_id from dual;

   --l_id := l_id * 1000 + to_number(sys_context('bars_context', 'db_id'));
   :new.id := l_id;
   --
   --

end;





/
ALTER TRIGGER BARS.TI_ACC_SOB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_ACC_SOB.sql =========*** End *** 
PROMPT ===================================================================================== 
