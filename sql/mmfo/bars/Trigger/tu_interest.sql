

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_INTEREST.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_INTEREST ***

  CREATE OR REPLACE TRIGGER BARS.TU_INTEREST 
   AFTER UPDATE OF OSTC
   ON ACCOUNTS
   REFERENCING FOR EACH ROW
  WHEN (
new.dapp IS NOT NULL   AND old.dapp IS NULL     AND
         new.ostc <> 0          AND nvl(old.ostc,0)=0    AND
         new.nbs IN ('2610','2615','2630','2635','2651','2652','2620')
      ) DECLARE
 acr_dat_    DATE;
 id_         NUMBER;
BEGIN
  -- Постановление НБУ №516 от 03.12.2003 года пункт 1.7 гласит:
  -- "... нарахування процентів на депозит починається з
  -- наступного після надходження від вкладника грошових коштів дня.. "

  --Игнорируем счета 2620, открытые не в модуле "Вклады населения"
  IF :new.nbs='2620' OR :new.nbs='8620' THEN
    BEGIN
      SELECT deposit_id INTO id_ FROM dpt_deposit WHERE acc=:new.acc;
      EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
    END;
   END IF;

  BEGIN
    SELECT acr_dat INTO acr_dat_ FROM int_accn WHERE id=1 AND acc=:NEW.ACC;
    UPDATE int_accn SET acr_dat=:NEW.DAPP WHERE id=1 AND acc=:new.acc AND
       (acr_dat<:new.dapp OR acr_dat IS NULL);
    EXCEPTION WHEN OTHERS THEN
       INSERT INTO int_accn (acc,id,acr_dat) VALUES (:new.acc,1,:new.dapp);
  END;
END tu_interest;



/
ALTER TRIGGER BARS.TU_INTEREST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_INTEREST.sql =========*** End ***
PROMPT ===================================================================================== 
