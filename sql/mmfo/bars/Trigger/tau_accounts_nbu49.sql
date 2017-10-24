

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_NBU49.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACCOUNTS_NBU49 ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_NBU49 
   AFTER UPDATE OF ostc
   ON ACCOUNTS
   FOR EACH ROW
     WHEN (    (   old.NBS IN ('2600', '2650')
              OR (old.NBS = '2604' AND old.OB22 IN (1, 3, 5))
              OR (    old.NBS LIKE '25__'
                  AND old.NBS NOT IN ('2560',
                                      '2565',
                                      '2568',
                                      '2570',
                                      '2571',
                                      '2572')))
         AND old.ostc > new.ostc) DECLARE
   oo      oper%ROWTYPE;
   ost_    NUMBER;                                       -- Допустимый рессурс
   s_      NUMBER;                                           -- сумма операции
   nTmp_   INT;
   DOS_    NUMBER;
BEGIN
   S_ := :old.ostc - :new.ostc;                              -- сумма операции


   --- Исключаем из контроля "НАФТОГАЗ"  OKПO='20077720':

   BEGIN
      SELECT 1
        INTO nTmp_
        FROM Customer
       WHERE rnk = :old.rnk AND OKPO IN ('20077720');

      RETURN;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;

   --- Исключаем из контроля МППЗТ:

   IF gl.amfo = '300465' AND :old.NMS LIKE '%МППЗТ%'
   THEN
      RETURN;
   END IF;


   BEGIN
      SELECT *
        INTO oo
        FROM oper
       WHERE REF = gl.Aref;

      IF    oo.mfoa = gl.amfo AND oo.mfob LIKE '8%'
         OR oo.sk IN (40, 50, 59)
         OR     oo.sk = 61
            AND (   UPPER (oo.NAZN) LIKE '%КОМАНД_Р%'
                 OR UPPER (oo.NAZN) LIKE '%В_ДРЯДЖ%')
      THEN
         RETURN;                       -- Все ОК. - бизнес логика от Шарадова:
      /* Согласно постановлению HE предусматриваются ограничения для:
         1. Платежi до бюджету, соцiальних фондiв – код банка-получателя
            начинается на 8.
         2. Виплата заробiтної плати, пенсiй, стипендiй, соцiальних виплат,
            вiдряджень:
            а)  виплати заробiтної плати, стипендiй.    СКП=40
            б)  виплати пенсiй, соцiальних виплат       СКП=50,59
      */

      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN;               -- Этого не д.б. - пусть разбирается Миша в GL.
   END;


   IF :old.lim > 0
   THEN
      ost_ := :old.ostc + :old.lim;          -- Учитываем Лимита ОВР (lim > 0)
   ELSE
      ost_ := :old.ostc;        -- НЕснижаемый остаток (lim < 0) не учитываем.
   END IF;


   IF :old.dapp = gl.bdate
   THEN
      --  Подсчитаем DOS за день БЕЗ УЧЕТА   MФО-Б like '8%'  и  СКП=40,50,59
      BEGIN
         SELECT NVL (SUM (p.S), 0)
           INTO DOS_
           FROM opldok p, oper o
          WHERE     p.fdat = gl.bdate
                AND p.acc = :old.acc
                AND p.dk = 0
                AND p.SOS = 5
                AND o.REF = p.REF
                AND NOT (   o.mfob LIKE '8%'
                         OR NVL (o.SK, 0) IN (40, 50, 59)
                         OR (    NVL (o.SK, 0) = 61
                             AND (   UPPER (o.NAZN) LIKE '%КОМАНД_Р%'
                                  OR UPPER (o.NAZN) LIKE '%В_ДРЯДЖ%')));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            DOS_ := 0;
      END;

      ost_ := ost_ - :old.kos + :old.dos; -- вх.остаток  c учетом лимита ОВР и блок сумм
      s_ := s_ + DOS_;
   END IF;                      -- вх.остаток  c учетом лимита ОВР и блок сумм

   IF ost_ - s_ >= 0
   THEN
      RETURN;       -- 2) Все ОК. Уложились во вх.остаток, т.е. в постанову 49
   END IF;


   -- Проверим доп реквизит, который на усмотрение пользователя, разрешает  нарушать 49.
   -- Например, М.б. это безнальная з/п
   BEGIN
      SELECT 1
        INTO s_
        FROM operw
       WHERE REF = gl.Aref AND tag = 'NBU49';

      RETURN;                                 -- 3) на усмотрение пользователя
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;


   -- Проверим:  может это 'BAK'-операция ?
   BEGIN
      SELECT 1
        INTO s_
        FROM opldok
       WHERE     REF = gl.Aref
             AND dk = 0
             AND tt = 'BAK'
             AND acc = :old.acc
             AND ROWNUM = 1;

      RETURN;                -- 4)  это 'BAK'-операция сегодняшних поступлений
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;


   -- Нарушено постановление НБУ №49 от 06.02.2014 (сч.деб.:%s, реф.док.:%s)
   -- raise_application_error(-20203, 'Порушено постанову НБУ №49 вiд 06.02.2014 (рах.деб.:' || :old.nls || ', реф.док.:' || gl.Aref || ')');*/
   bars_error.raise_nerror ('BRS',
                            'BROKEN_ACT_NBU49',
                            :old.nls,
                            gl.Aref);
END tau_accounts_NBU49;



/
ALTER TRIGGER BARS.TAU_ACCOUNTS_NBU49 DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_NBU49.sql =========*** 
PROMPT ===================================================================================== 
