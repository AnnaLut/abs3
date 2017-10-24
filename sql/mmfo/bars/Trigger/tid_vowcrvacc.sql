

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TID_VOWCRVACC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TID_VOWCRVACC ***

  CREATE OR REPLACE TRIGGER BARS.TID_VOWCRVACC 
instead of delete on v_ow_crvacc for each row
begin
  insert into ow_crvacc_close (acc, dat) values (:old.acc, bankdate+32);
exception when dup_val_on_index then null;
end;



/
ALTER TRIGGER BARS.TID_VOWCRVACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TID_VOWCRVACC.sql =========*** End *
PROMPT ===================================================================================== 
