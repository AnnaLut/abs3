

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_NLSB.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_NLSB ***

  CREATE OR REPLACE TRIGGER BARS.TI_NLSB 
  BEFORE INSERT ON "BARS"."ARC_RRP"
  REFERENCING FOR EACH ROW
    WHEN (
SUBSTR(NEW.fn_a,2,1)='A' AND new.mfoa<>'300465'
      ) DECLARE
   ern  CONSTANT POSITIVE := 338; -- Trigger err code
   err  EXCEPTION;
   erm  VARCHAR2(80);
BEGIN

   IF ( (SUBSTR(:NEW.nlsa,1,4) in ('3900','3901','1001','1002','1003','1004',
         '1011','1012','1013','1200','1300')) or
        (SUBSTR(:NEW.nlsa,1,3)='380') or
        (SUBSTR(:NEW.nlsa,1,1) in ('8','9')) ) and
        :NEW.dk < 2
    THEN
      erm := '0913 - Недопустимый БС клиента А';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;

   IF ( (SUBSTR(:NEW.nlsb,1,4) in ('3900','3901','1001','1002','1003','1004',
         '1011','1012','1013','1200','1300')) or
        (SUBSTR(:NEW.nlsb,1,3)='380') or
        (SUBSTR(:NEW.nlsb,1,1) in ('8','9')) or
        (SUBSTR(:NEW.NLSB,1,4)='1500' AND :NEW.KV<>980) ) and
        :NEW.dk < 2
   THEN
      erm := '0914 - Недопустимый БС клиента Б';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;

   IF  INSTR(:NEW.d_rec,'#fMT')>0
       AND :NEW.mfob=gl.aMFO AND :NEW.nlsb<>'191992'
   THEN
      erm := '0992 - Недопустимый счет клиента Б';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;

   IF :NEW.dk=1 AND
      INSTR(NVL(:NEW.d_rec,' '),'#fMT')=0 AND
      :NEW.mfob=gl.aMFO AND
      :NEW.nlsb='191992'
   THEN
      erm := '0953 - SWIFT: Плохой синтаксис реквизита "f"';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;

END;


/
ALTER TRIGGER BARS.TI_NLSB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_NLSB.sql =========*** End *** ===
PROMPT ===================================================================================== 
