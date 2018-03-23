CREATE OR REPLACE PROCEDURE REZ_ND_VAL_1200(p_dat01 date, p_mode integer) IS 
/* Версия 1.0 04-09-2017 
   Визначення  фін. класу по коррахунку та похідним фінансовим інструментам
   ------------------------------------
*/
nv    nd_val%rowtype; l_s080   specparam.s080%type   ; l_tip_fin  rez_cr.tip_fin%type; l_fin  rez_cr.fin%type;
l_pd  number; l_vkr varchar2(3);

fl_  integer; l_dat31  date; l_time    number; l_d1   date ; 

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
   /*
   begin
      for k in (select distinct rnk from REZ_PAR_9200 where fdat=p_dat01 and fin is null)
      LOOP
         l_fin := null;
         l_pd  := null;
         l_VKR := NULL; 
         begin
            select * into nv from nd_val 
            where fdat= p_dat01  and rnk= k.rnk and tipa not in (30,92,93) 
              and fin in (select max(fin) from nd_val where fdat= p_dat01  and rnk = k.rnk and tipa not in (30,92,93) ) and rownum=1;
         EXCEPTION  WHEN NO_DATA_FOUND  THEN 
            if nv.tipa in (15) THEN
               begin
                  select k.fin_351, k.pd, k.vncrr into l_fin, l_pd, l_VKR 
                  from cp_deal c, cp_kod k where c.ref = nv.nd and c.id=k.id;
               EXCEPTION  WHEN NO_DATA_FOUND  THEN NULL;
               end; 
            else
               begin
                  select k.fin_351, k.pd,cck_app.get_nd_txt(k.nd,'VNCRR') into l_fin, l_pd, l_vkr 
                  from cc_deal k where k.nd = nv.nd; 
               EXCEPTION  WHEN NO_DATA_FOUND  THEN NULL;
               end; 
            end if;
         end;
         if l_fin is null THEN
            begin 
               select fin, pd, vkr into l_fin, l_pd, l_vkr from REZ_PAR_9200 
               where fdat = add_months( p_dat01, -1 ) and rnk=k.rnk and rownum=1;
            EXCEPTION  WHEN NO_DATA_FOUND  THEN NULL;
            end;
         end if;        
         if l_fin is not null or l_pd is not null or l_vkr is not null THEN
            update REZ_PAR_9200 set fin = l_fin, pd = l_pd, vkr = l_vkr where fdat = p_dat01 and rnk=k.rnk and fin is null;
         end if;
      end LOOP;
   end;
   */
   l_d1 := sysdate; 
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало параметры 1200');
   for k in ( select p_dat01 fdat,c.custtype,substr(c.nmk,1,35) nmk, 'NEW/' || acc id, - ost_korr(a.acc,l_dat31,null,a.nbs) bv, 
                     decode(d.tipa,12,1,r.fin) fin,1 kat, c.OKPO, DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, 
                     case when d.tipa in (12, 93) then 1 else 0 end PD_0, d.tipa, a.*, d.tipa_FV, r.pd  
              from rez_par_9200 r, accounts a, customer c, rez_deb d 
              where r.nd=a.acc and d.tipa in (12, 30, 92, 93) and ost_korr(a.acc,l_dat31,null,a.nbs) < 0 and a.rnk = c.rnk and a.nbs = d.nbs and (a.dazs is null or  a.dazs>= p_dat01)
            )
   LOOP
      l_tip_fin:= f_pd ( p_dat01, k.rnk, k.acc, k.custtype, k.kv, k.nbs, 1, 1);
      --if k.tipa in (30, 92, 93) THEN
     --    l_fin := f_rnk_maxfin(p_dat01, k.rnk, l_tip_fin, k.acc, 1);
     --    select 
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



