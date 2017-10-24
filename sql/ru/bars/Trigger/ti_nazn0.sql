

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_NAZN0.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_NAZN0 ***

  CREATE OR REPLACE TRIGGER BARS.TI_NAZN0 
BEFORE INSERT ON BARS.ARC_RRP    FOR EACH ROW
 WHEN (  ( NEW.dk=1 AND NEW.bis IN (0,1) OR
          NEW.dk=3 AND NEW.bis > 1)
AND SUBSTR(NEW.nlsa,1,3)<>'26'
AND SUBSTR(NEW.fn_a,2,1)='A'
AND NEW.mfoa<>'300465'
AND NEW.mfob='300465'
AND NEW.kv=980
      ) DECLARE
   ern    CONSTANT POSITIVE := 338; -- Trigger err code
   err    EXCEPTION;
   erm    VARCHAR2(80);
   maska_ VARCHAR2(200);
   okpo_  VARCHAR2(10);
BEGIN

   BEGIN
      SELECT maska,okpo INTO maska_,okpo_ FROM vps_nazn_mask
       WHERE nls=:NEW.nlsb AND n=
        CASE WHEN :NEW.bis IN (0,1) THEN 0 ELSE 1 END;
   EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
   END;

   IF  :NEW.bis IN (0,1) AND NOT (:NEW.NAZN LIKE maska_ ESCAPE '\')
   OR  :NEW.bis > 1      AND NOT (:NEW.NAZN||:NEW.D_REC LIKE maska_ ESCAPE '\') THEN
      erm := '0614 - Пом. синтаксис призначення платежу';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;


   IF  :NEW.id_b <> okpo_ THEN
       erm :='0619 - Невірний код ЄДРПО';
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
   END IF;

END;
/
ALTER TRIGGER BARS.TI_NAZN0 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_NAZN0.sql =========*** End *** ==
PROMPT ===================================================================================== 
