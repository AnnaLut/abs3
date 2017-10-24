
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_istval.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_ISTVAL (p_nd number,p_acc number,p_sdate date,p_kv number) return number
IS
kv_     accounts.kv%type;
acc_    accounts.acc%type;
istval_ specparam.istval%type;

begin
   kv_ :=p_kv;
   acc_:=p_acc;
   if p_nd<>0 THEN
      begin
         select accs into acc_ from cc_add where nd=p_nd;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         istval_:=0;
      end;
   end if;

   if kv_=980 THEN
      istval_:=1;
   else
      if acc_<>0 and acc_ is not null THEN
         begin
            select nvl(istval,0) into istval_ from specparam
            where acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            istval_:=0;
         end;
      else
         istval_:=0;
      end if;
   end if;
   if (p_sdate < to_date('04-03-2012','dd-mm-yyyy') or p_sdate is null) and istval_=0 THEN
      istval_:=1;
   end if;

   return(istval_);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_istval.sql =========*** End *
 PROMPT ===================================================================================== 
 