

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_REK_S.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_REK_S ***

  CREATE OR REPLACE TRIGGER BARS.TI_REK_S 
  BEFORE INSERT ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
    WHEN (
( SUBSTR(NEW.fn_a,2,1)='A' OR NEW.fn_a IS NULL )
 AND NEW.DK=1
 AND ( ( NEW.vob IN (11,12) and INSTR(NVL(NEW.d_rec,'0'),'#S')=0 and SUBSTR(NEW.nlsa,1,4)<>'1500' )
       OR
       ( NEW.vob NOT IN (11,12) and INSTR(NVL(NEW.d_rec,'0'),'#S')>0 ))
      ) DECLARE
   ern  CONSTANT POSITIVE := 338; -- Trigger err code
   err  EXCEPTION;
   erm  VARCHAR2(80);
BEGIN
   erm := '0951 - Відсутній реквізит "Стягувач" для інкасового доручення' ;
   raise_application_error(-(20000+ern),'\'||erm,TRUE);
END;


/
ALTER TRIGGER BARS.TI_REK_S ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_REK_S.sql =========*** End *** ==
PROMPT ===================================================================================== 
