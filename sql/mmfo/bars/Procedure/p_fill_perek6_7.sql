CREATE OR REPLACE PROCEDURE p_fill_perek6_7 (p_nls5    VARCHAR2,
                                             p_nazn    VARCHAR2)
IS
-- Наповнення довідника перекриття 6,7 класів на 5040(5041)
   l_errn   NUMBER := -20203;
   l_err_txt1    VARCHAR2 (100) := 'Призначення платежу не повинно перевищувати 160 символів';
   l_err_txt2    VARCHAR2 (100) := 'Заборонено виконання процедури на рівні /';
   l_kf VARCHAR2 (6) := sys_context('bars_context','user_mfo');
BEGIN
   IF LENGTH (p_nazn) > 160
   THEN
      raise_application_error (l_errn, l_err_txt1);
   END IF;
   
   IF l_kf is null or LENGTH (l_kf) < 6 
   THEN
      raise_application_error (l_errn, l_err_txt2);
   END IF;
   
   delete from perek6_7 where kf = l_kf;
   
   
   INSERT INTO perek6_7 (nlsa,
                         nlsb,
                         nazn,
                         kf,
                         tobo)
        SELECT a.nls,
               p_nls5,
               p_nazn,
               a.kf,
               a.tobo
          FROM accounts a
         WHERE     SUBSTR (a.nbs, 1, 1) IN ('6', '7')
               AND a.kv = 980
               AND a.dazs IS NULL
               AND a.nls NOT IN (SELECT nlsa
                                   FROM perek6_7
                                  WHERE nlsa IS NOT NULL)
      ORDER BY SUBSTR (a.nls, 1, 4), SUBSTR (a.nls, 6, 9);
END;
/

grant execute on p_fill_perek6_7 to bars_access_defrole;
