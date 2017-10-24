

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_DEAL_UPDATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPU_DEAL_UPDATE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPU_DEAL_UPDATE 
before insert on bars. dpu_deal_update for each row
begin

   -- Репликация: Если изменения пришли из удаленной БД, то ничего не делаем
   if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
   end if;

   select s_dpu_deal_update.nextval into :new.idu from dual;

   --
   -- Модифицировано для поддержки уникальности идентификатора
   -- при наличии распределенных БД
   --
   :new.idu := get_id_ddb(:new.idu);

end;
/
ALTER TRIGGER BARS.TBI_DPU_DEAL_UPDATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPU_DEAL_UPDATE.sql =========***
PROMPT ===================================================================================== 
