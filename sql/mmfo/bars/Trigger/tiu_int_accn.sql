

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_INT_ACCN.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_INT_ACCN ***

  CREATE OR REPLACE TRIGGER BARS.TIU_INT_ACCN 
  BEFORE INSERT OR UPDATE ON "BARS"."INT_ACCN"
  REFERENCING FOR EACH ROW
  DECLARE
   NLS_ varchar2(15);
BEGIN
   IF LENGTH(:NEW.NLSB)>14 THEN
      NLS_:=SUBSTR(:NEW.NLSB,1,14);
     :NEW.NLSB := NLS_;
   end if;
END;



/
ALTER TRIGGER BARS.TIU_INT_ACCN ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_INT_ACCN.sql =========*** End **
PROMPT ===================================================================================== 
