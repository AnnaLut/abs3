CREATE OR REPLACE PROCEDURE p_nd_open (p_dat01 date) IS 

/* Версия 2.7  06-05-2019  06-02-2019  04-01-2018   03-01-2017  16-11-2017  17-10-2017  29-09-2017  12-06-2017  30-09-2016
   Действующий ли договор (Кредиты ЮЛ и ФЛ) - vidd in (1,2,3,11,12,13,110) 
   -------------------------------------
8) 06-05-2019(2.7) - По кредитам не рассматривать не авторизованные договора (SOS<>0) 
7) 06-02-2019(2.6) - определение закрытого договора по ОВЕРАМ по закрытию счета 8999 (OVN)
6) 04-01-2018(2.5) - Новая версия (COBUMMFO-6116, COBUSUPABS-5487) -
5) 03-01-2018(2.4) - тормозился расчет 
4) 12-12-2017      - Убрала  p_BLOCK_351(p_dat01) - Для резерва она вызывается в процедуре CR;
                     Для 01- числа ost_korr, для будущей дати - OSTC, для др. - fost
3) 16-11-2017(2.3) - через REZ_DEB 
2) 17-10-2017(2.2) - Добавка из nd_acc по типу a.tip = 'SPN' (было 2069)
1) 12-06-2017 -    ОВЕР из CC_DEAL по условию VIDD = 110

*/

 l_kor integer := 0; l_OPEN    integer;  l_dat31 date;

begin
   -- p_BLOCK_351(p_dat01);
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало Определение закрытых договоров (кредиты) 351 ');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   if trunc(p_dat01,'MM') = p_dat01   THEN l_kor := 1; 
   elsif  p_dat01 >= trunc(sysdate)   THEN l_kor := 2;
   else                                    l_kor := 0;
   end if;
   delete nd_open where fdat = p_dat01;
   for k in (select d.nd from  cc_deal d  where d.vidd in (1,2,3,11,12,13) AND SOS<>0)
   LOOP
      -- Действующий ли договор
      begin 
         SELECT 1 into l_OPEN  FROM   ND_ACC N, ACCOUNTS A 
         WHERE  N.ND = k.ND  AND N.ACC = A.ACC AND A.TIP='LIM' and  (DAZS is NULL or DAZS >= p_DAT01);
         if k.nd <>430235501 THEN  
            insert into nd_open (fdat, nd) values (p_dat01, k.nd);
         end if;

      EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
      END;
   end LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Определение закрытых договоров (МБДК+Коррсчета) 351 ');

   for k in (SELECT d.nd
             FROM (select * from accounts where  nbs >'1500' and nbs < '1600') a, 
                  (select * from cc_deal  where (vidd> 1500  and vidd<  1600 ) and sdate< p_dat01 and vidd<>1502 and  
                                                (sos>9 and sos< 15 or wdate >= l_dat31 )) d, cc_add ad,customer c
             WHERE a.acc = ad.accs  and d.nd = ad.nd and a.rnk=c.rnk  and ad.adds = 0  and  decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) < 0  and 
                   d.nd=(select max(n.nd) from nd_acc n,cc_deal d1  where n.acc=a.acc and n.nd=d1.nd and (d1.vidd> 1500  and d1.vidd<  1600 ) 
                   and d1.vidd<>1502 and d1.sdate< p_dat01 and  (sos>9 and sos< 15 or d1.wdate >= l_dat31 ) )
             union all                   
             select d.nd from  cc_deal d,customer c where vidd = 150 and d.rnk = c.rnk               
            )
   LOOP
      l_open := 0;
      for s in ( select a.acc from  nd_acc n, accounts a where n.nd=k.nd and n.acc=a.acc and a.nbs like '15%' and decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) <0)
      LOOP
         l_open := 1;
      end LOOP; 
      if l_open = 1 THEN 
         insert into nd_open (fdat, nd) values (p_dat01, k.nd);  
      end if;
   end LOOP;

   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало Определение закрытых договоров (ОВЕР) 351 ');
   if f_MMFO THEN
      for k in ( SELECT nd FROM  cc_deal  where vidd = 110 )
      LOOP
         l_open := 0;
         for s in ( select a.acc from  nd_acc n, accounts a where n.nd=k.nd and n.acc=a.acc and  decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) <0 )
         LOOP
            begin 
               SELECT 1 into l_OPEN  FROM   ND_ACC N, ACCOUNTS A, cc_deal d 
               WHERE  d.nd = k.nd  and d.ndi= n.nd and N.ACC = A.ACC AND A.TIP='OVN' and  (DAZS is NULL or DAZS >= p_DAT01);
            EXCEPTION WHEN NO_DATA_FOUND THEN  l_open := 0;
            END;
         end LOOP;
         if l_open = 1 THEN
            insert into nd_open (fdat, nd) values (p_dat01, k.nd);
         end if;
      end LOOP;
   else 
      for k in (select * from acc_over)
      LOOP
      l_open := 0;
         for s in (select s
                   from (select - decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) S from accounts a, customer c where acc= k.acco and a.rnk=c.rnk
                         union all
                         select - decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) S from accounts a, customer c 
                         where acc = (select acra from int_accn where id=0 and acc=k.acco) and nbs not like '8%' and a.rnk=c.rnk
                         union all
                         select - decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) S from accounts  a, customer c  
                         where acc   in (select acc from nd_acc   where nd    = k.nd) 
                           and a.NBS IN (select nbs from rez_deb  where (grupa = 4 and ( d_close is null or d_close > p_dat01)) or a.tip in ('SPN') )
                           and acc not in (select a.acc from accounts a where acc = (select acra from int_accn where id=0 and acc=k.acco)) 
                           and nbs not like '8%' and a.rnk=c.rnk and a.rnk=c.rnk
                         union all
                         select - decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) S
                         from accounts  a, customer c  where acc= k.acc_9129 and a.rnk=c.rnk) o
                   where s > 0 
                  )
         LOOP
            l_open := 1;
         end LOOP; 
         if l_open = 1 THEN 
            begin
               insert into nd_open (fdat, nd) values (p_dat01, k.nd);  
            exception when others then
               if SQLCODE = -00001 then NULL;
               else  raise;
               end if;
           end;
      end if;
      end LOOP;
   end if;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'КОНЕЦ Определение закрытых договоров 351 ');
end;

/

show err;

grant execute on p_nd_open to BARS_ACCESS_DEFROLE;
grant execute on p_nd_open to RCC_DEAL;
grant execute on p_nd_open to start1;

