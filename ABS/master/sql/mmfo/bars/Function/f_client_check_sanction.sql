
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_client_check_sanction.sql =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CLIENT_CHECK_SANCTION (
   p_rnk          IN     NUMBER,                                 --rnk клієнта
   p_date         IN     DATE := bankdate)
   RETURN NUMBER
IS
   l_n          NUMBER;
   date_i       DATE;
   date_z       DATE;
   date_i_end   DATE;
   date_z_end   DATE;
   l_n_i        NUMBER;
   l_n_z        NUMBER;
   l_benef_id   NUMBER;

   CURSOR c_sanction
   IS
        SELECT MAX (k030) AS k030,
               MAX (k020) AS k020,
               MAX (r4) AS r4,
               CASE WHEN MAX (sanksia1) = '?' THEN 2 ELSE 1 END AS sanksia1,
               MAX (v_sank) AS v_sank,
               MAX (nakaz) AS nakaz,
               MAX (srsank11) AS srsank11,
               MAX (srsank12) AS srsank12,
               DECODE (
                  MAX (v_sank),
                  '2', -1,  --1 - застосування, -1 - відміна, 0 - призупинення
                  CASE
                     WHEN MAX (nakaz) LIKE 'ПРИЗУПИН%' THEN 0
                     ELSE 1
                  END)
                  AS status,
               nomnak,
               datanak,
               nomnaksk,
               datnaksk
          FROM cim_f98
         WHERE        sanksia1 != 'ПІ'
                  AND sanksia1 != 'П'
                  AND (    k030 = 2
                       AND r4 = (SELECT nmk
                                   FROM customer
                                  WHERE rnk = p_rnk))
               OR     k030 = 1
                  AND ltrim(k020,'0') = (SELECT ltrim(okpo,'0')
                                FROM customer
                               WHERE rnk = p_rnk)
      GROUP BY nomnak,
               datanak,
               nomnaksk,
               datnaksk
      ORDER BY DECODE (status, 0, 2, 1), NVL (datnaksk, datanak);
BEGIN
   date_i := NULL;
   date_z := NULL;
   date_i_end := NULL;
   date_z_end := NULL;
   l_n_i := 0;
   l_n_z := 0;
   l_n := 0;

   FOR c IN c_sanction
   LOOP
      IF c.k030 = 2
      THEN
         CASE c.status
            WHEN 0
            THEN
               IF     c.srsank11 <= p_date
                  AND (c.srsank12 IS NULL OR c.srsank12 > p_date)
               THEN
                  l_n_z := 0;
               END IF;
            WHEN -1
            THEN
               IF    c.srsank12 IS NULL
                  OR c.srsank12 <= p_date AND c.srsank12 > date_z_end
               THEN
                  date_z_end := c.srsank12;
                  l_n_z := l_n_z - 1;
               END IF;
            ELSE
               IF    c.srsank11 IS NULL
                  OR     c.srsank11 <= p_date
                     AND (c.srsank12 IS NULL OR c.srsank12 > p_date)
                     AND (date_z < c.srsank11 OR date_z IS NULL)
               THEN
                  date_z := c.srsank11;
                  date_z_end := c.srsank12;
                  l_n_z := l_n_z + 1;
               END IF;
         END CASE;
      ELSE
         CASE c.status
            WHEN 0
            THEN
               IF     c.srsank11 <= p_date
                  AND (c.srsank12 IS NULL OR c.srsank12 > p_date)
               THEN
                  l_n_i := 0;
               END IF;
            WHEN -1
            THEN
               IF    c.srsank12 IS NULL
                  OR c.srsank12 <= p_date AND c.srsank12 > date_i_end
               THEN
                  date_i_end := c.srsank12;
                  l_n_i := l_n_i - 1;
               END IF;
            ELSE
               IF     c.srsank11 <= p_date
                  AND (c.srsank12 IS NULL OR c.srsank12 > p_date)
                  AND (date_i < c.srsank11 OR date_i IS NULL)
               THEN
                  date_i := c.srsank11;
                  date_i_end := c.srsank12;
                  l_n_i := l_n_i + 1;
               END IF;
         END CASE;
      END IF;

      l_n := l_n + 1;
   END LOOP;

   IF l_n = 0
   THEN
      RETURN 0;                                        -- Немає жодних санкцій
   ELSIF date_i IS NOT NULL AND l_n_i > 0
   THEN
      RETURN 2;                                 --Є діючі санкції на резидента
   ELSIF date_z IS NOT NULL AND l_n_z > 0
   THEN
      RETURN 3;                               --Є діючі санкції на нерезидента
   ELSE
      RETURN 1;                                            --Є недіючі санкції
   END if;
end;
/
 show err;
 
PROMPT *** Create  grants  F_CLIENT_CHECK_SANCTION ***
grant EXECUTE                                                                on F_CLIENT_CHECK_SANCTION to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CLIENT_CHECK_SANCTION to START1;
grant EXECUTE                                                                on F_CLIENT_CHECK_SANCTION to ZAY;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_client_check_sanction.sql =======
 PROMPT ===================================================================================== 
 