
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/t902nls.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.T902NLS (P_BLK number,
                                        P_KV NUMBER,
                                        P_DK number,
                                        P_TT varchar2) return varchar2 IS
  L_NLS varchar2(15);
BEGIN
  BEGIN
    SELECT t.nls INTO L_NLS FROM t902_Acc t WHERE T.BLK = P_BLK and T.KV = P_KV and T.TT = P_TT and T.DK = P_DK;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    L_NLS := '';
  END;
  RETURN L_NLS ;
END T902nls;
/
 show err;
 
PROMPT *** Create  grants  T902NLS ***
grant EXECUTE                                                                on T902NLS         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on T902NLS         to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/t902nls.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 