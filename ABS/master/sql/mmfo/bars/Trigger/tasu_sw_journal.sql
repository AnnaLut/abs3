

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TASU_SW_JOURNAL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TASU_SW_JOURNAL ***

  CREATE OR REPLACE TRIGGER BARS.TASU_SW_JOURNAL 
  AFTER UPDATE OF DATE_PAY ON "BARS"."SW_JOURNAL"
  begin

    for i in (select swref from tmp_sw102_ref)
    loop
        p_swgen102detail(i.swref);
    end loop;

    delete from tmp_sw102_ref;

end;



/
ALTER TRIGGER BARS.TASU_SW_JOURNAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TASU_SW_JOURNAL.sql =========*** End
PROMPT ===================================================================================== 
