

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CP_RATES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CP_RATES ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CP_RATES 
   BEFORE INSERT OR UPDATE
   ON "BARS"."CP_RATES"
   REFERENCING FOR EACH ROW
BEGIN
   If :new.idb is null then
      :new.idb := Nvl(TO_NUMBER(GetGlobalOption('CP_BYR')),3);
   end if;
   :NEW.DY    := UPPER(:NEW.DY);
   :NEW.VDATE := NVL( :NEW.VDATE, GL.bDATE);

   IF :NEW.DY IN ('D','Y') AND :NEW.KOEFF > 0 THEN
      SELECT cena,
       ROUND(decode(nvl(IR,0),0,
             cp.UFORMULA01(cena, :NEW.DY, datp, :NEW.VDATE, basey, :NEW.KOEFF),
             cp.GEO_RATE_Y(cena, :new.ID, :NEW.KOEFF, :NEW.VDATE, 2)
             ), 2 )
      INTO :NEW.BSUM, :NEW.RATE_O
      FROM CP_KOD  WHERE ID = :NEW.ID;
   END IF;

END TIU_CP_RATES;


/
ALTER TRIGGER BARS.TIU_CP_RATES ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CP_RATES.sql =========*** End **
PROMPT ===================================================================================== 
