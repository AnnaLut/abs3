
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cena_cp.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE FUNCTION F_CENA_CP (P_ID     CP_KOD.ID%TYPE,
                                      P_DAT    DATE,
                                      REG      INT DEFAULT 0)
   RETURN NUMBER
IS
   L_CENA_START   CP_KOD.CENA_START%TYPE;
   L_NOM          CP_DAT.NOM%TYPE := 0;
   L_KUP          CP_DAT.KUP%TYPE;
   L_CENA         CP_KOD.CENA%TYPE;--CP_DAT.NOM%TYPE; --19.04.2018 із-за різних форматів 0.0001 трансформувалось у 0.
   L_NPP          CP_DAT.NPP%TYPE;
-- v.1.3 19.04.2018 28/04-15  28/10-14
-- return cena, kup or npp
BEGIN
   BEGIN
      SELECT NVL (CENA_START, CENA)
        INTO L_CENA_START
        FROM CP_KOD
       WHERE ID = P_ID;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
         --  l_sErr := l_sErr || l_kv|| ' НЕ знайдено рах '|| nvl(B_4621,'4221');
         --  raise_application_error(  -20203,l_sErr, TRUE);
         RETURN NULL;
   END;

   BEGIN
      SELECT NPP, NOM, KUP
        INTO L_NPP, L_NOM, L_KUP
        FROM CP_DAT_V
       WHERE ID = P_ID AND DOK <= P_DAT AND P_DAT < DNK;

      SELECT L_CENA_START - NVL (SUM (NVL (NOM, 0)), 0)
        INTO L_CENA
        FROM CP_DAT_V
       WHERE ID = P_ID AND DNK < P_DAT;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
         L_CENA := L_CENA_START;
   END;

   IF REG = 0
   THEN
      RETURN L_CENA;
   ELSIF REG = 1
   THEN
      RETURN L_KUP;
   ELSIF REG = 2
   THEN
      RETURN L_NPP;
   END IF;
END;
/
 show err;
 
PROMPT *** Create  grants  F_CENA_CP ***
grant EXECUTE                                                                on F_CENA_CP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CENA_CP       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cena_cp.sql =========*** End *** 
 PROMPT ===================================================================================== 
 