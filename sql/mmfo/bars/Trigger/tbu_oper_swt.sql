

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_OPER_SWT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_OPER_SWT ***

  CREATE OR REPLACE TRIGGER BARS.TBU_OPER_SWT 
before update of sos ON BARS.OPER
begin
    bars_swift_msg.docmsg_document_vldlistrst;
end;


/
ALTER TRIGGER BARS.TBU_OPER_SWT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_OPER_SWT.sql =========*** End **
PROMPT ===================================================================================== 
