

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_OPERAPP.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_OPERAPP ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_OPERAPP 
  after insert or update or delete on operapp
  for each row
begin
  if ((inserting or updating)) then
    bars_useradm_utl.add_queue_operapp(:new.codeapp);
  elsif (deleting) then
    bars_useradm_utl.add_queue_operapp(:old.codeapp);
  end if;
end;



/
ALTER TRIGGER BARS.TAIUD_OPERAPP DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_OPERAPP.sql =========*** End *
PROMPT ===================================================================================== 
