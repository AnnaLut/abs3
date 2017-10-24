
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dpt_get_s_transit.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DPT_GET_S_TRANSIT (P_NLS_DPT        VARCHAR2,
                                                   P_NLS_DPT_OUT    VARCHAR2,
                                                   P_KV             NUMBER,
                                                   P_S              NUMBER)
   RETURN INT
IS
   L_S     INT := 0;
   L_NLS   VARCHAR2 (14);
BEGIN
   L_NLS := BARS.DPT_GET_TRANSIT (P_NLS_DPT, P_NLS_DPT_OUT, P_KV);

   IF L_NLS != P_NLS_DPT
   THEN
      L_S := P_S;
   ELSE
      L_S := 0;
   END IF;

   RETURN L_S;
END;
/
 show err;
 
PROMPT *** Create  grants  DPT_GET_S_TRANSIT ***
grant EXECUTE                                                                on DPT_GET_S_TRANSIT to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dpt_get_s_transit.sql =========*** 
 PROMPT ===================================================================================== 
 