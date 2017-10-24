

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_PAR_ZALOG.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_PAR_ZALOG ***

  CREATE OR REPLACE PROCEDURE BARS.P_PAR_ZALOG (p_dat01 date, p_acc accounts.acc%type,
       p_zal_bl   out  nbu23_rez.zal_bl%type    ,
       p_zal_blq  out  nbu23_rez.zal_blq%type   ,
       p_zal      out  nbu23_rez.zal%type       ,
       p_zalQ     out  nbu23_rez.zalq%type      ,
       p_SUM_IMP  out  nbu23_rez.SUM_IMP%type   ,
       p_SUMQ_IMP out  nbu23_rez.SUMQ_IMP%type  ,
       p_zal_sv   out  nbu23_rez.zal_sv%type    ,
       p_zal_svq  out  nbu23_rez.zal_svq%type
)
is

/* Версия 1.0 03-01-2017
   Балансовая стоимость залога по ACC
*/


begin
   begin
      select nvl(sum(sall),0)/100,nvl(sum(sallq),0)/100 into P_zal_BL, P_zal_BLq
      from   tmp_rez_zalog23 where dat = p_dat01 and accs = p_acc;
   exception when no_data_found then P_zal_BL := 0; P_zal_BLq := 0;
   end;
   begin
      SELECT SUM(nvl(t.S,0))/100,SUM(nvl(t.SQ,0))/100, sum(nvl(SUM_IMP,0))/100, sum(nvl(SUMQ_IMP,0))/100,sum(nvl(sall,0))/100,sum(nvl(sallq,0))/100
      into   P_zal, p_zalq, p_SUM_IMP, p_SUMQ_IMP,p_zal_sv, p_zal_svq  FROM TMP_REZ_OBESP23 t WHERE dat = p_dat01 and t.accs = p_acc;
   EXCEPTION WHEN NO_DATA_FOUND THEN P_Zal :=0; P_ZalQ :=0;
   end;
end;
/
show err;

PROMPT *** Create  grants  P_PAR_ZALOG ***
grant EXECUTE                                                                on P_PAR_ZALOG     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_PAR_ZALOG     to RCC_DEAL;
grant EXECUTE                                                                on P_PAR_ZALOG     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_PAR_ZALOG.sql =========*** End *
PROMPT ===================================================================================== 
