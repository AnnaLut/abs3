CREATE OR REPLACE FUNCTION BARS.dpt_isirrevocable (
   p_dptid IN dpt_deposit.deposit_id%TYPE)
   RETURN INT
IS
   l_irrevocable   INT := 0;
   l_vidd          DPT_VIDD.VIDD%TYPE;
   l_datbegin      dpt_deposit.dat_begin%TYPE;
   l_accessed      int := 0;
BEGIN
   BEGIN
      SELECT vidd, datz
        INTO l_vidd, l_datbegin
        FROM dpt_deposit_clos
       WHERE deposit_id = p_dptid
       and action_id = 0;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         raise_application_error (
            -20001,
            'ERR:  Неможливо визначити вид депозитного договору для номера '
            || TO_CHAR (p_dptid),
            TRUE);
   END;

   BEGIN
      SELECT 1
        INTO l_irrevocable
        FROM dpt_vidd_params d1, dpt_vidd_params d2
       WHERE     d1.vidd = l_vidd
             AND d1.tag = 'FORB_EARLY'
             AND d1.VAL = 1
             AND d1.vidd = d2.vidd
             AND d2.tag = 'FORB_EARLY_DATE'
             AND TO_DATE (d2.val, 'dd/mm/yyyy') <= l_datbegin;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN l_irrevocable := 0;
   END;  

   RETURN l_irrevocable;
END dpt_isirrevocable;
/
grant execute on dpt_isirrevocable to bars_access_defrole;
/