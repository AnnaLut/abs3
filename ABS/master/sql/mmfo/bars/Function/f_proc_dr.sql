CREATE OR REPLACE FUNCTION BARS.F_PROC_DR
   (p_acc   INT,
    p_sour  INT       DEFAULT 4,      -- источник финансирования
    p_type  INT       DEFAULT 0,      -- 1 = НЕ перех.мес
    p_mode  VARCHAR2  DEFAULT NULL,   -- код модуля
    p_nbs   VARCHAR2  DEFAULT NULL,   -- БС
    p_kv    INT       DEFAULT NULL)   -- код валюты
RETURN INT
--29.11.2017 Sta Поиск в accounts по NLS (NLSALT) = счету из PROC_DR 
-- ============================================================================
--        Функция расчета контрсчета для начисления %%
--   из справочника "Счета доходов-расходов по процентных Акт-Пас" (PROC_DR)
--
--                      БАНК "ПРАВЕКС"
--
-- 1. Для счетов, закрепленных за ТОБО, настройка берется из PROC_DR rezid=tobo
-- 2. Для модуля "Вклады населения" (p_mode='DPT') счет расходов берется из
--    настройки вида вклада (p_type = dpt_vidd.vidd)
-- 3. Если для клиентов с REZID <> 0 счет доходов-расходов не описан в спр-ке,
--    берется стандарный счет (rezid = 0).
-- 4. Добавлена ветка для модуля МБДК.
-- ============================================================================
IS
  l_kvb    INT;
  l_kv     INT;
  l_nbs    CHAR(4);
  l_rnk    NUMBER;
  l_branch VARCHAR2(30);
  l_notax   INT;
  l_code   INT;
  l_acc67  INT;
  l_nls67  VARCHAR2(14);
 ---------------------------------------------

BEGIN

  -- Нац.валюта
  BEGIN
    SELECT to_number(val) INTO l_kvb FROM params WHERE par = 'BASEVAL';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- erm := '9313 - No baseval found #';
      bars_error.raise_nerror('SVC', 'BASEVAL_NOT_FOUND');
  END;

  l_code  := 0;

  IF p_mode = 'MKD' THEN
    l_rnk := p_acc;
    l_nbs := p_nbs;
    l_kv  := p_kv;
    l_notax:=0;
    BEGIN
    SELECT nvl(to_number(mfo),0) INTO l_code FROM custbank WHERE rnk=l_rnk;
                                  -- если найден, но нет МФО - то l_code:=0
    EXCEPTION
      WHEN NO_DATA_FOUND THEN l_code := 0;
    END;
--  переопределение кода по признаку клиента-плательщика налогов
--  приоритет у МФО
    BEGIN
      SELECT nvl(to_number(ltrim(rtrim(value))),0)
        INTO l_notax
        FROM customerw
       WHERE rnk = l_rnk AND tag = 'NOTAX';
     EXCEPTION
      WHEN NO_DATA_FOUND  THEN   l_notax := 0;
      WHEN INVALID_NUMBER THEN   l_notax := 0;
    END;
    if l_code=0 and l_notax<>0 then
       l_code:=l_notax;   -- переопределим код для PROC_DR
    end if;
--------------конец MежбанкКреДепо-------------
  
  
  /*IF p_mode = 'MKD' THEN
    l_rnk := p_acc;
    l_nbs := p_nbs;
    l_kv  := p_kv;
    BEGIN
      SELECT to_number(mfo) INTO l_code FROM custbank WHERE rnk=l_rnk;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN l_code := 0;
    END;*/
  ELSE
    -- Параметра счета
    BEGIN
      SELECT a.nbs, a.kv, c.rnk,
             a.branch
        INTO l_nbs, l_kv, l_rnk, l_branch
        FROM accounts a, cust_acc c
       WHERE a.acc = c.acc AND a.acc = p_acc;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- erm := '9300 - No account found #'||' ('||p_acc||')';
        bars_error.raise_nerror('SVC', 'ACC_NOT_FOUND', p_acc);
    END;
  END IF;

  -------------- ВКЛАДЫ НАСЕЛЕНИЯ ---------------------
  IF p_mode = 'DPT' THEN

     BEGIN
       SELECT decode(l_kv, l_kvb, g67, v67)
         INTO l_nls67
         FROM proc_dr
        WHERE nbs = l_nbs
          AND sour = p_sour
          AND nvl(rezid,0) = p_type
          AND branch = sys_context('bars_context','user_branch');
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
         BEGIN
           SELECT decode(l_kv, l_kvb, g67, v67)
             INTO l_nls67
             FROM proc_dr
            WHERE nbs = l_nbs
              AND sour = p_sour
              AND nvl(rezid,0) = 0
              AND branch = sys_context('bars_context','user_branch');
         EXCEPTION
           WHEN NO_DATA_FOUND THEN l_nls67 := '-1';
         END;
     END;
------------------ БЕЗ БАНТИКОВ (p_mode IS NULL) ------------------------------
  ELSE
    BEGIN
      SELECT decode(l_kv, l_kvb,
                    decode(p_type, 0, g67, nvl(g67n,g67)),
                    decode(p_type, 0, v67, nvl(v67n,v67)))
        INTO l_nls67
        FROM proc_dr
       WHERE nbs = l_nbs AND sour = p_sour AND nvl(rezid,0) = l_code;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        BEGIN
          SELECT decode(l_kv, l_kvb,
                        decode(p_type, 0, g67, nvl(g67n,g67)),
                        decode(p_type, 0, v67, nvl(v67n,v67)))
            INTO l_nls67
            FROM proc_dr
           WHERE nbs = l_nbs AND sour = p_sour AND nvl(rezid,0) = 0;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            --erm := '9300 - No account found for (nbs,sour)g = '||'('||l_nbs||','||p_sour||')';
            --RAISE err;
            RETURN NULL;
        END;
    END;

  END IF;

  BEGIN    SELECT acc INTO l_acc67 FROM accounts WHERE l_nls67 in (nls, NVL(nlsalt, nls) )  AND kv = l_kvb;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      --erm := '9300 - No account found for nls = '||l_nls67||' !';
      --RAISE err;
      RETURN NULL;
  END;

  RETURN l_acc67;

END F_PROC_DR;
/