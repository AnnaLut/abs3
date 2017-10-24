

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ARCRRP_SWT2.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ARCRRP_SWT2 ***

  CREATE OR REPLACE TRIGGER BARS.TU_ARCRRP_SWT2 
after update of sos ON BARS.ARC_RRP
begin
    bars_swift.stmt_process_infdoc(null);
end tu_arcrrp_swt2;


/
ALTER TRIGGER BARS.TU_ARCRRP_SWT2 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ARCRRP_SWT2.sql =========*** End 
PROMPT ===================================================================================== 
