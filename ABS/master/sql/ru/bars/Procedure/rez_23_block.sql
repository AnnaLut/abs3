

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REZ_23_BLOCK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REZ_23_BLOCK ***

  CREATE OR REPLACE PROCEDURE BARS.REZ_23_BLOCK (P_dat01 DATE)  IS
begin
   if p_dat01<=sysdate THEN
      raise_application_error(-20000,'Розрахунок резерву заборонено!
                             Автоматичний розрахунок буде виконано при вигрузці данних T0 ');
   else
      z23.rez_23(p_dat01);
   end if;
end;
/
show err;

PROMPT *** Create  grants  REZ_23_BLOCK ***
grant EXECUTE                                                                on REZ_23_BLOCK    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REZ_23_BLOCK.sql =========*** End 
PROMPT ===================================================================================== 
