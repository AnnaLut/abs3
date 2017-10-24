

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_PB_DPASAB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_PB_DPASAB ***

  CREATE OR REPLACE TRIGGER BARS.TAU_PB_DPASAB 
after update of val on params$base
for each row
 WHEN (
new.par = 'DPA_SAB'
      ) begin
    bars_audit.info('DPA_SAB. user=>' || to_char(user_id) || ' date=>' || to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss') ||
    ' old=>' || :old.val || ' new=>' || :new.val);
end;
/
ALTER TRIGGER BARS.TAU_PB_DPASAB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_PB_DPASAB.sql =========*** End *
PROMPT ===================================================================================== 
