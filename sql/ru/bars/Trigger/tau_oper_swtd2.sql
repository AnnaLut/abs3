

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_SWTD2.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_SWTD2 ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPER_SWTD2 
after update of sos on oper
for each row
 WHEN (new.sos = 5 and instr(new.d_rec, '#fMT') != 0) begin
    bars_swift.genmsg_notify_listadd(:new.ref);
end tau_oper_swtd2;
/
ALTER TRIGGER BARS.TAU_OPER_SWTD2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_SWTD2.sql =========*** End 
PROMPT ===================================================================================== 
