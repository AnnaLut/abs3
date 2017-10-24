

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_EXPPAY_ALL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_EXPPAY_ALL ***

  CREATE OR REPLACE PROCEDURE BARS.CP_EXPPAY_ALL (P_REF     IN NUMBER,
                                           MODE1     IN NUMBER DEFAULT 0,
                                           P_SUMN    IN NUMBER DEFAULT 0,
                                           MODE2     IN NUMBER DEFAULT 0,
                                           P_SUMR    IN NUMBER DEFAULT 0)
IS
BEGIN
  bars_audit.trace('cp_exppay_all = '|| to_char(P_REF)||', MODE_N = '|| to_char(MODE1) ||', MODE_R = ' || to_char(MODE2));
   IF MODE1 = 1
   THEN
      P_CP_PAYEXPIRY (P_REF => P_REF, P_MODE => 0, P_SUMN =>P_SUMN);
   END IF;

   IF MODE2 = 1
   THEN
      P_CP_PAYEXPIRY (P_REF => P_REF, P_MODE => 1, P_SUMR =>P_SUMR);
   END IF;
END cp_exppay_all;
/
show err;

PROMPT *** Create  grants  CP_EXPPAY_ALL ***
grant EXECUTE                                                                on CP_EXPPAY_ALL   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_EXPPAY_ALL.sql =========*** End
PROMPT ===================================================================================== 
