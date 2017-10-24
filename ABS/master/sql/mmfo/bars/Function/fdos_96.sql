
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fdos_96.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FDOS_96 (p_acc INTEGER, p_fdat1 DATE, p_fdat2 DATE)
RETURN DECIMAL IS
l_nn     DECIMAL;
l_nn_m   decimal;   -- вычтем,  пришедшие из будущих периодов
l_nn_p   decimal;   -- добавим, ушедшие в прошлый период
BEGIN
/*
    QWA: 16-04-2009
    Использ.в сальдовке для Подат.обл?ку (з кориг.096)
*/
 begin
   select nvl(sum(s),0) into l_nn_m     from provnu_96
   where accd=p_acc     and    fdat>=p_Fdat1 and fdat<=p_Fdat2;
   exception when no_data_found then l_nn_m:=0;
 end;
 begin
   select nvl(sum(s),0) into l_nn_p     from provnu_96
   where accd=p_acc     and    datpf>=p_Fdat1 and datpf<=p_Fdat2;
   exception when no_data_found then l_nn_p:=0;
 end;
   l_nn:=-l_nn_m+l_nn_p;
   RETURN l_nn;
END FDOS_96;
 
/
 show err;
 
PROMPT *** Create  grants  FDOS_96 ***
grant EXECUTE                                                                on FDOS_96         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FDOS_96         to RPBN001;
grant EXECUTE                                                                on FDOS_96         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fdos_96.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 