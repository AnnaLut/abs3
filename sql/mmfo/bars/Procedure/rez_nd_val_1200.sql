CREATE OR REPLACE PROCEDURE REZ_ND_VAL_1200(p_dat01 date, p_mode integer) IS 
/* Версия 1.0 04-09-2017 
   Визначення  фін. класу по коррахунку та похідним фінансовим інструментам
   ------------------------------------
*/
l_s080   specparam.s080%type   ; l_tip_fin  rez_cr.tip_fin%type; l_fin  rez_cr.fin%type;
fl_      integer; l_dat31  date; l_time    number; l_d1   date ; 

begin
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   if p_mode = 0 THEN 
      begin
         select 1 into fl_ from rez_log 
         where fdat = p_dat01 and chgdate > to_date('17-10-2016','dd-mm-yyyy') and kod=351 and  txt like 'Конец параметры 1200%' and rownum=1;
         return;
      EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
      END;
   end if;
   l_d1 := sysdate; 
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало параметры 1200');
   for k in ( select p_dat01 fdat,c.custtype,substr(c.nmk,1,35) nmk, 'NEW/' || acc id, - ost_korr(a.acc,l_dat31,null,a.nbs) bv, 1 fin, 1 kat, 
                     c.OKPO, DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, case when d.tipa in (12, 93) then 1 else 0 end PD_0,
                     d.tipa, a.*, d.tipa_FV  
              from accounts a, customer c, rez_deb d 
              where d.tipa in (12, 30, 92, 93) and ost_korr(a.acc,l_dat31,null,a.nbs) < 0 and a.rnk = c.rnk and a.nbs = d.nbs and (a.dazs is null or  a.dazs>= p_dat01)
            )
   LOOP
      l_tip_fin:= f_pd ( p_dat01, k.rnk, k.acc, k.custtype, k.kv, k.nbs, 1, 1);
      l_s080   := f_get_s080 (p_dat01, l_tip_fin, k.fin);
      p_get_nd_val(p_dat01, k.acc, k.tipa, 0, k.rnk, l_tip_fin, nvl(k.fin,1), l_s080);
   end LOOP;                                                                                             
   commit;
   l_time := round((sysdate - l_d1) * 24 * 60 , 2 ); 
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец параметры 1200- ' || l_time || ' мин.');

end;
/
show err;

grant EXECUTE   on REZ_ND_VAL_1200 to BARS_ACCESS_DEFROLE;
grant EXECUTE   on REZ_ND_VAL_1200 to RCC_DEAL;
grant EXECUTE   on REZ_ND_VAL_1200 to START1;



