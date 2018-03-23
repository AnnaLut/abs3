CREATE OR REPLACE PROCEDURE REZ_9200(p_dat01 date) IS 
/* Версия 1.0 19-12-2017
   Заповнення таблиці параметрів REZ_PAR_9200
   ------------------------------------
*/

l_cn number :=0;  l_dat31 date;

begin
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   begin 
      select count(*) into l_cn from rez_par_9200 where fdat = p_dat01;
   EXCEPTION  WHEN NO_DATA_FOUND  THEN NULL;
   end;                                    
   if l_cn = 0 THEN
      for k in (select a.rnk, a.acc
                from  accounts a, rez_deb d 
                where d.tipa in (12, 30, 92, 93) and ost_korr(a.acc,l_dat31,null,a.nbs) < 0 and a.nbs = d.nbs and (a.dazs is null or  a.dazs>= p_dat01) )
      LOOP
         insert into rez_par_9200 (RNK, ND, FDAT) values (k.rnk,k.acc,P_dat01);
      end LOOP; 
   end if;
end;
/
show err;

grant EXECUTE   on REZ_9200 to BARS_ACCESS_DEFROLE;
grant EXECUTE   on REZ_9200 to RCC_DEAL;
grant EXECUTE   on REZ_9200 to START1;



