CREATE OR REPLACE PROCEDURE p_kol_deb(p_dat01 date, p_mode integer, p_deb integer) IS 

/* Версия 7.4  25-10-2017  25-09-2017  18-09-2017  04-08-2017  11-07-2017   26-04-2017  09-03-2017   15-02-2017  24-01-2017   05-10-2016
   Визначення Кількості днів прострочки та фін. стану по дебіторці
   p_deb = 0 - Звичайна дебіторка 
           1 - Нова хоз.дебіторка 
   ------------------------------------
12) 25-10-2017(7.4) - Хоз.дебиторка из архива XOZ_REF ==> XOZ_REF_ARC
11) 17-10-2017(7.3) - При поиске других активов исключила сам счет 
10) 25-09-2017(7.2) - В ND_VAL запись по ND, а не по ACC (в связи с хоз.дебиторкой)
 9) 18-09-2017 - S180 в ND_VAL
 8) 04-08-2017 - Убрала LOGGER
 7) 14-07-2017 - Хоз.дебиторка из модуля
 6) 26-04-2017 - По ЦБ уточнение условия (d.active=1 or d.active = -1 and d.dazs >= p_dat01)
 5) 21-04-2017 - Для крыма для Фин.дебиторки фин.стан максимальный COBUSUPABS-5846 (Крым)
 4) 15-03-2017 - Tckb BV < 250/500 Грн. не считать к-во дней просрочки
 3) 09-03-2017 - Поиск по РНК в др.активах
 2) 15-02-2017 - Вставила дату закрытия в курсор
 1) 24-01-2017 - Добавлен параметр S080 в p_get_nd_val

*/

 cd     cc_deal%rowtype; ov  acc_over%rowtype; w4  rez_w4_bpk%rowtype; bpk  v_bbpk_acc%rowtype; l_s080 specparam.s080%type;

 l_del  number ;  l_tip  number ; l_fin  number ; l_kol     number      ; l_del_kv  number; l_fin23   number; l_xoz_new  number;
 l_nd   integer;  fl_    integer; l_f    integer; l_commit  Integer := 0; l_tip_30  number; l_time    number;                                 

 l_txt  varchar2(1000); l_deb_bez varchar2(1) := '0'; l_s180 varchar2(1); l_tx  varchar2(30);  l_dat31   date  ; l_d1      date  ; 

 TYPE CurTyp IS REF CURSOR;
 c0   CurTyp;

begin
   if p_mode = 0 THEN 
      begin
         select 1 into fl_ from rez_log 
         where fdat = p_dat01 and chgdate > to_date('17-10-2016','dd-mm-yyyy') and kod=351 and  txt like 'Конец Кол-во дней прострочки (дебиторка) 351%' 
           and rownum=1;
         return;
      EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
      END;
   end if;
   l_xoz_new := nvl(F_Get_Params('XOZ_NEW', 0) ,0);
   if p_deb = 1 and l_xoz_new = 0 THEN 
      z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец Кол-во дней прострочки (дебиторка) 351 - l_xoz_new = 0' || l_time || ' мин.');
      RETURN; 
   end if;
   if p_deb = 0 THEN l_tx := ' (фін.+госп.звичайна) ';
   else              l_tx := ' (госп.з модуля) ';
   end if;
   l_d1 := sysdate; 
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало Кол-во дней прострочки (дебиторка) 351' || l_tx);
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');
   --logger.info('XOZ -1 : p_dat01 = ' || p_dat01 || 'l_xoz_new = ' || l_xoz_new  || 'l_dat31 = ' || l_dat31) ;                          
   DECLARE
      TYPE r0Typ IS RECORD 
         ( TIP       accounts.tip%type,
           custtype  customer.custtype%type,
           cus       customer.custtype%type,
           nbs       accounts.nbs%type,
           NLS       accounts.nls%type,
           kv        accounts.kv%type,
           acc       accounts.acc%type,
           rnk       accounts.rnk%type,
           branch    accounts.branch%type,
           bv        rez_cr.bv%type,
           deb       rez_deb.deb%type,
           mdate     accounts.mdate%type,
           nd        accounts.acc%type
          );
   k r0Typ;

   begin 
      begin
         for k in ( select * from   (select  a.*, x.acc1, x.s --count(*)  count_Err
                                     from (select acc, OST_KORR(acc, l_dat31, null,nbs) OST, nls, kv  from accounts where  tip in ('XOZ','W4X')) a,
                                          (select acc acc1, -sum(s0) S ,null nls1, null kv1  from xoz_ref_arc  where mdat = p_dat01 and  ( ref2 is null  OR  datz > l_dat31)  group by acc ) x
                                    where a.acc = x.acc1 (+) and a.OST < 0 and a.ost <> nvl(x.S,0) order by a.acc    )
                   where acc1 is null )
         loop
            UPDATE  ACCOUNTS SET TIP ='ODB'  WHERE ACC = K.ACC ;
         end loop;
      end;
      if  p_deb = 0   THEN
         OPEN c0 FOR
            select 17 tip, decode(c.custtype,3,3,2) custtype, c.custtype cus, a.nbs, a.nls, a.kv, a.acc, a.rnk, a.branch, -ost_korr(a.acc,l_dat31,null,a.nbs) bv, d.deb, a.mdate, a.acc nd
            from   accounts a,customer c, rez_deb d 
            where  a.nbs = d.nbs and d.deb in (1,2) and d.deb is not null and a.nbs is not null and (a.dazs is null or a.dazs >= p_dat01) 
                   and a.acc not in ( select accc from accounts where nbs is null and substr(nls,1,4)='3541' and accc is not null) and a.rnk = c.rnk and  ( a.tip not in ('XOZ','W4X')  or l_xoz_new != 1 )
            union  all 
            select 17 tip,decode(c.custtype,3,3,2) custtype, c.custtype cus, nvl(nbs,substr(nls,1,4)) nbs, a.nls, a.kv, a.acc, a.rnk, a.branch,  -ost_korr(a.acc,l_dat31,null,a.nbs) bv,
                   1 deb, a.mdate, a.acc nd
            from   accounts a, cp_deal cp, customer c
            where  (cp.active=1 or cp.active = -1 and cp.dazs >= p_dat01) and substr(a.nls,1,4)='3541'  and ost_korr(a.acc,l_dat31,null,a.nbs) < 0 and  a.acc in  (cp.accr,cp.acc) and 
                    a.rnk = c.rnk  and a.acc not in ( select accc from accounts where nbs is null  and  substr(nls,1,4)='3541'  and accc is not null) ; 
      else 
         OPEN c0 FOR
            select 21 tip, decode(c.custtype,3,3,2) custtype, c.custtype cus, a.nbs, a.nls, a.kv, a.acc, a.rnk, a.branch,-ost_korr(a.acc,l_dat31,null,a.nbs) bv, 3 deb, 
                   x.fdat mdate,  --nvl(x.mdate,xoz_mdate(a.acc,x.fdat, a.nbs, a.ob22, a.MDATE )) mdate, 
                   x.id nd 
            from   xoz_ref_arc x, accounts a, customer c, rez_deb d 
            where  mdat = p_dat01 and a.nbs = d.nbs and d.deb in (2) and d.deb is not null and x.fdat < p_dat01 and (datz >= p_dat01 or datz is null) and s0<>0 and s<>0 and x.acc=a.acc  
                   and  ( a.tip in ('W4X', 'XOZ')  and  l_xoz_new = 1 ) and a.rnk=c.rnk;
      end if;       
      loop
         FETCH c0 INTO k;
         EXIT WHEN c0%NOTFOUND;
         --logger.info('XOZ 0 : acc = ' || k.acc || 'bv = ' || k.bv ) ;                          
         if k.bv > 0 THEN
            l_tip_30 := null; 
            --logger.info('DEB_351K 1 : acc = ' || k.acc  ) ;
            l_nd := k.nd; l_fin := NULL; cd := NULL; l_tip := 0;
            begin
               select nvl(s180,'0') into l_s180 from specparam where acc = k.acc;
            EXCEPTION  WHEN NO_DATA_FOUND  THEN l_s180 := '0';
            end;
            if l_s180 in ('7','8','9','A','B','C','D','E','F','G','H') THEN

               if k.deb = 1 THEN     --nbs in ('3570','3578','3579') THEN Для всей фин. дебиторки > 3 месяцев
                  -- Кредитный портфель  
                  begin
                     select d.* into cd from cc_deal d, nd_open n 
                     where d.rnk = k.rnk and n.fdat = p_dat01 and n.nd = d.nd and rownum = 1;
                     if    cd.vidd in ( 1, 2, 3) and cd.prod like '21%'                                 THEN l_tip := 1; l_f := 76; --l_idf := 70; l_fp := 47;
                     elsif cd.vidd in ( 1, 2, 3)                                                        THEN l_tip := 2; l_f := 56;
                     elsif cd.vidd in (11,12,13)                                                        THEN l_tip := 1; l_f := 60;
                     elsif cd.vidd in (150,1502,1510,1511,1512,1515,1517,1521,1522,1523,1524,1526,1527) THEN l_tip := 1; l_f := 80;   
                     else                                                                                    l_tip :=99; 
                     end if;
                     l_fin23 := cd.fin23;
                     l_nd    := cd.nd; 
                  EXCEPTION  WHEN NO_DATA_FOUND  THEN 
                     -- Новый процессинг
                     begin 
                        select * into w4 from rez_w4_bpk where rnk = k.rnk and acc<>k.acc and rownum = 1;    l_tip := 1; l_f := 60;
                        if k.cus = 2 Then                                                                    l_tip := 2; l_f := 56; end if;
                        l_fin23 := w4.fin23;
                        l_nd    := w4.nd; 
                     EXCEPTION  WHEN NO_DATA_FOUND  THEN 
                        begin 
                           select d.* into ov from acc_over d , nd_acc n ,accounts a, nd_open o
                           where  n.acc  = a.acc   and n.nd = d.nd and a.rnk  = k.rnk and 
                                  o.fdat = p_dat01 and d.nd = o.nd and a.acc <> k.acc and rownum = 1;        l_tip := 2; l_f := 56;         
                           if    k.cus = 1   THEN                                                            l_tip := 1; l_f := 80; 
                           elsif k.cus = 3   THEN                                                            l_tip := 1; l_f := 60; 
                           end if;
                           l_fin23 := w4.fin23;
                           l_nd    := ov.nd;
                        EXCEPTION  WHEN NO_DATA_FOUND  THEN                                                  l_tip := 0;
                        end;
                     end;
                  end; 
                  if k.cus in (1,3) THEN l_tip_30 := 1;
                  else                   l_tip_30 := 2;
                  end if;
               else                                                                                          l_tip := 0;
               end if;
            
            end if;
            --logger.info('DEBF 17 1 : acc = ' || k.acc || ' k.rnk = '|| k.rnk || ' l_tip = '|| l_tip || ' l_tip_30 = '|| l_tip_30 || ' l_fin = '|| l_fin  || ' k.nd = '|| k.nd ) ;
            if k.custtype = 2 and k.deb = 1 THEN l_del := 50000;
            elsif                 k.deb = 1 THEN l_del := 25000;
            else                                 l_del := 0;
            end if;
   
            if k.kv = 980 THEN l_del_kv := l_del;
            else               l_del_kv := p_ncurval(k.kv,l_del,l_dat31);
            end if;
            --logger.info('DEB_351 1 : acc = ' || k.acc  ) ;
            if k.bv <= l_del_kv and k.deb <> 3 THEN l_kol := 0;
            elsif k.deb = 3                    THEN l_kol := greatest (nvl(p_dat01 - k.mdate,0) , 0);
            else                                    l_kol := f_days_past_due (p_dat01, k.acc, l_del_kv);
            end if;
            --logger.info('DEB_351 2 : acc = ' || k.acc  ) ;
            --l_tip := 0;
            --logger.info('DEB_351 1 : acc = ' || k.acc || ' vidd     = '|| cd.vidd  || ' custtype = '|| k.custtype ) ;
            --logger.info('DEB_351 2 : acc = ' || k.acc || ' l_kol = '|| l_kol ) ;
            --logger.info('XOZ 1 : acc = ' || k.acc || ' k.deb = ' || k.deb || ' l_kol = ' || l_kol  ) ;                          
            if l_tip  = 0 THEN  l_fin := f_rez_kol_fin_pd((case when k.deb = 3 THEN 2 else k.deb end), 1, l_kol);
            else                l_fin := fin_nbu.zn_p_nd('CLS', l_f, p_dat01, l_nd, k.rnk);
               if (l_fin is null or l_fin = 0) and k.cus = 2 THEN 
                   l_txt := 'Дебіторка.';
                   p_error_351( P_dat01, l_nd, user_id,15, k.acc, k.cus, k.kv, k.branch, l_txt, k.rnk, k.nls); 
                   if k.nd <> l_nd THEN l_fin := 10;
                   else                 l_fin := l_fin23;
                   end if;
               end if;
               l_fin := nvl(l_fin,5);
            end if;
            if l_fin is null or l_fin = 0 THEN l_fin := l_fin23;  End if;
            if k.nbs in ('2805','2806') THEN 
               begin
                  select substr(value,1,1) into l_DEB_BEZ from accountsw nt  where nt.acc = k.acc and nt.tag ='DEB_BEZ'; -- 1 Безнадійна дебіторська заборгованість
               EXCEPTION  WHEN NO_DATA_FOUND  THEN l_DEB_BEZ :='0';
               end;
               if l_DEB_BEZ = '1' THEN l_fin := 2; 
               else                    l_fin := 1; 
               end if; 
            end if; 
            if l_tip = 99 THEN l_tip := 2; end if;
            l_tip  := nvl(l_tip_30,l_tip);
            --logger.info('DEBF 17 2 : acc = ' || k.acc || ' k.rnk = '|| k.rnk || ' l_tip = '|| l_tip || ' l_tip_30 = '|| l_tip_30 || ' l_fin = '|| l_fin  || ' k.nd = '|| k.nd ) ;
            if sys_context('bars_context','user_mfo') = '324805' and k.deb = 1 THEN -- COBUSUPABS-5846 (Крым)
               if    l_tip = 1 THEN l_fin :=  5;
               elsif l_tip = 2 THEN l_fin := 10;
               else                 l_fin :=  2;
               end if;
            end if;
            l_s080 := f_get_s080(p_dat01, l_tip, l_fin);
            --logger.info('DEBF 17 5 : acc = ' || k.acc || ' k.rnk = '|| k.rnk || ' l_tip = '|| l_tip || ' k.tip = '|| k.tip || ' l_fin = '|| l_fin  || ' k.nd = '|| k.nd ) ;
            p_get_nd_val(p_dat01, k.nd, k.tip, l_kol, k.rnk, l_tip, l_fin, l_s080, l_s180);  --nd = k.acc в nd_val по дебиторке всегда  acc
            l_commit := l_commit + 1; 
            If l_commit >= 1000 then  commit;  l_commit:= 0 ; end if;
         end if; 
      END loop;
      l_time := round((sysdate - l_d1) * 24 * 60 , 2 ); 
      if p_deb=1 THEN
         z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец Кол-во дней прострочки (дебиторка) 351 - ' || l_time || ' мин.');
      end if;
   end;
--   if p_mode = 0 THEN  p_nbu23_cr(p_dat01); end if;
end;   
/
show err;

grant execute on p_kol_deb to RCC_DEAL;
grant execute on p_kol_deb to start1;
grant execute on p_kol_deb to BARS_ACCESS_DEFROLE;
