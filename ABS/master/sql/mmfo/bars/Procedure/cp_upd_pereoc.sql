

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_UPD_PEREOC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_UPD_PEREOC ***

  CREATE OR REPLACE PROCEDURE BARS.CP_UPD_PEREOC (p_ref         IN NUMBER,
                                           p_rate_b      IN NUMBER,
                                           p_fl_alg      IN NUMBER,
                                           p_QUOT_SIGN   IN INT,
                                           P_REZ23       IN NUMBER,
                                           P_PEREOC23    IN NUMBER,
                                           P_FL_ALG23    IN NUMBER,
                                           P_DATREZ23    IN DATE,
                                           P_KOL_CP      IN NUMBER)
IS
   cp_dealset   cp_pereoc_v%ROWTYPE;
BEGIN
   BEGIN
      SELECT *
        INTO cp_dealset
        FROM cp_pereoc_v
       WHERE REF = p_ref;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         bars_audit.error (
               'cp_upd_pereoc не найдена строка с реф = '
            || TO_CHAR (p_ref));
   END;

   IF    p_rate_b != cp_dealset.rate_b
      OR p_fl_alg != cp_dealset.fl_alg
      OR (cp_dealset.rate_b IS NULL AND p_rate_b IS NOT NULL)
      OR (p_rate_b IS NULL AND cp_dealset.rate_b IS NOT NULL)
   THEN
      DELETE FROM cp_rates_sb
            WHERE REF = p_ref;

      -- котировка на угоду

      INSERT INTO cp_rates_sb (REF,
                               rate_b,
                               quot_sign,
                               fl_alg)
           VALUES (p_ref,
                   p_rate_b,
                   p_quot_sign,
                   p_fl_alg);
   END IF;
/*УСТАРІЛО
   IF    p_rez23 != cp_dealset.rez23
      OR p_fl_alg23 IS NOT NULL
      OR p_pereoc23 IS NOT NULL
      OR (cp_dealset.rez23 IS NULL AND p_rez23 IS NOT NULL)
      OR (p_rez23 IS NULL AND cp_dealset.rez23 IS NOT NULL)
   THEN
      DELETE FROM cp_rezerv23
            WHERE REF = cp_dealset.REF;

      IF    p_rez23 IS NOT NULL
         OR p_fl_alg23 IS NOT NULL
         OR p_pereoc23 IS NOT NULL
      THEN
         logger.info ('REZ_CP23-1 :new.pereoc23=' || p_pereoc23);
         cp_rez23 (p_DATREZ23,
                   p_REF,
                   p_REZ23,
                   p_KOL_CP,
                   p_pereoc23,
                   p_fl_alg23);
      END IF;
   END IF;
*/
END;
/
show err;

PROMPT *** Create  grants  CP_UPD_PEREOC ***
grant EXECUTE                                                                on CP_UPD_PEREOC   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_UPD_PEREOC.sql =========*** End
PROMPT ===================================================================================== 
