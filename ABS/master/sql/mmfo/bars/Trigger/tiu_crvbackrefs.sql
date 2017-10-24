

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CRVBACKREFS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CRVBACKREFS ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CRVBACKREFS 
  INSTEAD OF UPDATE ON "BARS"."V_CRV_BACK_REFS"
  REFERENCING FOR EACH ROW
  begin
    update crv_back_refs set payment_ref=:new.ref, todo=:new.todo
    where back_ref=:old.back_ref and :old.flg='PAYMENT';
end;



/
ALTER TRIGGER BARS.TIU_CRVBACKREFS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CRVBACKREFS.sql =========*** End
PROMPT ===================================================================================== 
