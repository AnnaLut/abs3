

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_OPERLIST2.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_OPERLIST2 ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_OPERLIST2 
  after insert or update or delete on operlist
begin
  bars_useradm_utl.job_queue_oprlstdeps;
end;



/
ALTER TRIGGER BARS.TAIUD_OPERLIST2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_OPERLIST2.sql =========*** End
PROMPT ===================================================================================== 
