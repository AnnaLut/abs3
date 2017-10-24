

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_REKFF.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_REKFF ***

  CREATE OR REPLACE TRIGGER BARS.TI_REKFF 
BEFORE INSERT ON ARC_RRP    FOR EACH ROW
    WHEN (
( SUBSTR(NEW.fn_a,2,1)='A' OR NEW.fn_a IS NULL ) AND
       ( NEW.id_a='0000000000' OR NEW.id_b='0000000000')  and new.kv=980
      ) DECLARE
   ern  CONSTANT POSITIVE := 338; -- Trigger err code
   err  EXCEPTION;
   erm  VARCHAR2(80);
BEGIN
   IF :NEW.id_a='0000000000' AND INSTR(nvl(:NEW.d_rec,'0'),'#Ф')=0 THEN
      erm := '0930 - Код А не присвоєний, немає номера паспорта';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;
   IF :NEW.id_b='0000000000' AND INSTR(nvl(:NEW.d_rec,'0'),'#ф')=0 THEN
      erm := '0943 - Код Б не присвоєний, немає номера паспорта';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;
END;


/
ALTER TRIGGER BARS.TI_REKFF ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_REKFF.sql =========*** End *** ==
PROMPT ===================================================================================== 
