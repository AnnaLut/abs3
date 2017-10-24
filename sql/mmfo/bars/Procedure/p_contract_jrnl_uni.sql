

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CONTRACT_JRNL_UNI.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CONTRACT_JRNL_UNI ***

  CREATE OR REPLACE PROCEDURE BARS.P_CONTRACT_JRNL_UNI (p_dat DATE)
IS
BEGIN

  IF p_dat = bankdate THEN

     p_contract_jrnl (0, p_dat);
     p_contract_jrnl (1, p_dat);
     p_contract_ref  (0, p_dat);
     p_contract_ref  (1, p_dat);

  END IF;

END p_contract_jrnl_uni;
/
show err;

PROMPT *** Create  grants  P_CONTRACT_JRNL_UNI ***
grant EXECUTE                                                                on P_CONTRACT_JRNL_UNI to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_CONTRACT_JRNL_UNI to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CONTRACT_JRNL_UNI.sql =========*
PROMPT ===================================================================================== 
