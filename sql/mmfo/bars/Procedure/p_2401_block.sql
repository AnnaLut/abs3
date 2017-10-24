

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_2401_BLOCK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_2401_BLOCK ***

  CREATE OR REPLACE PROCEDURE BARS.P_2401_BLOCK (P_dat01 DATE)  IS
begin
   if p_dat01<=sysdate THEN
      raise_application_error(-20000,'Розрахунок резерву заборонено!
                             Автоматичний розрахунок буде виконано при вигрузці данних T0 ');
   else
      p_2401(p_dat01);
   end if;
end;
/
show err;

PROMPT *** Create  grants  P_2401_BLOCK ***
grant EXECUTE                                                                on P_2401_BLOCK    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_2401_BLOCK    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_2401_BLOCK.sql =========*** End 
PROMPT ===================================================================================== 
