
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dpt_freq.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DPT_FREQ (p_acc number)
      return  number is
      l_nn     number;
      l_id    number;
begin
 return 1;
 begin
  select  freq  into l_nn
  from dpt_deposit_clos
  where acc=p_acc
   and idupd=(select max(idupd)
                from dpt_deposit_clos
                where acc=p_acc);
   exception when no_data_found then l_nn:=0;
 end;
 return l_nn;
end dpt_freq;
 
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dpt_freq.sql =========*** End *** =
 PROMPT ===================================================================================== 
 