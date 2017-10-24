

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_CHKLIST_HEX.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_CHKLIST_HEX ***

  CREATE OR REPLACE TRIGGER BARS.TI_CHKLIST_HEX 
before insert on chklist for each row
begin
  :new.idchk_hex := lpad(chk.to_hex(:new.idchk),2,'0');
end ti_chklist_hex;




/
ALTER TRIGGER BARS.TI_CHKLIST_HEX ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_CHKLIST_HEX.sql =========*** End 
PROMPT ===================================================================================== 
