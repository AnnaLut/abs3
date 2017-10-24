

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REZ_DAT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REZ_DAT ***

  CREATE OR REPLACE PROCEDURE BARS.P_REZ_DAT (mode_ int) IS

dat01_ date;
dat31_ date;

begin
   dat01_ := round(sysdate,'MM');
   dat31_ := Dat_last (dat01_-4,dat01_-1);
   update rez_protocol set crc = null where dat=dat31_;
end;
/
show err;

PROMPT *** Create  grants  P_REZ_DAT ***
grant EXECUTE                                                                on P_REZ_DAT       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_REZ_DAT       to RCC_DEAL;
grant EXECUTE                                                                on P_REZ_DAT       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REZ_DAT.sql =========*** End ***
PROMPT ===================================================================================== 
