

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ZALOG_BLOCK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ZALOG_BLOCK ***

  CREATE OR REPLACE PROCEDURE BARS.ZALOG_BLOCK (P_dat01 DATE)  IS
begin
   if p_dat01<=sysdate THEN
      raise_application_error(-20000,'Розрахунок резерву заборонено!
                             Автоматичний розрахунок буде виконано при вигрузці данних T0 ');
   else
      z23.zalog(p_dat01);
   end if;
end;
/
show err;

PROMPT *** Create  grants  ZALOG_BLOCK ***
grant EXECUTE                                                                on ZALOG_BLOCK     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ZALOG_BLOCK     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ZALOG_BLOCK.sql =========*** End *
PROMPT ===================================================================================== 
