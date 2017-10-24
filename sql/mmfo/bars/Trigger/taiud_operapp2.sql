

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_OPERAPP2.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_OPERAPP2 ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_OPERAPP2 
  after insert or update or delete on operapp
begin
  bars_useradm_utl.job_queue_operapp;
end;



/
ALTER TRIGGER BARS.TAIUD_OPERAPP2 DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_OPERAPP2.sql =========*** End 
PROMPT ===================================================================================== 
