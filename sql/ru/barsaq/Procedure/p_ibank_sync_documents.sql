

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Procedure/P_IBANK_SYNC_DOCUMENTS.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_IBANK_SYNC_DOCUMENTS ***

  CREATE OR REPLACE PROCEDURE BARSAQ.P_IBANK_SYNC_DOCUMENTS (
   p_day_count NUMBER DEFAULT 2)
IS
   l_bankdate    DATE;
   l_startdate   DATE;
BEGIN
   bars.bc.subst_mfo (bars.f_ourmfo_g);

   SELECT bars.bankdate INTO l_bankdate FROM DUAL;

   SELECT MIN (fdat)
     INTO l_startdate
     FROM (SELECT fdat
             FROM (  SELECT fdat
                       FROM bars.fdat
                      WHERE fdat <= l_bankdate
                   ORDER BY fdat DESC)
            WHERE ROWNUM < p_day_count+1);

   bars.bc.set_context;
   DATA_IMPORT.SYNC_ALL_ACCOUNT_STMT (l_startdate);
END; 
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Procedure/P_IBANK_SYNC_DOCUMENTS.sql =====
PROMPT ===================================================================================== 
