
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/sp_30_osbb.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SP_30_OSBB (nd_ number, dat01_ DATE) RETURN number  IS

-- nd     - номер кредитного договора
-- dat01_ - дата, на которую определяется просрочка
-- возвращается 1, если есть просрочка > 30 ДНЕЙ

/* Версия 1.0 18-09-2017

*/

SP_    number;  SPN_   number;  SK9_   number;  SL_    number ;  SN_    number;  SS_    number;  ssp_   number;
sspn_  number;  bvk_   number;  dat31_ date  ;  l_30   number;

begin
   dat31_:= Dat_last_work(dat01_ -1 );  -- последний рабочий день месяца
   --узнать тек остаток
   begin
      select -Nvl(sum(decode (a.tip,'SP ',ost_korr(a.acc,dat31_,null,a.nbs),0)),0),
             -Nvl(sum(decode (a.tip,'SPN',ost_korr(a.acc,dat31_,null,a.nbs),0)),0),
             -Nvl(sum(decode (a.tip,'SK9',ost_korr(a.acc,dat31_,null,a.nbs),0)),0),
             -Nvl(sum(decode (a.tip,'SL ',ost_korr(a.acc,dat31_,null,a.nbs),0)),0),
             -Nvl(sum(decode (a.tip,'SS ',ost_korr(a.acc,dat31_,null,a.nbs),0)),0),
             -Nvl(sum(decode (a.tip,'SN ',ost_korr(a.acc,dat31_,null,a.nbs),0)),0)
       into  SP_,SPN_,SK9_,SL_,SS_,SN_
       from  accounts a, nd_acc n
       where a.acc=n.acc and n.nd=nd_  and (trim(tip) in ('SP','SL','SPN','SK9','SS','SN'));
   EXCEPTION WHEN NO_DATA_FOUND THEN  SP_  := 0;  SPN_ := 0; SK9_ := 0;
                                      SL_  := 0;  SS_  := 0; SN_  := 0;
   end;
   -- сумма просроченная >30 дней
   begin
      select SP_ + SL_ - nvl(sum(dos),0) into ssp_ from saldoa
      where acc in (select a.acc from accounts a,nd_acc n
                    where n.nd=nd_ and n.acc=a.acc and trim(a.tip) in ('SP') and ost_korr(a.acc,dat31_,null,a.nbs)<0)
                          and fdat>=(select dat01_-30 from dual);
   EXCEPTION WHEN NO_DATA_FOUND THEN  sp_:=0;
   end;
   begin
      select SPN_ - nvl(sum(dos),0) into sspn_ from saldoa
      where acc in (select a.acc from accounts a,nd_acc n
                    where n.nd=nd_ and n.acc=a.acc and trim(a.tip) in ('SPN') and ost_korr(a.acc,dat31_,null,a.nbs)<0)
                          and fdat>=(select dat01_-30 from dual);
   EXCEPTION WHEN NO_DATA_FOUND THEN spn_:=0;
   end;
   bvk_:=ssp_+sspn_;
   if bvk_ <> 0 THEN l_30 := 1;
   else              l_30 := 0;
   end if;
   return l_30;
end sp_30_OSBB;
/
 show err;
 
PROMPT *** Create  grants  SP_30_OSBB ***
grant EXECUTE                                                                on SP_30_OSBB      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SP_30_OSBB      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/sp_30_osbb.sql =========*** End ***
 PROMPT ===================================================================================== 
 