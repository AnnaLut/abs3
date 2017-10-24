
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dpt_hasno35agrmnt.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DPT_HASNO35AGRMNT (p_dptid IN dpt_deposit.deposit_id%TYPE)
   RETURN INT
  is
   l_hasno35agrmnt int := 1; --
   l_date_end date;
   l_vidd_irrevocable INT := 0;
  begin


   BEGIN
      SELECT 1
        INTO l_vidd_irrevocable
        FROM dpt_vidd_params d1, dpt_vidd_params d2, dpt_deposit d
       WHERE     D.DEPOSIT_ID = p_dptid
             AND d1.vidd = d.vidd
             AND d1.tag = 'FORB_EARLY'
             AND d1.VAL = 1
             AND d1.vidd = d2.vidd
             AND d2.tag = 'FORB_EARLY_DATE'
             AND TO_DATE (d2.val, 'dd/mm/yyyy') <= d.dat_begin
             and d.dat_end > bankdate;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN l_vidd_irrevocable := 0;
           return 0;
   END;

   begin
   select 0
     into l_hasno35agrmnt
     from dpt_agreements
     where dpt_id = p_dptid
       and AGRMNT_STATE = 1
       and AGRMNT_TYPE = 35;
   exception when no_data_found
             then l_hasno35agrmnt := 1;
                  bars_audit.trace('Не знайдено активного ДУ 35 дозволу на дострокове розірвання договору');
   end;
   --if dpt_irrevocable(p_dptid)= 0 and l_hasno35agrmnt = 1
   --then l_hasno35agrmnt := 0;
   --end if;
   begin
    select dat_end
      into l_date_end
      from dpt_deposit
     where deposit_id = p_dptid;
   end;
   if l_date_end <= bankdate then l_hasno35agrmnt := 0;
   end if;
   return l_hasno35agrmnt;
  end dpt_hasno35agrmnt;
/
 show err;
 
PROMPT *** Create  grants  DPT_HASNO35AGRMNT ***
grant DEBUG,EXECUTE                                                          on DPT_HASNO35AGRMNT to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dpt_hasno35agrmnt.sql =========*** 
 PROMPT ===================================================================================== 
 