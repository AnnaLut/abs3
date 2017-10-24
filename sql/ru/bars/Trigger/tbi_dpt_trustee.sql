

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_TRUSTEE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPT_TRUSTEE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPT_TRUSTEE 
BEFORE INSERT ON BARS.DPT_TRUSTEE FOR EACH ROW
declare
  l_id number;
begin
   -- Репликация: Если изменения пришли из удаленной БД, то ничего не делаем
   if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
   end if;

  if :new.id is null or :new.id = 0 then
     select bars_sqnc.get_nextval('s_dpt_trustee') into l_id from dual;
     :new.id := l_id;
     -- Модифицировано для поддержки уникальности идентификатора
     -- при наличии распределенных БД
     --:new.id := :new.id * 1000 + to_number(sys_context('bars_context', 'db_id'));
  end if;

end;
/
ALTER TRIGGER BARS.TBI_DPT_TRUSTEE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_TRUSTEE.sql =========*** End
PROMPT ===================================================================================== 
