
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/sp_90_deb.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SP_90_DEB (p_acc number, dat01_ DATE) RETURN number  IS

-- nd     - номер кредитного договора
-- dat01_ - дата, на которую определяется просрочка
-- возвращается 1, если есть просрочка > 90 дней по счетам дебиторки

/* Версия 1.0 18-09-2017

*/

ssp_   number;  bvk_   number;  l_90   number; l_ost  number;
dat31_ date  ;

begin
   dat31_:= Dat_last_work(dat01_ -1 );  -- последний рабочий день месяца
   --узнать тек остаток
   begin
      select - ost_korr(a.acc,dat31_,null,a.nbs)  into  l_ost
       from  accounts a
       where a.acc = p_acc;
   EXCEPTION WHEN NO_DATA_FOUND THEN  l_ost  := 0;
   end;
   -- сумма просроченная >30 дней
   begin
      select l_ost - nvl(sum(dos),0) into ssp_ from saldoa
      where acc = p_acc and fdat >=  dat01_- 90 ;
   EXCEPTION WHEN NO_DATA_FOUND THEN ssp_:=0;
   end;
   bvk_ := ssp_;
   if bvk_ <> 0 THEN l_90 := 1;
   else              l_90 := 0;
   end if;
   return l_90;
end SP_90_deb;
/
 show err;
 
PROMPT *** Create  grants  SP_90_DEB ***
grant EXECUTE                                                                on SP_90_DEB       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SP_90_DEB       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/sp_90_deb.sql =========*** End *** 
 PROMPT ===================================================================================== 
 