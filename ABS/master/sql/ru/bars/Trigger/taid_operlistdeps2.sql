

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAID_OPERLISTDEPS2.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAID_OPERLISTDEPS2 ***

  CREATE OR REPLACE TRIGGER BARS.TAID_OPERLISTDEPS2 
  after insert or delete on operlist_deps
begin
  bars_useradm_utl.job_queue_oprlstdeps;
end;
/
ALTER TRIGGER BARS.TAID_OPERLISTDEPS2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAID_OPERLISTDEPS2.sql =========*** 
PROMPT ===================================================================================== 
