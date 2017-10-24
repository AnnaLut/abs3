

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_STAFFCHK_BIS.sql =========*** Ru
PROMPT ===================================================================================== 
begin
  execute immediate 'DROP TRIGGER BARS.TBI_STAFFCHK_BIS';
exception
  when others then
    if sqlcode = -4080 then
      null;
    else
      raise;
    end if;
end;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_STAFFCHK_BIS.sql =========*** En
PROMPT ===================================================================================== 
