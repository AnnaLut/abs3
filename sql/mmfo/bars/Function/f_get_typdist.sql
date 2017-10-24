
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_typdist.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_TYPDIST (p_rnk number)
-- функция для определения типа системы дистанционного обслуживания:
--  0 - не исп.
--  1 - обычный
--  2 - CORP2
return number 
is
 l_rez  number;
begin
 begin
  select 2 into l_rez from BARSAQ.IBANK_RNK i where i.rnk = p_rnk;
 exception when no_data_found then
   begin
     select 1 into l_rez from customer where sab is not null and rnk = p_rnk;
   exception when no_data_found then l_rez := 0;
   end;
 end;        
return l_rez;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_TYPDIST ***
grant EXECUTE                                                                on F_GET_TYPDIST   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_TYPDIST   to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_typdist.sql =========*** End 
 PROMPT ===================================================================================== 
 