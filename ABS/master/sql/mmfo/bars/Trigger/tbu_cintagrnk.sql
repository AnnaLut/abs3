

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_CINTAGRNK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_CINTAGRNK ***

  CREATE OR REPLACE TRIGGER BARS.TBU_CINTAGRNK 
  BEFORE UPDATE ON "BARS"."CIN_TAG_RNK"
  REFERENCING FOR EACH ROW
  declare
  r_cin cin_tag%rowtype;
BEGIN

  select * into r_cin from cin_tag where tag = :new.tag;

  If    :new.pr_a1 <>  :old.pr_a1 and :new.sk_a1 = :old.sk_a1 then
        :new.sk_a1 := (r_cin.nom * r_cin.kol * :new.pr_a1) /100;
  elsIf :new.sk_a1 <>  :old.sk_a1                             then
        :new.pr_a1 := (:new.sk_a1 * 100) / (r_cin.nom * r_cin.kol) ;
  end if;

END TBU_CINTAGRNK;



/
ALTER TRIGGER BARS.TBU_CINTAGRNK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_CINTAGRNK.sql =========*** End *
PROMPT ===================================================================================== 
