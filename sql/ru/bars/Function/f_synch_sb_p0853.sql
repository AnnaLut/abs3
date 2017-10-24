
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_synch_sb_p0853.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SYNCH_SB_P0853 (
   typ_       IN   NUMBER,
   r020_      IN   sb_p0853.r020%TYPE,
   ob22_      IN   sb_p0853.ob22%TYPE,
   p080_      IN   sb_p0853.p080%TYPE,
   r020_fa_   IN   sb_p0853.r020_fa%TYPE
)
   RETURN VARCHAR2
IS
   ret_   VARCHAR2 (1000);
BEGIN
   CASE typ_
      WHEN 1
      THEN
         SELECT DISTINCT a.txt
                    INTO ret_
                    FROM sb_p0853n a
                   WHERE a.r020 = r020_
                     AND a.ob22 = ob22_
                     AND a.p080 = p080_
                     AND a.r020_fa = r020_fa_
                     AND a.d_open =
                            (SELECT MAX (s.d_open)
                               FROM sb_p0853n s
                              WHERE s.r020 = a.r020
                                AND s.ob22 = a.ob22
                                AND s.p080 = a.p080
                                AND s.r020_fa = a.r020_fa);
      WHEN 2
      THEN
         SELECT DISTINCT a.ap
                    INTO ret_
                    FROM sb_p0853n a
                   WHERE a.r020 = r020_
                     AND a.ob22 = ob22_
                     AND a.p080 = p080_
                     AND a.r020_fa = r020_fa_
                     AND a.d_open =
                            (SELECT MAX (s.d_open)
                               FROM sb_p0853n s
                              WHERE s.r020 = a.r020
                                AND s.ob22 = a.ob22
                                AND s.p080 = a.p080
                                AND s.r020_fa = a.r020_fa);
      WHEN 3
      THEN
         SELECT DISTINCT a.prizn_vidp
                    INTO ret_
                    FROM sb_p0853n a
                   WHERE a.r020 = r020_
                     AND a.ob22 = ob22_
                     AND a.p080 = p080_
                     AND a.r020_fa = r020_fa_
                     AND a.d_open =
                            (SELECT MAX (s.d_open)
                               FROM sb_p0853n s
                              WHERE s.r020 = a.r020
                                AND s.ob22 = a.ob22
                                AND s.p080 = a.p080
                                AND s.r020_fa = a.r020_fa);
      WHEN 4
      THEN
         SELECT DISTINCT TO_CHAR (a.d_close, 'ddmmyyyy')
                    INTO ret_
                    FROM sb_p0853n a
                   WHERE a.r020 = r020_
                     AND a.ob22 = ob22_
                     AND a.p080 = p080_
                     AND a.r020_fa = r020_fa_
                     AND a.d_open =
                            (SELECT MAX (s.d_open)
                               FROM sb_p0853n s
                              WHERE s.r020 = a.r020
                                AND s.ob22 = a.ob22
                                AND s.p080 = a.p080
                                AND s.r020_fa = a.r020_fa);
      WHEN 5
      THEN
         SELECT DISTINCT a.cod_act
                    INTO ret_
                    FROM sb_p0853n a
                   WHERE a.r020 = r020_
                     AND a.ob22 = ob22_
                     AND a.p080 = p080_
                     AND a.r020_fa = r020_fa_
                     AND a.d_open =
                            (SELECT MAX (s.d_open)
                               FROM sb_p0853n s
                              WHERE s.r020 = a.r020
                                AND s.ob22 = a.ob22
                                AND s.p080 = a.p080
                                AND s.r020_fa = a.r020_fa);
      ELSE
         NULL;
   END CASE;

   RETURN ret_;
END;
/
 show err;
 
PROMPT *** Create  grants  F_SYNCH_SB_P0853 ***
grant EXECUTE                                                                on F_SYNCH_SB_P0853 to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_SYNCH_SB_P0853 to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_synch_sb_p0853.sql =========*** E
 PROMPT ===================================================================================== 
 