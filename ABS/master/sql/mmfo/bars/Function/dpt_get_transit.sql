
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dpt_get_transit.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DPT_GET_TRANSIT (P_NLS_DPT       VARCHAR2,
                                                 P_NLS_DPT_OUT   VARCHAR2,
                                                 P_KV            NUMBER)
   RETURN VARCHAR2
IS
   TITLE       CONSTANT VARCHAR2(20) := 'DPT_GET_TRANSIT:';
   L_NLS       VARCHAR2 (14);
   L_ACC       NUMBER;
   L_NBS       VARCHAR2 (4);
   L_NBS_OUT   VARCHAR2 (4);
   L_BRANCH    ACCOUNTS.BRANCH%TYPE;
BEGIN
 bars_audit.info(TITLE || 'P_NLS_DPT = ' || P_NLS_DPT || ',P_NLS_DPT_OUT= '||P_NLS_DPT_OUT);
   SELECT ACC, NBS, BRANCH
     INTO L_ACC, L_NBS, L_BRANCH
     FROM ACCOUNTS
    WHERE NLS = P_NLS_DPT AND KV = P_KV;

   SELECT NBS
     INTO L_NBS_OUT
     FROM ACCOUNTS
    WHERE NLS = P_NLS_DPT_OUT AND KV = P_KV;

   IF (L_NBS IN ('2630', '2635') AND L_NBS_OUT IN ('2630', '2635') AND newnbs.g_state = 0) OR
     (L_NBS = '2630' AND L_NBS_OUT = '2630' AND newnbs.g_state = 1)
   THEN
      BEGIN
         SELECT NLS
           INTO L_NLS
           FROM ACCOUNTS
          WHERE     NBS = '2909'
                AND OB22 = '19'
                AND DAZS IS NULL
                AND KV = P_KV
                AND BRANCH = SUBSTR(L_BRANCH,1,15);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            BARS_ERROR.RAISE_NERROR ('BPK', 'TRANSITACC_NOT_FOUND');
      END;
   ELSE
      L_NLS := P_NLS_DPT;
   END IF;


   IF L_NLS IS NULL
   THEN
      BARS_ERROR.RAISE_NERROR ('BPK', 'TRANSITACC_NOT_FOUND');
   END IF;
   bars_audit.info(TITLE || 'L_NLS = ' || L_NLS);
   RETURN L_NLS;
END;
/
 show err;
 
PROMPT *** Create  grants  DPT_GET_TRANSIT ***
grant EXECUTE                                                                on DPT_GET_TRANSIT to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dpt_get_transit.sql =========*** En
 PROMPT ===================================================================================== 
 
