

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REZ_23_BLOCK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REZ_23_BLOCK ***

  CREATE OR REPLACE PROCEDURE BARS.REZ_23_BLOCK (P_dat01 DATE,p_mode NUMBER)  IS
begin
   if p_dat01<=sysdate THEN
      raise_application_error(-20000,'Розрахунок резерву заборонено!
                             Автоматичний розрахунок буде виконано при вигрузці данних T0 ');
   elsif p_mode = 1 THEN z23.rez_23(p_dat01)     ; -- !!Формування+Перег+Кор ЗАГАЛЬНОГО протоколу по НБУ-23
   elsif p_mode = 2 THEN p_2401(p_dat01)         ; -- ->00.Розподіл фін.актівів на суттєві та несуттєві
   elsif p_mode = 3 THEN Z23.START_REZ(p_dat01,0); -- ->01. Перенесення поточних ГПК в архiв
   elsif p_mode = 4 THEN obs_23(p_dat01,0,0)     ; -- ->02.Розрахунок ОБС.БОРГУ по КП
   elsif p_mode = 5 THEN obs_23(p_dat01,0,2)     ; -- ->03.Розрахунок ОБС.БОРГУ по МБК
   elsif p_mode = 6 THEN obs_23(p_dat01,0,3)     ; -- ->04.Розрахунок ОБС.БОРГУ по БПK
   elsif p_mode = 7 THEN obs_23(p_dat01,0,1)     ; -- ->04_0.Розрахунок ОБС.БОРГУ по ОВЕРДРАФТАМ
   elsif p_mode = 8 THEN z23.zalog(p_dat01)      ; -- ->05. Розрахунок ЗАБЕЗПЕЧЕННЯ
   ELSE  return;
   end if;
end;
/
show err;

PROMPT *** Create  grants  REZ_23_BLOCK ***
grant EXECUTE                                                                on REZ_23_BLOCK    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REZ_23_BLOCK    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REZ_23_BLOCK.sql =========*** End 
PROMPT ===================================================================================== 
