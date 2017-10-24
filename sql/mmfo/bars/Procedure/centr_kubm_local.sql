

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CENTR_KUBM_LOCAL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CENTR_KUBM_LOCAL ***

  CREATE OR REPLACE PROCEDURE BARS.CENTR_KUBM_LOCAL ( p_mode  IN  int ) is
  -- перенос всех курсов по изделиям из БМ в локальные
begin
  if p_mode = 1 then
     update V_CENTR_KUBM set cena_k = cena_kupi  where cena_kupi is not null ;
     update V_CENTR_KUBM set cena  = cena_prod   where cena_prod is not null ;
  end if;
  RETURN  ;
end centr_kubm_local ;
/
show err;

PROMPT *** Create  grants  CENTR_KUBM_LOCAL ***
grant EXECUTE                                                                on CENTR_KUBM_LOCAL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CENTR_KUBM_LOCAL to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CENTR_KUBM_LOCAL.sql =========*** 
PROMPT ===================================================================================== 
