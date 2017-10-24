

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ARCRRP_SWT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ARCRRP_SWT ***

  CREATE OR REPLACE TRIGGER BARS.TU_ARCRRP_SWT 
after update of sos ON BARS.ARC_RRP
for each row
    WHEN (
new.bis=1 and new.sos=5 and old.sos=3 and new.dk=2 and new.s>0 and instr(new.d_rec, '#f')>0
      ) begin
    if (:new.mfob = gl.kf) then
        bars_swift.stmt_process_reginfdoc(:new.rec);
    end if;
end tu_arcrrp_swt;


/
ALTER TRIGGER BARS.TU_ARCRRP_SWT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ARCRRP_SWT.sql =========*** End *
PROMPT ===================================================================================== 
