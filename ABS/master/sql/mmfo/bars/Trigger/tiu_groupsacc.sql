

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_GROUPSACC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_GROUPSACC ***

  CREATE OR REPLACE TRIGGER BARS.TIU_GROUPSACC 
after insert or update of scope on groups_acc for each row
begin
  --
  -- Сбрасываем глобальный контекст масок доступа к счетам
  -- при изменении области доступа групп счетов
  --
  sec.clear_global_context();
end;




/
ALTER TRIGGER BARS.TIU_GROUPSACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_GROUPSACC.sql =========*** End *
PROMPT ===================================================================================== 
