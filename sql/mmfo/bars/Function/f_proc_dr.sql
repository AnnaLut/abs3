/*
update cc_vidd set name ='Розміщення 1510 - Депозит овернайт,                      where vidd = 1510   ;
update cc_vidd set name ='Розміщення 1513 - короткострокові депозити'              where vidd = 1512   ;
update cc_vidd set name ='Розміщення 1513 - Довгострокові депозити'                where vidd = 1515   ;
update cc_vidd set name ='Розміщення 1521 - Кредити овернайт'                      where vidd = 1521   ;
update cc_vidd set name ='Розмiщення  1522-Кредити наданi за операцiями репо'      where vidd = 1522   ;
update cc_vidd set name ='Розміщення 1524 - Кредити  короткострокові'              where vidd = 1523   ;
update cc_vidd set name ='Розміщення 1524 - Кредити довгострокові'                 where vidd = 1524   ;
update cc_vidd set name ='Залучення 1610  - Депозит овернайт'                      where vidd = 1610   ;
update cc_vidd set name ='Залучення 1613 - короткострокові депозити'               where vidd = 1612   ;
update cc_vidd set name ='Залучення 1613 - довгострокові  депозити'                where vidd = 1613   ;
update cc_vidd set name ='Залучення 1621 - Кредити овернайт'                       where vidd = 1621   ;
update cc_vidd set name ='Залучення 1622--Кредити залученi за операцiями репо'     where vidd = 1622   ;
update cc_vidd set name ='Залучення 1623 - Кредити  короткострокові'               where vidd = 1623   ;
update cc_vidd set name ='Залучення 1623 - Кредити  довгострокові'                 where vidd = 1624   ;

commit;
*/

CREATE OR REPLACE FUNCTION BARS.F_PROC_DR
   (p_acc   INT,
    p_sour  INT       DEFAULT 4,      -- источник финансирования
    p_type  INT       DEFAULT 0,      -- 1 = НЕ перех.мес
    p_mode  VARCHAR2  DEFAULT NULL,   -- код модуля
    p_nbs   VARCHAR2  DEFAULT NULL,   -- БС
    p_kv    INT       DEFAULT NULL)   -- код валюты
RETURN INT

--17.12.2017 Sta + 2701
--15.12.2017 Sta Уточнения для об22 по бал.7017

--29.11.2017 Sta Поиск в accounts по NLS (NLSALT) = счету из PROC_DR 
-- ============================================================================
--        Функция расчета контрсчета для начисления %%
--   из справочника "Счета доходов-расходов по процентных Акт-Пас" (PROC_DR)
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
  nbs_  char(4); 
  ob22_ char(2);
 ---------------------------------------------

BEGIN

  -- 06.12.2017 Сухова. Для МБДК Временно, до переделки модуля с учетом об22

  If p_NBS in ('1510','1512','1513','1521','1522','1524','1523','1610','1612','1613','1621','1623','1624',
               '2701' ) then
--RE: 2701 (короткострокові) - не подбирается счет расходов, должен быть БС=7060 (ОБ22=01)/

     If    p_nbs  in ('1510') then nbs_ := '6011'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---Депозити овернайт, що розмўщенў в ўнших банках
     ElsIf p_nbs  in ('1512') then nbs_ := '6012'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '03'; End If ;  ---Короткостроковў вклади (депозити), що розмўщенў в 
     ElsIf p_nbs  in ('1513') then nbs_ := '6012'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '03'; End If ;  ---Довгостроковў вклади (депозити), що розмўщенў в ўн
     ElsIf p_nbs  in ('1521') then nbs_ := '6014'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---кредити овернайт, що наданў ўншим банкам
     ElsIf p_nbs  in ('1522') then nbs_ := '6015'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---кредити, що наданў ўншим банкам за операцўями репо
     ElsIf p_nbs  in ('1524') then nbs_ := '6013'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---довгостроковў  кредити, якў наданў ўншим банкам
     ElsIf p_nbs  in ('1523') then nbs_ := '6013'; if  p_kv = 980 then ob22_ := '03'; else ob22_:= '04'; End If ;  ---короткострокові кредити, що надані іншим банкам
     ----------------------------------
     ElsIf p_nbs  in ('1610') then nbs_ := '7011'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---Депозити овернайт ўнших банкўв
     ElsIf p_nbs  in ('1612') then nbs_ := '7012'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---вклади (депозити) ўнших банкўв КОРОТКІ
     ElsIf p_nbs  in ('1613') then nbs_ := '7012'; if  p_kv = 980 then ob22_ := '05'; else ob22_:= '06'; End If ;  ---вклади (депозити) ўнших банкўв ДОВГІ
     ElsIf p_nbs  in ('1621') then nbs_ := '7014'; if  p_kv = 980 then ob22_ := '01'; else ob22_:= '02'; End If ;  ---кредити овернайт, що отриманў вўд ўнших банкўв
     ElsIf p_nbs  in ('1623') then nbs_ := '7017'; if  p_kv = 980 then ob22_ := '06'; else ob22_:= '05'; End If ;  ---кредити, що наданў ўншим банкам за операцўями репо
     ElsIf p_nbs  in ('1624') then nbs_ := '7017'; if  p_kv = 980 then ob22_ := '02'; else ob22_:= '01'; End If ;  ---довгостроковў  кредити, якў наданў ўншим банкам
     ElsIf p_nbs  in ('2701') then nbs_ := '7060'; ob22_ := '03';
   end if;

     begin select acc into l_acc67  FROM accounts  WHERE nls = NBS_ob22(NBS_, OB22_) and kv = gl.baseval;
                  RETURN   l_acc67 ;
     EXCEPTION    WHEN NO_DATA_FOUND THEN   null;
     end;
 
  end if;

  -- Нац.валюта
  BEGIN    SELECT to_number(val) INTO l_kvb FROM params WHERE par = 'BASEVAL';
  EXCEPTION    WHEN NO_DATA_FOUND THEN      -- erm := '9313 - No baseval found #';
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

    BEGIN  SELECT decode(l_kv, l_kvb,  decode(p_type, 0, g67, nvl(g67n,g67)),      decode(p_type, 0, v67, nvl(v67n,v67)))         INTO l_nls67      FROM proc_dr
           WHERE nbs = l_nbs AND sour = p_sour AND nvl(rezid,0) = l_code;
    EXCEPTION      WHEN NO_DATA_FOUND THEN
        BEGIN  SELECT decode(l_kv, l_kvb, decode(p_type, 0, g67, nvl(g67n,g67)),   decode(p_type, 0, v67, nvl(v67n,v67)))         INTO l_nls67        FROM proc_dr
               WHERE nbs = l_nbs AND sour = p_sour AND nvl(rezid,0) = 0;
        EXCEPTION      WHEN NO_DATA_FOUND THEN        RETURN NULL;
        END;
    END;

  END IF;

  BEGIN    SELECT acc INTO l_acc67 FROM accounts WHERE l_nls67 in (nls, NVL(nlsalt, nls) )  AND kv = l_kvb;
  EXCEPTION    WHEN NO_DATA_FOUND THEN      --erm := '9300 - No account found for nls = '||l_nls67||' !';
      --RAISE err;
      RETURN NULL;
  END;

  RETURN l_acc67;

END F_PROC_DR;
/