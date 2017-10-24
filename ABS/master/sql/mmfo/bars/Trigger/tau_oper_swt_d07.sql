

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_SWT_D07.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_SWT_D07 ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPER_SWT_D07 
after update of sos ON BARS.OPER for each row
    WHEN (
new.sos = 5 and new.tt= 'D07'
      ) begin

     insert into ref_queue_swt(ref) values(:new.ref);

Exception when dup_val_on_index then null;

end TAU_OPER_SWT_D07;


/
ALTER TRIGGER BARS.TAU_OPER_SWT_D07 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_SWT_D07.sql =========*** En
PROMPT ===================================================================================== 
