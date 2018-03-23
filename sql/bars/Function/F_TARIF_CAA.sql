CREATE OR REPLACE FUNCTION BARS.F_Tarif_CAA (p_ref    INTEGER,  -- oper.REF
                                             p_kv     INTEGER,  -- oper.KV
                                             p_nls    VARCHAR2, -- oper.NLSA
                                             p_s      NUMERIC)  -- oper.S
--
--  Ф-я расчета суммы комиссии за переказ инвалюты по SWIFT - операция CAA (доч.комис. K12)
--
--  COBUMMFO-5686  - комиссия одинакова для VIP и неVIP -клиентов:
--                 В межах Украины -  12 тариф
--                 За межі Украины - 119 тариф
--
   RETURN NUMERIC
IS
   kod_kr_    INTEGER;         ---  код страны-получателя
   ser_nom_   VARCHAR2 (20);   ---  Серия Номер паспорта
   ser_       VARCHAR2 (10);   ---  Серия
   nom_       VARCHAR2 (10);   ---  Номер
   rnk_       NUMERIC;         ---  RNK
   vip_       INTEGER;         ---  = 1 - это VIP
   kod_       INTEGER;         ---  код тарифа
   sk_        NUMERIC;         ---  расчетная сумма комиссии

BEGIN


   kod_kr_ := nvl(trim(F_DOP(p_ref,'D6#70')),'000');


--   ser_nom_ := NVL (TRIM (F_DOP (p_ref, 'PASPN')), '00 000000');
--
--   IF SUBSTR (ser_nom_, 3, 1) = ' ' THEN
--      ser_ := SUBSTR (ser_nom_, 1, 2);
--      nom_ := SUBSTR (ser_nom_, 4, 6);
--   ELSE
--      ser_ := SUBSTR (ser_nom_, 1, 2);
--      nom_ := SUBSTR (ser_nom_, 3, 6);
--   END IF;
--
--   BEGIN
--      SELECT RNK
--        INTO rnk_
--        FROM (  SELECT p.RNK
--                  FROM PERSON p, CUSTOMER c
--                 WHERE     UPPER (p.SER) = UPPER (ser_)
--                       AND p.NUMDOC = nom_
--                       AND p.RNK = c.RNK
--                       AND c.DATE_OFF IS NULL
--              ORDER BY c.DATE_ON DESC)
--       WHERE ROWNUM = 1;
--
--      SELECT 1
--        INTO vip_
--        FROM V_CUSTOMER_SEGMENTS
--       WHERE RNK = rnk_
--             AND CUSTOMER_SEGMENT_FINANCIAL IN ('Прайвет',
--                                                'Преміум')
--             AND ROWNUM = 1;
--
--   EXCEPTION WHEN NO_DATA_FOUND THEN
--         vip_ := 0;
--   END;
--
--
--   IF vip_ = 0  THEN             -- Это обычный клиент


      IF kod_kr_ = '804' THEN
         kod_ := 12;
      ELSE
         kod_ := 119;
      END IF;


--   ELSE    
--      IF kod_kr_ = '804' THEN
--         kod_ := 120;
--      ELSE
--         kod_ := 121;
--      END IF;
--   END IF;


   sk_ :=  GL.P_ICURVAL (p_kv, F_TARIF (kod_,p_kv,p_nls,p_s), gl.BDATE);

   RETURN sk_;

END F_Tarif_CAA;
/
grant execute on F_Tarif_CAA to START1;
grant execute on F_Tarif_CAA to bars_access_defrole;


