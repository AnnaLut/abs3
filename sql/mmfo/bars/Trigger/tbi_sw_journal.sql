

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SW_JOURNAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SW_JOURNAL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SW_JOURNAL 
  BEFORE INSERT ON "BARS"."SW_JOURNAL"
  REFERENCING FOR EACH ROW
  DECLARE
  ACC_ NUMBER;

BEGIN
   IF NVL(:NEW.SWREF,0) = 0  THEN
      SELECT S_SW_JOURNAL.NEXTVAL INTO :NEW.SWREF FROM DUAL;
   END IF;

   -- STA управдение признаком ДК для (900,910)х(O/I)
   -- по отношению к корсчету в АБС
   ------------
   --  |910|900|
   ------------
   -- O| Д | К |
   -- I| К | Д |
   ------------

   ACC_:=NVL(:new.ACCD, :new.ACCK);

      if ( :new.MT = 910  and   :new.IO_IND = 'O' ) or
         ( :new.MT = 900  and   :new.IO_IND = 'I' ) then
           :new.ACCD :=   ACC_; :new.ACCK  := null ;

   elsif ( :new.MT = 900  and   :new.IO_IND = 'O' ) or
         ( :new.MT = 910  and   :new.IO_IND = 'I' ) then
           :new.ACCK :=   ACC_; :new.ACCD  := null ;
   end if;

END;



/
ALTER TRIGGER BARS.TBI_SW_JOURNAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SW_JOURNAL.sql =========*** End 
PROMPT ===================================================================================== 
