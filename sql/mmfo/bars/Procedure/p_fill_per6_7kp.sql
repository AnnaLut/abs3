CREATE OR REPLACE PROCEDURE p_fill_per6_7kp (p_nls5    VARCHAR2,
                                             p_nazn    VARCHAR2)
IS
   -- Наповнення довідника перекриття коригуючих за грудень 6,7 кл. на 5040(5041)
   l_errn       NUMBER := -20203;
   l_err_txt1   VARCHAR2 (100)
      := 'Призначення платежу не повинно перевищувати 160 символів';
   l_err_txt2   VARCHAR2 (100)
      := 'Заборонено виконання процедури на рівні /';
   l_kf         VARCHAR2 (6) := SYS_CONTEXT ('bars_context', 'user_mfo');
BEGIN
   IF LENGTH (p_nazn) > 160
   THEN
      raise_application_error (l_errn, l_err_txt1);
   END IF;

   IF l_kf IS NULL OR LENGTH (l_kf) < 6
   THEN
      raise_application_error (l_errn, l_err_txt2);
   END IF;

   DELETE FROM per6_7kp
         WHERE kf = l_kf;


   INSERT INTO per6_7kp (nls,
                         kv,
                         nlsb,
                         nazn,
                         dos,
                         kos,
                         ostf,
                         kf,
                         tobo)
        SELECT a.nls,
               a.kv,
               p_nls5,
               p_nazn,
               SUM (DECODE (p.dk, 0, p.s, 0)) DOS,
               SUM (DECODE (p.dk, 1, p.s, 0)) KOS,
               SUM (DECODE (p.dk, 1, p.s, 0)) - SUM (DECODE (p.dk, 0, p.s, 0))
                  OSTF,
               a.kf,
               a.tobo
          FROM accounts a, opldok p, oper o
         WHERE     a.acc = p.acc
               AND p.fdat >
                        glb_bankdate ()
                      - TO_NUMBER (TO_CHAR (glb_bankdate (), 'DD'))
               AND p.fdat <= glb_bankdate ()
               AND p.REF = o.REF
               AND o.sos = 5
               AND o.vob = 96
               AND o.tt NOT LIKE 'ZG%'
               AND SUBSTR (a.nbs, 1, 1) IN ('6', '7')
               AND a.kv = 980
               AND a.dazs IS NULL
               AND a.nls NOT IN (SELECT nls
                                   FROM per6_7kp
                                  WHERE nls IS NOT NULL)
      GROUP BY a.nls,
               a.kv,
               p_nls5,
               p_nazn,
               a.kf,
               a.tobo
      ORDER BY SUBSTR (a.nls, 1, 4), SUBSTR (a.nls, 6, 9);
END;
/

grant execute on p_fill_per6_7kp to bars_access_defrole;