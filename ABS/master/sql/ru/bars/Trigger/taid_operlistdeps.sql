

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAID_OPERLISTDEPS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAID_OPERLISTDEPS ***

  CREATE OR REPLACE TRIGGER BARS.TAID_OPERLISTDEPS 
  after insert or delete on operlist_deps
  for each row
begin
  if (inserting) then
    bars_useradm_utl.add_queue_oprlstdeps(:new.id_child);
  else
    bars_useradm_utl.add_queue_oprlstdeps(:old.id_child);
    bars_useradm_utl.add_queue_oprlstdeps(:old.id_parent);
  end if;
end;
/
ALTER TRIGGER BARS.TAID_OPERLISTDEPS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAID_OPERLISTDEPS.sql =========*** E
PROMPT ===================================================================================== 
