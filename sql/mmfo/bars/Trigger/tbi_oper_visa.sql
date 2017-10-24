

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_VISA.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OPER_VISA ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OPER_VISA 
before insert ON BARS.OPER_VISA 
for each row
declare bars number;
begin
    bars := bars_sqnc.get_nextval('s_visa');
    :new.sqnc := bars;
end;

/
ALTER TRIGGER BARS.TBI_OPER_VISA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_VISA.sql =========*** End *
PROMPT ===================================================================================== 
