

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/IR_OVR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure IR_OVR ***

  CREATE OR REPLACE PROCEDURE BARS.IR_OVR ( p_dat2 date) is

--- Процедура ежедневного расчета плавающих % ставок по Овердрафту (METR=7)

 l_Dat2 date   := NVL(p_DAT2, gl.bd ) -1;
 l_Int  number ;
begin
 for k in (SELECT i.acc, nvl(i.acr_dat+1,a.daos) Dat1
           FROM int_accN i, ACCOUNTS a
           WHERE i.metr = 7
             and i.id   = 0
             AND i.acc  = a.acc
             and a.dazs is null)
 loop
   OVR.INT_OVRP(k.Acc, 0, k.Dat1,l_Dat2, l_Int, Null,0 );
 end loop;

end IR_OVR;
/
show err;

PROMPT *** Create  grants  IR_OVR ***
grant EXECUTE                                                                on IR_OVR          to BARS010;
grant EXECUTE                                                                on IR_OVR          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/IR_OVR.sql =========*** End *** ==
PROMPT ===================================================================================== 
