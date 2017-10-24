

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/START_REZ_BLOCK.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure START_REZ_BLOCK ***

  CREATE OR REPLACE PROCEDURE BARS.START_REZ_BLOCK (P_dat01 DATE)  IS
begin
   if p_dat01<=sysdate THEN
      raise_application_error(-20000,'Розрахунок резерву заборонено!
                             Автоматичний розрахунок буде виконано при вигрузці данних T0 ');
   else
      Z23.START_REZ(p_dat01,0);
   end if;
end;
/
show err;

PROMPT *** Create  grants  START_REZ_BLOCK ***
grant EXECUTE                                                                on START_REZ_BLOCK to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/START_REZ_BLOCK.sql =========*** E
PROMPT ===================================================================================== 
