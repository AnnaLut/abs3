

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ZAY_BACK_RESERVE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ZAY_BACK_RESERVE ***

  CREATE OR REPLACE TRIGGER BARS.TU_ZAY_BACK_RESERVE 
   AFTER UPDATE
   ON zayavka
   FOR EACH ROW
    WHEN (    old.viza = 1
         AND new.viza = -1
         AND old.sos = 0
         AND new.sos = -1
         AND old.idback IS NULL
         AND new.idback = -1) BEGIN
   -- откат суммы лимита при сторнировании заявки на покупку валюты
   -- нужен только при birja.rezerv = 1
   UPDATE accounts
      SET lim = NVL (lim, 0) + :old.lim
    WHERE acc = :old.acc0 AND :old.lim IS NOT NULL;
END;
/
ALTER TRIGGER BARS.TU_ZAY_BACK_RESERVE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ZAY_BACK_RESERVE.sql =========***
PROMPT ===================================================================================== 
