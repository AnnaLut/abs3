CREATE OR REPLACE PROCEDURE BARS.p_cck_deb (p_dat01 date) IS
 l_kf char(6); 

begin
   l_kf := sys_context('bars_context','user_mfo');
   bc.home;   
   EXECUTE IMMEDIATE 'TRUNCATE TABLE nbu23_cck_deb';
   insert into nbu23_cck_deb
   select t.* from rez_cr t 
   where fdat = p_dat01 and okpo<>0 and t.OKPO in ( select okpo from ( select rnk,okpo from nbu23_rez n  where fdat = p_dat01 and custtype=2 and tipa=3  and nbs not in ('1200') ) x 
                                                    where x.rnk not in (select rnk from customer where rnk=x.rnk and sed='91')) and
         t. OKPO in (select distinct OKPO from nbu23_rez 
                     where fdat = p_dat01 and NBS in (  select nbs from rez_deb where deb in (1,2) ) ) ;
   bc.go(l_kf);   
   commit;
end;
/
show err;
PROMPT *** Create  grants  p_cck_deb ***
grant EXECUTE                                on p_cck_deb          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                on p_cck_deb          to RCC_DEAL;
grant EXECUTE                                on p_cck_deb          to START1;

