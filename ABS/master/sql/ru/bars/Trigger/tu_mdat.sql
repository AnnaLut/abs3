

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_MDAT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_MDAT ***

  CREATE OR REPLACE TRIGGER BARS.TU_MDAT 
BEFORE UPDATE OF OSTC ON ACCOUNTS
FOR EACH ROW
 WHEN (
NEW.NBS in (2600,2620,2650) AND NEW.LIM>0  AND NEW.OSTC<0
      ) DECLARE       --
 TIPO_  INT;  -- Блокировка использования лимита по счетам с "Типом" = BLD
 KOL_   INT;  --
 I_     INT ; -- Формируется MDATE - дата погашения по счету 2600.
 DAT_   DATE; --   Триггер срабатывает по счетам 2600 Портфеля Овердрафтов
              --   (ACC_OVER) при вхождении счета в овердрафт:  old.OSTC>0,
              --   new.OSTC<0  - только по договорам типа "Кредитная линия".
              --
 KOL_30 INT;  -- Формируется дата блокировки счета 2600 на Дебет.
              --   Количество дней непрерывного пребывания счета 2600 в
              --   ОВЕРДРАФТЕ, после которого счет должен блокироваться на Дт.
              --   KOL_30 берется из поля ACC_OVER.PR_KOMIS.  Если там 0,
              --   то KOL_30 принимается = 30.
 DAT_30 DATE;
 OST_ INT;
 ERN CONSTANT POSITIVE := 746;
 ERR EXCEPTION; ERM VARCHAR2(80);
BEGIN

 --- Блокировка использования лимита, если "Тип счета" = BLD

 IF :NEW.TIP = 'BLD' AND :OLD.OSTC-:NEW.OSTC > 0 THEN
  ERM := '\9301 - Blk A#'||:NEW.NLS||'('||:NEW.KV||')';
  RAISE ERR;
 END IF;



 --- Авто-формирование даты погашения остатка MDATE по счетам 2600
 --- "Портфеля Овердрафтов" с типом договора "Кредитная линия"

 SELECT ostf-dos+kos INTO ost_
     FROM SALDOA
     WHERE acc=:NEW.acc AND FDAT=(SELECT MAX(FDAT)
                                         FROM SALDOA
                                         WHERE acc=:NEW.acc AND FDAT<gl.bDATE);

 IF :OLD.OSTC >= 0 AND OST_>=0 THEN
    BEGIN
      SELECT TIPO, DAY  , PR_KOMIS
      INTO   TIPO_ , KOL_ , KOL_30
      FROM   ACC_OVER
      WHERE  ACCO = :OLD.ACC AND NVL(KRL,0)=1;
    EXCEPTION  WHEN NO_DATA_FOUND THEN
      RETURN;
    END;

    If KOL_30=0 then
       KOL_30:=30;
    End If;

    IF    TIPO_=7  THEN

       DAT_   := DAT_NEXT_U (GL.BDATE,KOL_-1  );
       DAT_30 := DAT_NEXT_U (GL.BDATE,KOL_30-1);

    ELSIF TIPO_=14 THEN

       DAT_ := GL.BDATE + KOL_-1;
       BEGIN
           SELECT 1 INTO I_ FROM HOLIDAY WHERE HOLIDAY=DAT_ and KV=980;
       EXCEPTION WHEN NO_DATA_FOUND THEN
           I_:=0;
       END;

       IF I_=1 THEN
          DAT_:=DAT_NEXT_U (DAT_,-1);
       END IF;

      ---  Определение DAT_30 - ДАТЫ блокировки счета на Дебет:
       DAT_30 := GL.BDATE + KOL_30 - 1;
       BEGIN
            SELECT 1 INTO I_ FROM HOLIDAY WHERE HOLIDAY=DAT_30 and KV=980;
       EXCEPTION WHEN NO_DATA_FOUND THEN
            I_:=0;
       END;

       IF I_=1 THEN
          DAT_30:=DAT_NEXT_U (DAT_30,-1);
       END IF;

    ELSE
       RETURN;
    END IF;

    --- Записываем вычисленную дату блокировки в поле ACC_OVER.PR_9129:
    Update ACC_OVER set PR_9129=to_number(to_char(DAT_30,'yyyymmdd')),
                        PR_2069=1
                    where ACCO = :OLD.ACC  and  NVL(KRL,0)=1 and
                          PR_9129<>to_number(to_char(DAT_30,'yyyymmdd'));

    :NEW.MDATE := DAT_;

 END IF;
 EXCEPTION WHEN ERR THEN
 RAISE_APPLICATION_ERROR(-(20000+ERN),ERM,TRUE);
END TU_MDAT;
/
ALTER TRIGGER BARS.TU_MDAT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_MDAT.sql =========*** End *** ===
PROMPT ===================================================================================== 
