CREATE OR REPLACE FUNCTION f_get_osbb_k110_type (P_RNK NUMBER)
   RETURN NUMBER
IS
   /*
   Определяет является ли клиент по договору контрагентом - страховой компаний или ОСББ
   0 - неявляется
   1- является
   */
   l_res         NUMBER;
   l_borg_nd     NUMBER;
   l_borg_all    NUMBER := 0;
   l_sum_osbb    NUMBER := 250000; -- Загальна сума заборгованості з врахуванням всіх кредитів ОСББ/ЖБК > 250 тис. грн.;
   l_days_osbb   NUMBER := 30; -- кількість днів прострочення за будь якою активною операцією ОСББ/ЖБК >=30 днів.
   l_date_spz    DATE;

   FUNCTION DATE_EXPIRED (p_date DATE, p_nd NUMBER, p_par NUMBER)
      RETURN DATE
   IS
      x_event_date   DATE;
   BEGIN
      IF p_par = 0
      THEN
         BEGIN
            SELECT MIN (DAT_SPZ (a.ACC, p_date, 1))
              INTO x_event_date
              FROM BARS.ACCOUNTS a JOIN BARS.ND_ACC n ON (n.ACC = a.ACC)
             WHERE n.nd = p_nd AND a.TIP IN ('SP ');
         END;
      ELSE
         BEGIN
            SELECT MIN (DAT_SPZ (a.ACC, p_date, 1))
              INTO x_event_date
              FROM BARS.ACCOUNTS a JOIN BARS.ND_ACC n ON (n.ACC = a.ACC)
             WHERE n.nd = p_nd AND a.TIP IN ('SPN');
         END;
      END IF;

      RETURN x_event_date;
   END;
BEGIN
   BEGIN                                     -- контрагенты страховых компаний
      SELECT 1
        INTO l_res
        FROM customer
       WHERE rnk = p_rnk AND ved IN ('N6511', 'N6512');
       return l_res;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;

   BEGIN
      FOR c IN (SELECT *
                  FROM cc_deal
                 WHERE     rnk = p_rnk
                       AND SUBSTR (prod, 1, 6) IN ('206309',
                                                   '206310',
                                                   '206325',
                                                   '206326'))
      LOOP
         BEGIN
            SELECT   SUM (
                        bars.gl.p_ncurval (
                           980,
                           bars.gl.p_icurval (
                              980,
                              bars.fost (a.acc, TRUNC (SYSDATE)),
                              TRUNC (SYSDATE)),
                           TRUNC (SYSDATE)))
                   / 100
              INTO l_borg_nd
              FROM bars.accounts a, bars.nd_acc na
             WHERE     a.acc = na.acc
                   AND na.ND = c.nd
                   AND a.tip IN ('SS ',
                                 'SP ',
                                 'SL ',
                                 'SN ',
                                 'SPN',
                                 'SLN',
                                 'SK0',
                                 'SK9',
                                 'SN8');
         END;

         l_borg_all := l_borg_all + l_borg_nd;

         l_date_spz := DATE_EXPIRED (TRUNC (SYSDATE), c.nd, 1);
      END LOOP;

      bars_audit.info ('l_borg_nd ' || l_borg_nd);
   END;

   IF l_borg_all > l_sum_osbb
   THEN
      l_res := 1;
   ELSIF     l_borg_all < l_sum_osbb
         AND TRUNC (SYSDATE) - NVL (l_date_spz, TRUNC (SYSDATE)) >=
                l_days_osbb
   THEN
      l_res := 1;
   ELSE
      l_res := 0;
   END IF;

   RETURN l_res;
END;
/

grant execute on f_get_osbb_k110_type to bars_access_user;