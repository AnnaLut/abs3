

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_OPERLIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_OPERLIST ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_OPERLIST 
  after insert or update or delete on operlist
  for each row
begin
  if ((inserting or updating)) then
    bars_useradm_utl.add_queue_oprlstdeps(:new.codeoper);
  elsif (deleting) then
    bars_useradm_utl.add_queue_oprlstdeps(:old.codeoper);
  end if;
end;



/
ALTER TRIGGER BARS.TAIUD_OPERLIST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_OPERLIST.sql =========*** End 
PROMPT ===================================================================================== 
