

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_EXP_ALL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_EXP_ALL ***

  CREATE OR REPLACE PROCEDURE BARS.CP_EXP_ALL (P_CP_ID   IN NUMBER,
                                        MODE1     IN NUMBER DEFAULT 0,
                                        MODE2     IN NUMBER DEFAULT 0)
IS
BEGIN
  bars_audit.trace('P_CP_ID = '|| to_char(P_CP_ID)||', MODE_N = '|| to_char(MODE1) ||', MODE_R = ' || to_char(MODE2));
   IF MODE1 = 1
   THEN
      P_CP_EXPIRY (P_CP_ID => P_CP_ID, P_MODE => 0);
   END IF;

   IF MODE2 = 1
   THEN
      P_CP_EXPIRY (P_CP_ID => P_CP_ID, P_MODE => 1);
   END IF;
END cp_exp_all;
/
show err;

PROMPT *** Create  grants  CP_EXP_ALL ***
grant EXECUTE                                                                on CP_EXP_ALL      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_EXP_ALL.sql =========*** End **
PROMPT ===================================================================================== 
