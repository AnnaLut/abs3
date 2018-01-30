CREATE OR REPLACE PROCEDURE p_kol_deb_otc(p_dat01 date, p_mode integer, p_deb integer) IS 

/* Версия 1.1  29-01-2019  10-01-2018
   Кількість днів прострочки по договору на дату (дебіторка)- звітність
   -------------------------------------
 1) 29-01-2018(1.1) - Определение типа XOZ через ф-цию f_tip_xoz (если нет в картотеке заносится в таблицу rez_xoz_tip)
*/

   l_del  number      ;  l_kol     number ; l_del_kv  number ;  l_xoz_new number ; l_time number ;  l_commit  integer :=0;
   l_tx   varchar2(30);  l_dat31   date   ; l_d1      date   ;  FL_       NUMBER ; l_kor  INTEGER; 

 TYPE CurTyp IS REF CURSOR;
 c0   CurTyp;

begin
   l_xoz_new := nvl(F_Get_Params('XOZ_NEW', 0) ,0);
   if p_mode = 0 THEN 
      begin
         select 1 into fl_ from rez_log 
         where fdat = p_dat01  and  txt like 'Конец Кол-во дней прострочки (дебиторка) (OTC)%' 
           and rownum=1;                                                                                  
         return;
      EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
      END;
   end if;

   if p_deb = 1 and l_xoz_new = 0 THEN 
      z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец Кол-во дней прострочки (дебиторка) (OTC) - l_xoz_new = 0' || l_time || ' мин.');
      RETURN; 
   end if;
   if p_deb = 0 THEN l_tx := ' (фін.+госп.звичайна) ';     delete from kol_nd_dat where  dat = p_dat01 and tipa IN (17, 21);
   else              l_tx := ' (госп.з модуля) ';
   end if;
   l_d1 := sysdate; 
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало Кол-во дней прострочки (дебиторка) (OTC)' || l_tx);
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   if trunc(p_dat01,'MM') = p_dat01   THEN l_kor := 1; 
   elsif  p_dat01 >= trunc(sysdate)   THEN l_kor := 2;
   else                                    l_kor := 0;
   end if;
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
      if  p_deb = 0   THEN
         OPEN c0 FOR
            select 17 tip, decode(c.custtype,3,3,2) custtype, c.custtype cus, a.nbs, a.nls, a.kv, a.acc, a.rnk, a.branch, 
                   - decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) bv, d.deb, a.mdate, a.acc nd
            from   accounts a,customer c, rez_deb d 
            where  a.nbs = d.nbs and d.deb in (1,2) and d.deb is not null and a.nbs is not null and (a.dazs is null or a.dazs >= p_dat01) 
                   and a.acc not in ( select accc from accounts where nbs is null and substr(nls,1,4)='3541' and accc is not null) and a.rnk = c.rnk 
                   and  ( decode(l_kor,1, f_tip_xoz(p_dat01, a.acc, a.tip) , a.tip) not in ('XOZ','W4X')  or l_xoz_new != 1 )
            union  all 
            select 17 tip,decode(c.custtype,3,3,2) custtype, c.custtype cus, nvl(nbs,substr(nls,1,4)) nbs, a.nls, a.kv, a.acc, a.rnk, a.branch,  
                   - decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) bv, 1 deb, a.mdate, a.acc nd
            from   accounts a, cp_deal cp, customer c
            where  (cp.active=1 or cp.active = -1 and cp.dazs >= p_dat01) and substr(a.nls,1,4)='3541'  and 
                    decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) < 0 and  a.acc in  (cp.accr,cp.acc) and 
                    a.rnk = c.rnk  and a.acc not in ( select accc from accounts where nbs is null  and  substr(nls,1,4)='3541'  and accc is not null) ; 
      else 
         OPEN c0 FOR
            select 21 tip, decode(c.custtype,3,3,2) custtype, c.custtype cus, a.nbs, a.nls, a.kv, a.acc, a.rnk, a.branch,
                   - decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, fost(a.acc,p_dat01) ) bv, 3 deb, x.fdat mdate, x.id nd 
            from   xoz_ref x, accounts a, customer c, rez_deb d 
            where  a.nbs = d.nbs and d.deb in (2) and d.deb is not null and x.fdat < p_dat01 and (datz >= p_dat01 or datz is null) and s0<>0 
                   and s<>0 and x.acc=a.acc and  ( decode(l_kor,1, f_tip_xoz(p_dat01, a.acc, a.tip) , a.tip) in ('W4X', 'XOZ')  and  l_xoz_new = 1 ) and a.rnk=c.rnk;
      end if;       
      loop
         FETCH c0 INTO k;
         EXIT WHEN c0%NOTFOUND;
         if k.bv > 0 THEN
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
            p_set_kol_nd( p_dat01, k.nd, k.tip, l_kol );  
            l_commit := l_commit + 1; 
            If l_commit >= 1000 then  commit;  l_commit:= 0 ; end if;
         end if; 
      END loop;
      l_time := round((sysdate - l_d1) * 24 * 60 , 2 ); 
      if p_deb=1 THEN
         z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец Кол-во дней прострочки (дебиторка) (OTC)' || l_time || ' мин.');
      end if;
   end;
end;   
/
show err;

grant execute on p_kol_deb_OTC to RCC_DEAL;
grant execute on p_kol_deb_OTC to start1;
grant execute on p_kol_deb_OTC to BARS_ACCESS_DEFROLE;
