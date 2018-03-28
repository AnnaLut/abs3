PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/p_kol_cck_otc.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  procedure p_kol_cck_otc ***

  CREATE OR REPLACE PROCEDURE BARS.p_kol_cck_otc (p_dat01 date, p_mode integer) IS 

/* Версия 1.0 10-01-2018
   Кількість днів прострочки по договору на дату (кредити)- звітність
   -------------------------------------
*/

 PR_    number ; l_s      NUMBER ; fl_      number ; l_dos  number ; l_cls  integer; l_fin_okpo  NUMBER ;
 KOL_N  integer; l_f      INTEGER; l_fin23  INTEGER; l_fin  INTEGER; l_tipa INTEGER; l_OPEN      integer;
 l_kor  INTEGER; l_di     integer;
 DATP_  date   ; l_dat31  date   ; l_dd date;

 l_TIP  varchar2(50); DATSP_   varchar2(30); DASPN_   varchar2(30); l_txt    varchar2(1000);
 l_s080 specparam.s080%type;  l_sed customer.sed%type;

  TYPE CurTyp IS REF CURSOR;
  c0 CurTyp;

begin
   if p_mode = 0 THEN 
      begin
         select 1 into fl_ from rez_log 
         where fdat = p_dat01 and  txt ='Конец К-во дней кредиты (OTC) ' and rownum=1;
         return;                                                                    
      EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
      END;
   end if;
   delete from kol_nd_dat where  dat = p_dat01 and tipa = 3;
   begin
      select 1 into l_open from nd_open  where fdat = p_dat01 and rownum=1;
   EXCEPTION WHEN NO_DATA_FOUND THEN  p_nd_open(p_dat01); 
   end;
   select to_char ( p_DAT01, 'J' ) - 2447892 into l_di from dual;
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало К-во дней кредиты (ОТС) ');
   if trunc(p_dat01,'MM') = p_dat01   THEN l_kor := 1; 
   elsif  p_dat01 >= trunc(sysdate)   THEN l_kor := 2;
   else                                    l_kor := 0;
   end if;
   for k in (select d.nd, d.vidd, d.OBS23 OBS,d.SDATE sdate,d.rnk, d.WDATE wdate, s250, kat23, k23, fin23, prod, fin_351
             from   cc_deal d, nd_open n
             where d.vidd in (1,2,3,11,12,13)  and  n.fdat = p_dat01     and  d.nd = n.nd 
            )
   LOOP
      --logger.info('REZ_nd_ostc 6 : nd = ' || k.nd || ' k.wdate = '|| k.wdate || ' k.prod='|| k.prod ) ;
      DATP_ := null;  l_sed := '00';
      if k.vidd in (1,2,3) THEN
         begin
            select sed into l_sed from customer where rnk=k.rnk;
         EXCEPTION WHEN NO_DATA_FOUND THEN l_sed := '00';
         end;
      end if;
      if l_sed = '91' THEN k.vidd := 11; end if;      
      kol_n := 0; 
      l_tipa := 3; 
      if k.prod like '21%'    THEN l_tipa := 4; end if;
      if k.vidd in (11,12,13) THEN l_s    := 25000;
      else                         l_s    := 50000;
      end if;
 
      DATSP_:= nvl(cck_app.Get_ND_TXT(K.ND,'DATSP'),'9');
      DASPN_:= nvl(cck_app.Get_ND_TXT(K.ND,'DASPN'),'9');

      if    DATSP_ <>'9' and DASPN_ <>'9'  THEN  pr_:=4;  DATP_ :=least(to_date(DATSP_,'dd/mm/yyyy'),to_date(DASPN_,'dd/mm/yyyy')); 
      ELSIF DATSP_ <>'9'                   THEN  pr_:=2;  DATP_ := to_date(DATSP_,'dd/mm/yyyy'); 
      ELSIF DASPN_ <>'9'                   THEN  pr_:=3;  DATP_ := to_date(DASPN_,'dd/mm/yyyy'); 
      ELSe                                       pr_:=1;  DATP_ := NULL; 
      end if;

      if DATP_ is not null THEn   
         update ND_KOL_otc set dos = nvl(dos,0) + l_s + 1 where rnk= k.rnk and nd = k.nd and fdat = datp_;
         if sql%rowcount=0 then
            insert into ND_kol_otc (rnk, nd, fdat, dos) values (k.rnk, k.nd, datp_, l_s + 1);
         end if;

         if pr_=4 THEN goto M1;  end if;

      end if;
      if (k.wdate+180 <= p_DAT01) and k.nd not in ( 469365501,430235501) then
         update ND_KOL_otc set dos = nvl(dos,0) + l_s + 1 where rnk= k.rnk and nd = k.nd and fdat = k.wdate;
         if sql%rowcount=0 then
            insert into ND_kol_otc (rnk, nd, fdat, dos) values (k.rnk, k.nd, k.wdate, l_s + 1);
         end if;
         GOTO M1; 
      end if;  
      DECLARE
         TYPE r0Typ IS RECORD 
            ( acc       accounts.acc%type,
              NLS       accounts.nls%type,
              kv        accounts.kv%type
             );
      s r0Typ;
      begin
         If  pr_ = 1 THEN 

            OPEN c0 FOR
               select a.acc, a.nls, a.kv  from  nd_acc n, accounts a 
               where n.nd=k.nd and n.acc=a.acc and a.tip in ('SP ','SPN','SK9','SL ') and decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, snp.FOST( a.acc,l_DI,0,7) ) < 0 ;

         elsif pr_ = 2 THEN 
            OPEN c0 FOR
               select a.acc, a.nls, a.kv  from  nd_acc n, accounts a 
               where n.nd=k.nd and n.acc=a.acc and a.tip in ('SP ','SL ') and decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, snp.FOST( a.acc,l_DI,0,7) ) < 0;

         else
            OPEN c0 FOR
               select a.acc, a.nls, a.kv from  nd_acc n, accounts a 
               where n.nd=k.nd and n.acc=a.acc and a.tip in ('SPN','SK9') and decode(l_kor,1,ost_korr(a.acc,l_dat31,null,a.nbs),2, a.ostc, snp.FOST( a.acc,l_DI,0,7) ) < 0;

         end if;                  

         loop
            FETCH c0 INTO s;
            EXIT WHEN c0%NOTFOUND;

            p_kol_otc (k.rnk, p_dat01, k.nd, s.acc);

         end LOOP;
      end;
      << m1 >> NULL;
   end LOOP;

   for k in (select d.nd, d.vidd, d.OBS23 OBS,d.SDATE sdate,d.rnk, d.WDATE wdate, s250, kat23, k23, fin23, prod, fin_351
             from   cc_deal d, nd_open n
             where d.vidd in (1,2,3,11,12,13)            -- ЮЛ+ФЛ
               and  n.fdat = p_dat01     and  d.nd = n.nd -- действующие
            )
   LOOP
      l_sed := '00';
      if k.vidd in (1,2,3) THEN
         begin
            select sed into l_sed from customer where rnk=k.rnk;
         EXCEPTION WHEN NO_DATA_FOUND THEN l_sed := '00';
         end;
      end if;
      if l_sed = '91' THEN k.vidd := 11; end if;      
      l_dos := 0; kol_n := 0; 
      if k.vidd in (11,12,13) THEN l_s := 25000;
      else                         l_s := 50000;
      end if;
      for d in (select * from nd_kol_otc where nd=k.nd order by rnk,nd,fdat)
      LOOP
         l_dos := l_dos + d.dos; 
         if l_dos > l_s THEN
            kol_n := p_dat01 - d.fdat; 
            exit;
         end if;
      end LOOP;
      p_set_kol_nd( p_dat01, k.nd, l_tipa, kol_n );
   end LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец К-во дней кредиты (OTC) ');
end;
/
show err;

PROMPT *** Create  grants  p_kol_cck_otc ***
grant EXECUTE   on  p_kol_cck_otc  to BARS_ACCESS_DEFROLE;
grant EXECUTE   on  p_kol_cck_otc  to RCC_DEAL;
grant EXECUTE   on  p_kol_cck_otc  to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ p_kol_cck_otc.sql =========*** End *** 
PROMPT ===================================================================================== 
