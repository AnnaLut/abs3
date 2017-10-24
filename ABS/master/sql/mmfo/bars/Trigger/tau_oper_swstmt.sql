

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_SWSTMT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_SWSTMT ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPER_SWSTMT 
after update of sos on bars.oper
for each row
    WHEN ( new.sos = 5
 and ( instr(new.d_rec, '#fMT') != 0
    or new.mfoa = new.mfob and (substr(new.nlsa,1,4) in  ('1500', '1600') or substr(new.nlsb,1,4) in ('1500', '1600'))) ) begin
  if ((:new.dk=1 and substr(:new.nlsa,1,4)='1600') or (:new.dk=0 and substr(:new.nlsb,1,4)='1600')) then
    null;
  else
    bars_swift_msg.enqueue_stmt_document(
     p_stmt     => 900,
     p_ref      => :new.ref,
     p_flag     => '',
     p_priority => null );
  end if;
end tau_oper_swstmt;


/
ALTER TRIGGER BARS.TAU_OPER_SWSTMT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_SWSTMT.sql =========*** End
PROMPT ===================================================================================== 
