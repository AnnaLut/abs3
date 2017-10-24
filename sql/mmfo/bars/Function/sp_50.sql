
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/sp_50.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SP_50 (nd_ number, dat01_ DATE)
RETURN number IS

-- nd     - номер кредитного договора
-- dat01_ - дата, на которую определяется просрочка
-- возвращается 5, если по договору больше, чем 50% долга просрочено
-- больше 90 календарных дней
/*
02-08-2016 LUDA Dat_last  --> Dat_last_work
*/

kos_   number;
SP_    number;
SPN_   number;
SK9_   number;
SL_    number;
SN_    number;
SS_    number;
ssp_   number;
sspn_  number;
pr_    number;
bvk_   number;
kat_   number;
dat31_ date;

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
       where a.acc=n.acc and n.nd=nd_
        and (trim(tip) in ('SP','SL','SPN','SK9','SS','SN'));
   EXCEPTION WHEN NO_DATA_FOUND THEN
      SP_  := 0;
      SPN_ := 0;
      SK9_ := 0;
      SL_  := 0;
      SS_  := 0;
      SN_  := 0;
   end;
   -- сумма просроченная >90 дней
   begin
      select SP_ + SL_ - nvl(sum(dos),0) into ssp_ from saldoa
      where acc in (select a.acc from accounts a,nd_acc n
                    where n.nd=nd_ and n.acc=a.acc and trim(a.tip) in ('SP')
                          and ost_korr(a.acc,dat31_,null,a.nbs)<0)
            and fdat>=(select dat01_-90 from dual);
   EXCEPTION WHEN NO_DATA_FOUND THEN
      sp_:=0;
   end;
   begin
      select SPN_ - nvl(sum(dos),0) into sspn_ from saldoa
      where acc in (select a.acc from accounts a,nd_acc n
                    where n.nd=nd_ and n.acc=a.acc and trim(a.tip) in ('SPN')
                          and ost_korr(a.acc,dat31_,null,a.nbs)<0)
            and fdat>=(select dat01_-90 from dual);
   EXCEPTION WHEN NO_DATA_FOUND THEN
      spn_:=0;
   end;
   bvk_:=ss_+sp_+sn_+sl_+spn_;
   if bvk_ <>0 THEN
      PR_:=(ssp_+sspn_)/bvk_;
      if pr_>0.5 THEN
         kat_:=5;
      else
         kat_:=0;
      end if;
   else
      kat_:=0;
   end if;
--   logger.info('sp_50 : pr_  = ' || pr_  ) ;
--   logger.info('sp_50 : bvk_ = ' || bvk_ ) ;
--   logger.info('sp_50 : SP_  = ' || SP_  ) ;
--   logger.info('sp_50 : SPN_ = ' || SPN_ ) ;
--   logger.info('sp_50 : SL_  = ' || SL_  ) ;
--   logger.info('sp_50 : SS_  = ' || SS_  ) ;
--   logger.info('sp_50 : SN_  = ' || SN_  ) ;
--   logger.info('sp_50 : SSP_ = ' || SSP_ ) ;
--   logger.info('sp_50 : SSPN_= ' || SSPN_) ;
   return kat_;
end sp_50;
/
 show err;
 
PROMPT *** Create  grants  SP_50 ***
grant EXECUTE                                                                on SP_50           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SP_50           to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/sp_50.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 