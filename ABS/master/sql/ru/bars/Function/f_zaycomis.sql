
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_zaycomis.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ZAYCOMIS 
   (p_dk   NUMBER,
    p_type CHAR,
    p_rnk  NUMBER,
    p_kv   NUMBER,
    p_dat  DATE,
    p_sum  NUMBER)
RETURN NUMBER
IS
  l_grp    NUMBER;
  l_rate   NUMBER;
  l_kom    NUMBER;
BEGIN
-- ============================================================================
--                    Модуль "Биржевые операции"
--       Функция рачета индивидуальной комиссии за покупку/продажу валюты
--                          VERSION 4.0
-- ============================================================================
  BEGIN
    SELECT (grp-1) INTO l_grp
      FROM tabval
     WHERE grp IS NOT NULL AND kv = p_kv;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN NULL;
  END;

  -- процент комиссии из "Параметры клиентов"
  BEGIN
    SELECT decode(p_dk, 1, kom, kom2) INTO l_kom
      FROM cust_zay
     WHERE rnk = p_rnk AND decode(p_dk, 1, kom, kom2) IS NOT NULL;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_kom := null;
  END;

  -- если процента комиссии нет или он не установлен
  IF l_kom IS NULL THEN
    BEGIN
      SELECT to_number(val,'9999D99','NLS_NUMERIC_CHARACTERS=''.,''')
        INTO l_kom
        FROM birja WHERE par = 'PROC_KOM';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN RETURN NULL;
    END;
  END IF;

  -- поиск по клиенту и валюте заявки
  BEGIN
    SELECT decode(p_type, 'R', zc.rate, zc.fix_sum)
      INTO l_rate
      FROM zay_comiss zc
     WHERE zc.rnk = p_rnk
       AND zc.kv =  p_kv
       AND zc.dk =  p_dk
       AND zc.date_on <=  p_dat
       AND nvl(zc.date_off, p_dat) >= p_dat
       AND nvl(limit,999999999999999) =
           (SELECT NVL(MIN(limit),999999999999999)
              FROM zay_comiss
             WHERE rnk = zc.rnk
               AND dk = zc.dk
	       AND kv = zc.kv
               AND NVL(limit,999999999999999) >= NVL(p_sum/100,999999999999999)
               AND date_on <= p_dat
               AND nvl(date_off, p_dat) >= p_dat);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- поиск по клиенту и категории, к которой относится валюта заявка
      BEGIN
        SELECT decode(p_type,'R', zc.rate, zc.fix_sum)
          INTO l_rate
          FROM zay_comiss zc
         WHERE zc.rnk = p_rnk
           AND zc.kv_grp =  l_grp
           AND zc.dk =  p_dk
           AND zc.kv IS NULL
           AND zc.date_on <= p_dat
           AND nvl(zc.date_off, p_dat) >= p_dat
           AND nvl(limit,999999999999999) =
              (SELECT NVL(MIN(limit),999999999999999)
                 FROM zay_comiss
                WHERE rnk = zc.rnk
                  AND dk = zc.dk
                  AND kv IS NULL
	          AND kv_grp = zc.kv_grp
                  AND NVL(limit,999999999999999) >= NVL(p_sum/100,999999999999999)
                  AND date_on <=  p_dat
                  AND nvl(date_off, p_dat) >= p_dat);
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
        -- обычный тариф для всех клиентов банка для валюты заявки
          BEGIN
            SELECT decode(p_type,'R', zc.rate, zc.fix_sum)
              INTO l_rate
              FROM zay_comiss zc
             WHERE zc.rnk IS NULL
               AND zc.kv =  p_kv
               AND zc.dk =  p_dk
               AND zc.date_on <=  p_dat
               AND nvl(zc.date_off, p_dat) >= p_dat
               AND nvl(limit,999999999999999) =
                  (SELECT NVL(MIN(limit),999999999999999)
                     FROM zay_comiss
                    WHERE rnk IS NULL
                      AND dk = zc.dk
                      AND kv = zc.kv
                      AND NVL(limit,999999999999999) >= NVL(p_sum/100,999999999999999)
                      AND date_on <= p_dat
                      AND nvl(date_off, p_dat) >= p_dat);
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              -- обычный тариф для всех клиентов банка для категории валюты заявки
              BEGIN
                SELECT decode(p_type,'R', zc.rate, zc.fix_sum)
                  INTO l_rate
                  FROM zay_comiss zc
                 WHERE zc.rnk IS NULL
                   AND zc.kv_grp =  l_grp
                   AND zc.dk =  p_dk
                   AND zc.kv IS NULL
                   AND zc.date_on <= p_dat
                   AND nvl(zc.date_off, p_dat) >= p_dat
                   AND nvl(limit,999999999999999) =
                      (SELECT NVL(MIN(limit),999999999999999)
                         FROM zay_comiss
                        WHERE rnk IS NULL
                          AND dk = zc.dk
                          AND kv IS NULL
	                  AND kv_grp = zc.kv_grp
                          AND NVL(limit,999999999999999) >= NVL(p_sum/100,999999999999999)
                          AND date_on <= p_dat
                          AND nvl(date_off, p_dat) >= p_dat);
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  l_rate := CASE
                            WHEN p_type = 'R' THEN l_kom
                                              ELSE NULL
                            END;
              END;
          END;
      END;
  END;

  RETURN l_rate;

END f_zaycomis;
/
 show err;
 
PROMPT *** Create  grants  F_ZAYCOMIS ***
grant EXECUTE                                                                on F_ZAYCOMIS      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ZAYCOMIS      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_ZAYCOMIS      to ZAY;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_zaycomis.sql =========*** End ***
 PROMPT ===================================================================================== 
 