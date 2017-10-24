
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cc_dat_sp.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CC_DAT_SP (nd_ number)return date as
dat_ date;
datAll_ date;
-- ¬озвращает дату возникновени€ просрочки
 begin
 for k in (select n.acc,a.daos from nd_acc n, accounts a where a.acc=n.acc and a.tip in ('SP ','SL ') and n.nd=nd_)
  loop
   select min(fdat) into dat_  from saldoa where acc=k.acc and ostf-dos+kos<>0 and
          fdat>nvl((select max(fdat) from saldoa where acc=k.acc and
                        fdat>=k.daos and ostf-dos+kos=0),k.daos);

   if dat_ is not null then
     if dat_<=nvl(datALL_,dat_) then
        datAll_:=nvl(datALL_,dat_);
     end if;
   end if;
  end loop;
 return datAll_;
 end cc_dat_sp;
 
/
 show err;
 
PROMPT *** Create  grants  CC_DAT_SP ***
grant EXECUTE                                                                on CC_DAT_SP       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_DAT_SP       to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cc_dat_sp.sql =========*** End *** 
 PROMPT ===================================================================================== 
 