

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_SPOT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_SPOT ***

  CREATE OR REPLACE TRIGGER BARS.TI_SPOT 
  BEFORE INSERT ON "BARS"."SPOT"
  REFERENCING FOR EACH ROW
     WHEN ( NEW.ACC is NULL ) BEGIN
    :NEW.ACC:=0;
END ti_SPOT;



/
ALTER TRIGGER BARS.TI_SPOT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_SPOT.sql =========*** End *** ===
PROMPT ===================================================================================== 
