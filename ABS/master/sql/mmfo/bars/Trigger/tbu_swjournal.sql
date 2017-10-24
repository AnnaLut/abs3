

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_SWJOURNAL.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_SWJOURNAL ***

  CREATE OR REPLACE TRIGGER BARS.TBU_SWJOURNAL 
  BEFORE UPDATE OF DATE_PAY ON "BARS"."SW_JOURNAL"
  begin

    delete from tmp_sw102_ref;

end;



/
ALTER TRIGGER BARS.TBU_SWJOURNAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_SWJOURNAL.sql =========*** End *
PROMPT ===================================================================================== 
