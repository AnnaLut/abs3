
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/sp_bpk_50.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SP_BPK_50 (nd_ number, dat01_ DATE)
RETURN number IS

-- nd     - номер кредитного договора
-- dat01_ - дата, на которую определяется просрочка
-- возвращается 5, если по договору больше, чем 50% долга просрочено  больше 90 календарных дней

SP_     number; SS_    number; ssp_   number; pr_    number; bvk_   number; kat_   number;
dat31_  date  ;

begin
   dat31_:= Dat_last (dat01_ -4 , dat01_ -1 );  -- последний рабочий день месяца
   --узнать тек остаток
   select -Nvl(sum(case when trim(r.tip) in ('SP','SL','SPN','SK9') THEN ost_korr(r.acc,dat31_,null,'2625') else 0 end),0) SP,
          -Nvl(sum(case when trim(r.tip) in ('SS','SN'            ) THEN ost_korr(r.acc,dat31_,null,'2625') else 0 end),0) SS
          INTO  SP_, SS_
   from   rez_w4_bpk r where r.nd=nd_ and  trim(r.tip) in ('SP','SL','SPN','SK9','SS','SN');

   -- сумма просроченная >90 дней
   select SP_ - nvl(sum(dos),0) into ssp_ from saldoa
   where acc in (select acc from rez_w4_bpk
                 where nd= nd_  and (trim(tip) in ('SP','SL','SPN','SK9')) and ost_korr(acc,dat31_,null,'2526')<0) and
                       fdat >= dat01_-90;
   bvk_:=ss_+sp_;
   if bvk_ <>0   THEN  PR_  := ssp_/bvk_;
      if pr_>0.5 THEN  kat_ := 5;
      else             kat_ := 0;
      end if;
   else
                       kat_:=0;
   end if;
   return kat_;
end sp_bpk_50;
/
 show err;
 
PROMPT *** Create  grants  SP_BPK_50 ***
grant EXECUTE                                                                on SP_BPK_50       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/sp_bpk_50.sql =========*** End *** 
 PROMPT ===================================================================================== 
 