
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dpt_irrevocable.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DPT_IRREVOCABLE (
   p_dptid IN dpt_deposit.deposit_id%TYPE)
   RETURN INT
IS
   l_irrevocable   INT := 0;
   l_vidd          DPT_VIDD.VIDD%TYPE;
   l_datbegin      dpt_deposit.dat_begin%TYPE;
   l_datend        dpt_deposit.dat_end%TYPE;
   l_accessed      int := 0;
BEGIN
   BEGIN
      SELECT vidd, dat_begin, dat_end
        INTO l_vidd, l_datbegin, l_datend
        FROM dpt_deposit
       WHERE deposit_id = p_dptid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
      begin
       SELECT vidd, dat_begin, dat_end
         INTO l_vidd, l_datbegin, l_datend
         FROM dpt_deposit_clos
        WHERE deposit_id = p_dptid and action_id = 0;
      EXCEPTION
          WHEN NO_DATA_FOUND
          THEN    raise_application_error (
            -20001,
            'ERR:  Неможливо визначити вид депозитного договору для номера '
            || TO_CHAR (p_dptid),
            TRUE);
      end;
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
             AND TO_DATE (d2.val, 'dd/mm/yyyy') <= l_datbegin
             and l_datend > bankdate;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN l_irrevocable := 0;
   END;

   if l_irrevocable = 1
   then
    begin
        select 0
          into l_irrevocable
          from CUST_REQUESTS CR, CUST_REQ_ACCESS CRA
         where CR.req_type = 2
           AND CRA.REQ_ID = CR.REQ_ID
           and CRA.CONTRACT_ID = p_dptid
           AND CR.REQ_STATE = 1;
    exception when no_data_found then bars_audit.trace('Не знайдено підтверджених запитів на Бек-офіс щодо дозволу на дострокове розірвання договору');
    end;
   end if;

   RETURN l_irrevocable;
END dpt_irrevocable;
/
 show err;
 
PROMPT *** Create  grants  DPT_IRREVOCABLE ***
grant DEBUG,EXECUTE                                                          on DPT_IRREVOCABLE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dpt_irrevocable.sql =========*** En
 PROMPT ===================================================================================== 
 