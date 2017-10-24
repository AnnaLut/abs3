CREATE OR REPLACE PROCEDURE dpt_set_truseteedaytes (
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
grant execute on dpt_set_truseteedaytes to bars_access_defrole;
/