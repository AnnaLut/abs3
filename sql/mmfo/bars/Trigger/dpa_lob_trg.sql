

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/DPA_LOB_TRG.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger DPA_LOB_TRG ***

  CREATE OR REPLACE TRIGGER BARS.DPA_LOB_TRG 
BEFORE INSERT
ON BARS.DPA_LOB
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
BEGIN
-- For Toad:  Highlight column ID
  :new.ID := DPA_LOB_SEQ.nextval;
END DPA_LOB_TRG;
/
ALTER TRIGGER BARS.DPA_LOB_TRG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/DPA_LOB_TRG.sql =========*** End ***
PROMPT ===================================================================================== 
