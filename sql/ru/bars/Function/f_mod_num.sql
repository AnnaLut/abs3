
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_mod_num.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_MOD_NUM (p_num IN VARCHAR2)
   RETURN VARCHAR2
IS
   l_km    VARCHAR2 (5);
   l_kb    VARCHAR2 (5);
   l_num   VARCHAR2 (11);
BEGIN
   --
   -- ?-??? ?????????????? alegrob.num --> alegrob.mod_num
   --
   l_num := TRIM (p_num);
   l_km :=
      LPAD (CASE
               WHEN INSTR (l_num, '/') = 0
                  THEN l_num
               ELSE SUBSTR (l_num, 1, INSTR (l_num, '/') - 1)
            END,
            5,
            '0'
           );
   l_kb :=
      LPAD (CASE
               WHEN INSTR (l_num, '/') = 0
                  THEN ''
               ELSE SUBSTR (l_num, INSTR (l_num, '/') + 1)
            END,
            5,
            '0'
           );
   RETURN l_km || '/' || CASE
             WHEN l_kb IS NULL
                THEN '00000'
             ELSE l_kb
          END;
END f_mod_num;
/
 show err;
 
PROMPT *** Create  grants  F_MOD_NUM ***
grant EXECUTE                                                                on F_MOD_NUM       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_mod_num.sql =========*** End *** 
 PROMPT ===================================================================================== 
 