

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_KOL_ND ***

  CREATE OR REPLACE PROCEDURE BARS.P_KOL_ND (p_dat01 date, p_nd integer, p_mode integer) IS

/* Версия 7.1   26-03-2018  22-06-2017  20-03-2017  23-01-2017  21-12-2016  07-11-2016
   Кількість днів прострочки по договору + фін.клас
   -------------------------------------
 7) 26-03-2018(7.1) - фін.класс не определен для физ.=5, для юр. =10  (Письмо Коваленко Светланы 23-03-2018)
 6) 22-06-2017 - Если не установлен фин.стан - корректировка на к-во дней просрочки.
 5) 20-03-2017 - Не доходило до перех_дних положень
 4) 23-01-2017 - Добавлен параметр S080 в p_get_nd_val
 3) 21-12-2016 - Фин.стан установленный по ОКПО (FIN_RNK_OKPO)
 2) 07-11-2016 - Ф_н.стан зкоригований на к-ть дн_в прострочки по ЮО _ записується fin_nbu.record_fp_nd('CLSP', l_fin, 56, p_dat01, k.nd, k.rnk);
 1) 05-10-2016 - Добавлен фин.стан
*/

 PR_    number ; l_s  NUMBER ; fl_      number ; l_dos  number ; l_cls  integer; l_fin_okpo  NUMBER ;

 KOL_N  integer; l_f  INTEGER; l_fin23  INTEGER; l_fin  INTEGER; l_tipa INTEGER;

 l_TIP  varchar2(50); DATSP_   varchar2(30); DASPN_   varchar2(30); l_txt    varchar2(1000);

 DATP_  date; l_dat31  date;

 l_s080 specparam.s080%type;  l_sed customer.sed%type;

  TYPE CurTyp IS REF CURSOR;
  c0 CurTyp;

begin
   if p_mode = 0 THEN
      begin
         select 1 into fl_ from rez_log
         where fdat = p_dat01 and chgdate > to_date('17-10-2016','dd-mm-yyyy') and kod=351 and  txt ='Конец К-во дней кредиты 351 ' and rownum=1;
         return;
      EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
      END;
   end if;

   --begin
   --   select 1 into fl_ from rez_log where fdat = p_dat01 and kod=351 and  txt ='Конец К-во дней кредиты 351 ' and rownum=1;
   --   return;
   --EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
   --END;
   delete from ND_kol;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало К-во дней кредиты 351 ');
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   begin  -- Восстановление параметров, которые подвергались корректировке
      for d in (select c.rowid ri from cc_deal c where c.vidd in (1,2,3,11,12,13) and (c.fin_351 is not null or c.pd is not null))
      LOOP
         update cc_deal set fin_351 = null, pd = null where rowid = d.ri;
      end LOOP;
      for k in (  select n.* from nbu23_CCK_ul_kor n, cc_deal c
                  where c.vidd in (1,2,3,11,12,13) and n.zdat = p_dat01 and n.nd = c.nd and (n.fin_351 is not null or n.pd is not null) and
                        n.pdat = (select max(pdat) from nbu23_cck_ul_kor where nd=c.nd and zdat = p_dat01 ))
      LOOP
         update cc_deal set fin_351 = k.fin_351, pd = k.pd where nd = k.nd;
      end LOOP;
      commit;
   end;

   for k in (select d.nd, d.vidd, d.OBS23 OBS,d.SDATE sdate,d.rnk, d.WDATE wdate, d.kprolog, s250, kat23, k23, fin23, d.prod
             from   cc_deal d, nd_open n
             where (d.vidd in (1,2,3,11,12,13)            -- ЮЛ+ФЛ
               and  p_nd in (0, d.ND)                     -- 0 - все счета ЮЛ+ФЛ
               OR   d.vidd in ( 1, 2, 3) and  p_nd = -2   -- ЮЛ
               OR   d.vidd in (11,12,13) and  p_nd = -3)  -- ФЛ
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
      kol_n := 0; l_tipa := 3;
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
         update ND_KOL set dos = nvl(dos,0) + l_s + 1 where rnk= k.rnk and nd = k.nd and fdat = datp_;
         if sql%rowcount=0 then
            insert into ND_kol (rnk, nd, fdat, dos) values (k.rnk, k.nd, datp_, l_s + 1);
         end if;

         if pr_=4 THEN goto M1;  end if;

      end if;
      --logger.info('REZ_nd_351 1 : nd = ' || k.nd || ' datp_ = '|| datp_ ) ;
      if (k.wdate+180 <= p_DAT01) and k.nd not in ( 469365501,430235501)    then
         update ND_KOL set dos = nvl(dos,0) + l_s + 1 where rnk= k.rnk and nd = k.nd and fdat = k.wdate;
         if sql%rowcount=0 then
            insert into ND_kol (rnk, nd, fdat, dos) values (k.rnk, k.nd, k.wdate, l_s + 1);
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
               where n.nd=k.nd and n.acc=a.acc and a.tip in ('SP ','SPN','SK9','SL ') and ost_korr(a.acc,l_dat31,null,a.nbs) < 0 ;

         elsif pr_ = 2 THEN
            OPEN c0 FOR
               select a.acc, a.nls, a.kv  from  nd_acc n, accounts a
               where n.nd=k.nd and n.acc=a.acc and a.tip in ('SP ','SL ') and ost_korr(a.acc,l_dat31,null,a.nbs) < 0;

         else
            OPEN c0 FOR
               select a.acc, a.nls, a.kv from  nd_acc n, accounts a
               where n.nd=k.nd and n.acc=a.acc and a.tip in ('SPN','SK9') and ost_korr(a.acc,l_dat31,null,a.nbs) < 0;

         end if;

         loop
            FETCH c0 INTO s;
            EXIT WHEN c0%NOTFOUND;

            p_kol (k.rnk, p_dat01, k.nd, s.acc);
            --logger.info('REZ_nd_351 2 : nd = ' || k.nd || ' acc = '|| s.acc ) ;

         end LOOP;
      end;
      << m1 >> NULL;
      --p_get_nd_val(p_dat01, k.nd, 3, kol_n);
   end LOOP;

   for k in (select d.nd, d.vidd, d.OBS23 OBS,d.SDATE sdate,d.rnk, d.WDATE wdate, s250, kat23, k23, fin23, prod, fin_351
             from   cc_deal d, nd_open n
             where (d.vidd in (1,2,3,11,12,13)            -- ЮЛ+ФЛ
               and  p_nd in (0, d.ND)                     -- 0 - все счета ЮЛ+ФЛ
               OR   d.vidd in ( 1, 2, 3) and  p_nd = -2   -- ЮЛ
               OR   d.vidd in (11,12,13) and  p_nd = -3)  -- ФЛ
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
      --logger.info('REZ_nd_351 3 : nd = ' || k.nd || ' l_s = '|| l_s ) ;
      for d in (select * from nd_kol where nd=k.nd order by rnk,nd,fdat)
      LOOP
         l_dos := l_dos + d.dos;
         --logger.info('REZ_nd_351 4 : nd = ' || k.nd || ' l_dos = '|| l_dos ) ;
         if l_dos > l_s THEN
            kol_n := p_dat01 - d.fdat;
            --p_get_nd_val(p_dat01, k.nd, 3, kol_n, k.rnk);
            exit;
         end if;
      end LOOP;
      if    k.vidd in ( 1, 2, 3) and k.prod like '21%' THEN  l_f := 76; l_tip := 1;
      elsif k.vidd in ( 1, 2, 3)                       THEN  l_f := 56; l_tip := 2;
      elsif k.vidd in (11,12,13)                       THEN  l_f := 60; l_tip := 1;
      else                                                   l_f := 60; l_tip := 1;
      end if;
      l_fin23 := k.fin23;
      if k.fin_351 is not null THEN
         l_fin := k.fin_351;
      else
         IF k.S250  = 8 THEN
            l_fin := f_fin_pd_grupa (1, kol_n);
         else
            l_cls := nvl(fin_nbu.zn_p_nd('CLS',  l_f, p_dat01, k.nd, k.rnk),0);
            --if l_cls = 0 THEN l_fin := NULL; --end if;
            --else
               --logger.info('FIN 1 : nd = ' || k.nd || ' l_cls = '|| l_cls || ' kol_n = '|| kol_n || ' l_tip = '|| l_tip) ;
               if l_f = 56 THEN
                  --l_cls := fin_nbu.zn_p_nd('CLS',  l_f, p_dat01, k.nd, k.rnk);
                  Case
                     when kol_n between 31 and 60 then  l_fin := greatest(l_cls,  5 );
                     when kol_n between 61 and 90 then  l_fin := greatest(l_cls,  8 );
                     when kol_n >  90             then  l_fin := greatest(l_cls, 10 );
                  else                                  l_fin := l_cls;
                  end case;
                  --fin_nbu.record_fp_nd('CLSP', l_fin, l_f, p_dat01, k.nd, k.rnk); -- ф_н.стан зкоригований на к-ть дн_в прострочки
                  --l_fin := fin_nbu.zn_p_nd('CLSP',  l_f, p_dat01, k.nd, k.rnk);
               else
                  --logger.info('s080 5 : nd = ' || k.nd || ' l_cls = '|| l_cls || ' kol_n = '|| kol_n ) ;
                  --l_cls := fin_nbu.zn_p_nd('CLS',  l_f, p_dat01, k.nd, k.rnk);
                  Case
                     when kol_n between  8 and 30 then  l_fin := greatest(l_cls,  2 );
                     when kol_n between 31 and 60 then  l_fin := greatest(l_cls,  3 );
                     when kol_n between 61 and 90 then  l_fin := greatest(l_cls,  4 );
                     when kol_n >  90             then  l_fin := greatest(l_cls,  5 );
                  else                                  l_fin := l_cls;
                     --logger.info('s080 6 : nd = ' || k.nd || ' l_fin = '|| l_cls || ' kol_n = '|| kol_n ) ;
                  end case;
               end if;
               --if l_fin <>0 THEN
               --   fin_nbu.record_fp_nd('CLSP', l_fin, l_f, p_dat01, k.nd, k.rnk); -- ф_н.стан зкоригований на к-ть дн_в прострочки
               --end if;
               --l_fin := fin_nbu.zn_p_nd('CLS',  l_f, p_dat01, k.nd, k.rnk);
            -- end if;
         end if;
         --if l_fin <>0 THEN
         --   fin_nbu.record_fp_nd('CLSP', l_fin, l_f, p_dat01, k.nd, k.rnk); -- ф_н.стан зкоригований на к-ть дн_в прострочки
         --end if;
      end if;
      --logger.info('REZ_nd_351 5 : nd = ' || k.nd || ' l_fin = '|| l_fin || ' kol_n = '|| kol_n ) ;
      --logger.info('FIN 2 : nd = ' || k.nd || ' l_fin = '|| l_fin || ' k.vidd = '|| k.vidd || ' l_fin23 = '|| l_fin23) ;
      if  l_fin = 0  THEN  l_fin:= null; end if;
      if (l_fin is null or l_fin = 0) and k.vidd in ( 1, 2, 3) THEN
         l_txt := 'Кредити.';
         p_error_351( P_dat01, k.nd, user_id,15, null, null, null, null, l_txt, k.rnk, null);
         l_fin := 10;  -- фін.класс не определен
      --logger.info('FIN 5 : nd = ' || k.nd || ' l_fin = '|| l_fin || ' k.fin23 = '|| k.fin23 ) ;
      end if;
      if l_fin is null and k.vidd in (11, 12, 13) THEN l_fin := 5; -- фін.класс не определен  (Письмо Коваленко Светланы 23-03-2018) nvl(l_fin,f_fin23_fin351(l_fin23,kol_n));
      else if l_fin is null or l_fin=0            THEN l_fin := 5;  end if; --??  nvl(k.fin23,1);
      end if;
      --logger.info('FIN 3 : nd = ' || k.nd || ' l_fin = '|| l_fin || ' k.fin23 = '|| k.fin23 ) ;
      --logger.info('REZ_nd_351 6 : nd = ' || k.nd || ' l_fin = '|| l_fin || ' fin23 = '|| k.fin23) ;
      if l_fin <>0 THEN
         fin_nbu.record_fp_nd('CLSP', l_fin, l_f, p_dat01, k.nd, k.rnk); -- ф_н.стан зкоригований на к-ть дн_в прострочки
      end if;
      l_fin_okpo := f_get_fin_okpo (k.rnk);
      if l_fin_okpo is not null THEN l_fin := least(l_fin,l_fin_okpo); end if;
      --logger.info('FIN 4 : nd = ' || k.nd || ' l_fin = '|| l_fin ) ;
      l_s080 := f_get_s080(p_dat01, l_tip, l_fin);
      p_get_nd_val(p_dat01, k.nd, l_tipa, kol_n, k.rnk, l_tip, nvl(l_fin,1), l_s080);
   end LOOP;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец К-во дней кредиты 351 ');
end;
/
show err;

PROMPT *** Create  grants  P_KOL_ND ***
grant EXECUTE                                                                on P_KOL_ND        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_KOL_ND        to RCC_DEAL;
grant EXECUTE                                                                on P_KOL_ND        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_KOL_ND.sql =========*** End *** 
PROMPT ===================================================================================== 
