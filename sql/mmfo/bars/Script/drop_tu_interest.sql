PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_INTEREST.sql =========*** Ru
PROMPT ===================================================================================== 
begin
  execute immediate 'DROP TRIGGER BARS.TU_INTEREST';
exception
  when others then
    if sqlcode = -4080 then
      null;
    else
      raise;
    end if;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_INTEREST.sql =========*** En
PROMPT ===================================================================================== 
