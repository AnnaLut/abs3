

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_SET_TRUSETEEDAYTES.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPT_SET_TRUSETEEDAYTES ***

  CREATE OR REPLACE PROCEDURE BARS.DPT_SET_TRUSETEEDAYTES (
   p_deposit_id    IN dpt_deposit.deposit_id%TYPE,
   p_agrmnt_num    IN dpt_agreements.agrmnt_num%TYPE,
   p_agrmnt_date   IN DATE,
   p_date_begin    IN DATE,
   p_date_end      IN DATE)
IS
BEGIN
   UPDATE dpt_agreements
      SET AGRMNT_DATE = p_AGRMNT_DATE,
          DATE_BEGIN = p_DATE_BEGIN,
          DATE_END = p_DATE_END
    WHERE DPT_ID = p_deposit_id AND AGRMNT_ID = p_agrmnt_num;
END;
/
show err;

PROMPT *** Create  grants  DPT_SET_TRUSETEEDAYTES ***
grant EXECUTE                                                                on DPT_SET_TRUSETEEDAYTES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_SET_TRUSETEEDAYTES.sql =======
PROMPT ===================================================================================== 
