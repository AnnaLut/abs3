

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OBS_23_KP_BLOCK.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OBS_23_KP_BLOCK ***

  CREATE OR REPLACE PROCEDURE BARS.OBS_23_KP_BLOCK (P_dat01 DATE)  IS
begin
   if p_dat01<=sysdate THEN
      raise_application_error(-20000,'Розрахунок резерву заборонено!
                             Автоматичний розрахунок буде виконано при вигрузці данних T0 ');
   else
      obs_23(p_dat01,0,0);
   end if;
end;
/
show err;

PROMPT *** Create  grants  OBS_23_KP_BLOCK ***
grant EXECUTE                                                                on OBS_23_KP_BLOCK to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OBS_23_KP_BLOCK.sql =========*** E
PROMPT ===================================================================================== 
