

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REZ_351_BLOCK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REZ_351_BLOCK ***

  CREATE OR REPLACE PROCEDURE BARS.REZ_351_BLOCK (P_dat01 DATE,p_mode NUMBER)  IS
begin
   if p_dat01<=sysdate and sys_context('bars_context','user_mfo') not in ('300465','324805') THEN
      raise_application_error(-20000,'Розрахунок резерву заборонено!
                             Автоматичний розрахунок буде виконано при вигрузці данних T0 ');
   elsif p_mode = 1 THEN cr(p_dat01)               ; -- !!Формування+Перег+Кор ЗАГАЛЬНОГО протоколу по НБУ-23
   elsif p_mode = 2 THEN
         Z23.START_REZ(p_dat01,0);
         p_2401(p_dat01)           ; -- ->00.Розподіл фін.актівів на суттєві та несуттєві
   elsif p_mode = 3 THEN z23.zalog(p_dat01)        ; -- ->05. Розрахунок ЗАБЕЗПЕЧЕННЯ
   ELSE  return;
   end if;
end;
/
show err;

PROMPT *** Create  grants  REZ_351_BLOCK ***
grant EXECUTE                                                                on REZ_351_BLOCK   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REZ_351_BLOCK   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REZ_351_BLOCK.sql =========*** End
PROMPT ===================================================================================== 
