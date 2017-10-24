
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_31.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_31 (p_dat01 date) RETURN number is

L_ost    number;
l_dat31  date  ;

begin
   l_dat31:= Dat_last_work ( p_dat01 - 1);
   begin
      select sum( -ost_korr( acc,l_dat31,null,nbs )) INTO l_ost  from accounts
      where substr(nbs,1,3) in ('304','314') and ost_korr(acc,l_dat31,null,nbs)   < 0 ;
   EXCEPTION  WHEN NO_DATA_FOUND   THEN L_ost := 0;
   end;
   return l_ost;
end;
/
 show err;
 
PROMPT *** Create  grants  F_31 ***
grant EXECUTE                                                                on F_31            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_31            to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_31.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 