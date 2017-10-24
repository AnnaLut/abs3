

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_CINTAG.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_CINTAG ***

  CREATE OR REPLACE TRIGGER BARS.TBU_CINTAG 
  BEFORE UPDATE ON "BARS"."CIN_TAG"
  REFERENCING FOR EACH ROW
  BEGIN

  If    :new.pr_a1 <>  :old.pr_a1 and :new.sk_a1 = :old.sk_a1 then
        :new.sk_a1 := (:new.nom * :new.kol * :new.pr_a1) /100;
  elsIf :new.sk_a1 <>  :old.sk_a1                             then
        :new.pr_a1 := (:new.sk_a1 * 100) / (:new.nom*:new.kol) ;
  end if;

END TBU_CINTAG;



/
ALTER TRIGGER BARS.TBU_CINTAG ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_CINTAG.sql =========*** End *** 
PROMPT ===================================================================================== 
