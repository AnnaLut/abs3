

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_VISA_1PB.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_OPER_VISA_1PB ***

  CREATE OR REPLACE TRIGGER BARS.TBI_OPER_VISA_1PB 
-- Макаренко И.В. 02-2014
-- проверка перед самовизой
-- на заполненность доп.реквизитов для 1-ПБ
BEFORE INSERT ON oper_visa
FOR EACH ROW
DECLARE CheckTT VARCHAR2(3);
        CurrVisa NUMBER;
        counter_ NUMBER;
        err  EXCEPTION;
       -- erm  VARCHAR2(250) := '*** Не заполнены все доп.реквизиты для 1-ПБ !!! ***';
BEGIN
  IF :new.groupid = 5 THEN
    SELECT tt INTO CheckTT FROM oper WHERE ref=:new.ref;
    IF CheckTT IN ('IBB','IBO','IBS') THEN
      SELECT count(*) INTO counter_ FROM OPERW WHERE ref=:new.ref AND tag IN ('KOD_B','KOD_G','KOD_N');
      IF counter_ <> 3 THEN
          RAISE err;
      END IF;
    END IF;
  END IF;
EXCEPTION WHEN err THEN
  bars_error.raise_nerror('BRS', 'ERR_1PB');
END;


/
ALTER TRIGGER BARS.TBI_OPER_VISA_1PB ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_OPER_VISA_1PB.sql =========*** E
PROMPT ===================================================================================== 
