PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TRG_CC_SWRTRACE_ID.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TRG_CC_SWRTRACE_ID ***

  CREATE OR REPLACE TRIGGER trg_cc_swtrace_id
  BEFORE INSERT ON cc_swtrace
  FOR EACH ROW
BEGIN
  :new.id := S_CC_SWTRACE.nextval;
END;
/

ALTER TRIGGER BARS.TRG_CC_SWRTRACE_ID ENABLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TRG_CC_SWRTRACE_ID.sql =========*** End *** ====
PROMPT ===================================================================================== 
