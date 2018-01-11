

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_NLKREF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_NLKREF ***

  CREATE OR REPLACE TRIGGER BARS.TAU_NLKREF 
  AFTER UPDATE OF REF2 ON "BARS"."NLK_REF"
  REFERENCING FOR EACH ROW
  begin
    if (:new.ref2 is not null) then
        bars_swift.impmsg_document_synctag(:new.ref1, :new.ref2);
    end if;
end;



/
ALTER TRIGGER BARS.TAU_NLKREF DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_NLKREF.sql =========*** End *** 
PROMPT ===================================================================================== 
