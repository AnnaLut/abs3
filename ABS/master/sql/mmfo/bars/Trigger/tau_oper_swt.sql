

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_SWT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_OPER_SWT ***

  CREATE OR REPLACE TRIGGER BARS.TAU_OPER_SWT 
after update of sos ON BARS.OPER
begin

    bars_swift_msg.docmsg_document_vldlistprc;
    bars_swift.genmsg_notify_process;

end;


/
ALTER TRIGGER BARS.TAU_OPER_SWT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_OPER_SWT.sql =========*** End **
PROMPT ===================================================================================== 
