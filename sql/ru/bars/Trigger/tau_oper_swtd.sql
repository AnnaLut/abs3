

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_SWTD.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_SWTD ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPER_SWTD 
after update of sos on oper
for each row
 WHEN (nvl(old.sos, 0) = 0 and new.sos = 1 and instr(new.d_rec, '#fMT') != 0) begin

    if (:new.mfoa = gl.aMFO) then
        bars_swift_msg.docmsg_document_vldlistadd(:new.ref);
    end if;

end;
/
ALTER TRIGGER BARS.TAU_OPER_SWTD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_SWTD.sql =========*** End *
PROMPT ===================================================================================== 
