

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_LOM_1.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_LOM_1 ***

  CREATE OR REPLACE TRIGGER BARS.TBU_LOM_1 
     INSTEAD OF UPDATE
       ON LOM_1 REFERENCING NEW AS NEW OLD AS OLD
declare
   S_ number;
   D_ number;
begin
   d_ := Round( (:OLD.ost_2202*100 + :OLD.ost_2208*100)*15/85,0);
   S_ :=         :OLD.ost_2202*100 + :OLD.ost_2208*100 + D_ ;
   cc_lom (1, :OLD.ND, s_, null, :NEW.nazn);
end tbu_LOM_1;
/
ALTER TRIGGER BARS.TBU_LOM_1 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_LOM_1.sql =========*** End *** =
PROMPT ===================================================================================== 
