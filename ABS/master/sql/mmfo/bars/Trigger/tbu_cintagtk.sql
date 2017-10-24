

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_CINTAGTK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_CINTAGTK ***

  CREATE OR REPLACE TRIGGER BARS.TBU_CINTAGTK 
  BEFORE UPDATE ON "BARS"."CIN_TAG_TK"
  REFERENCING FOR EACH ROW
  declare
  r_cin cin_tag%rowtype;
BEGIN
  select * into r_cin from cin_tag where tag = :new.tag ;

  If    :new.pr_a1 <>  :old.pr_a1 and :new.sk_a1 = :old.sk_a1 then
        :new.sk_a1 := (r_cin.nom * r_cin.kol * :new.pr_a1) /100;
  elsIf :new.sk_a1 <>  :old.sk_a1                             then
        :new.pr_a1 := (:new.sk_a1 * 100) / (r_cin.nom * r_cin.kol) ;
  end if;

END TBU_CINTAGtk;



/
ALTER TRIGGER BARS.TBU_CINTAGTK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_CINTAGTK.sql =========*** End **
PROMPT ===================================================================================== 
