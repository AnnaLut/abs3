

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_TARIF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_TARIF ***

  CREATE OR REPLACE TRIGGER BARS.TBI_TARIF 
BEFORE INSERT  ON tarif
FOR EACH ROW
DECLARE newkod NUMBER;
BEGIN
   IF ( :new.kod = 0 ) or ( :new.kod = NULL ) THEN
       SELECT s_tarif.NEXTVAL
       INTO newkod FROM DUAL;
       :new.kod := newkod;
   END IF;
END;

/
ALTER TRIGGER BARS.TBI_TARIF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_TARIF.sql =========*** End *** =
PROMPT ===================================================================================== 
