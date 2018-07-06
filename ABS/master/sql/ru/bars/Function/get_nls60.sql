 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/Get_NLS60.sql =========*** Run *** =
 PROMPT ===================================================================================== 

create or replace function Get_NLS60 ( p_kv int, p_nls varchar2) return varchar2  is 
  l_nls6   varchar2 (16) ;
  l_acc    accounts.acc%type;
  l_nd     cc_deal.nd%type;
  l_prod   char(6) ;
  l_branch cc_deal.branch%type;
  l_NBS6   NBS_SS_SD.NBS6%type;
  l_Ob6    char(2) ; 
begin
   begin  select acc into l_acc from accounts where kv = p_kv and nls = p_nls;
          select nd  into l_nd  from nd_acc where acc = l_acc ;
          select substr(prod,1,6), substr(branch,1,15)  into l_prod , l_branch from cc_deal  where nd = l_nd ;
          select nbs6 into l_nbs6 from  nbs_ss_sd where nbs2 = substr(l_prod,1,4) ;
          select decode (p_kv, gl.baseval, sd_n, sd_i) into l_ob6 from cck_ob22 where nbs||ob22= l_prod;

          select nls into l_nls6
          from (  select nls from accounts a6 where nbs = l_nbs6 and ob22 = l_ob6 and dazs is null  order by decode ( l_branch, a6.branch,1, 2) )
          where rownum = 1;
   exception when others then null;
   end ;
   RETURN l_NLS6;

end get_NLS60;
/
show err;

PROMPT *** Create  grants  Get_NLS60 ***
grant EXECUTE                                                                on Get_NLS60        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on Get_NLS60        to START1;
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/Get_NLS60.sql =========*** End *** =
 PROMPT ===================================================================================== 

--------------
