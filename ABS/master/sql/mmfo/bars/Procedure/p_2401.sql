PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_2401.sql =========*** Run *** ==
PROMPT ===================================================================================== 
PROMPT *** Create  procedure P_2401 ***

  CREATE OR REPLACE PROCEDURE BARS.P_2401 (DAT01_ date ) IS

/* Версия 2.9  11-10-2017 05-10-2017  02-10-2017  27-09-2017  11-09-2017 05-09-2017  06-03-2017  29-01-2017
   Визначення Портфельного метода + ОСББ
   -------------------------------------
 13) 11-10-2017(2.9) - По Крыму нет портфельного метода
 12) 11-10-2017(2.8) - ('3578','3579','3570') через таблицу REZ_DEB
 11) 11-10-2017(2.7) - Деб.>3 мес. не вклюсать в группу +  поиск в БПК исключить сам счет деб.
 10) 05-10-2017(2.6) - SP_30_OSBB вынесла из курсора 
  9) 03-10-2017(2.5) - cc_deal убрала из выборки по  RNK (тормозило)
  8) 02-10-2017(2.4) - Commit 1000 записей 
  7) 27-09-2017(2.3) - SP_bpk_50(b.nd, dat01_ ) sp_  COBUSUPABS-5466 - не рассматривается просрочка и ресруктуризация 
  6) 12-09-2017 - Для ОСББ определение просрочки SP_30_OSBB(d.nd, dat01_ ) >30 дней
  5) 05-09-2017 - По ОСББ добавлен k050 = 320
  4) 06-03-2017 - Индекс rez_w4_bpk по РНК + убрала счет (2620 ? ? зачем был не понятно)
  3) 15-02-2017 - 2000000.00 для портфельного метода (согласно заявке COBUSUPABS-5466 ( был 5000000 = 50000.00))
  2) 15-02-2017 - Поправила GRANT
  1) 29-01-2017 - Портфельный метод записывается в таблицу RNK_ND_PORT
*/

dat31_  date := Dat_last_work (dat01_ - 1 );  -- последний рабочий день месяца

rnk_    accounts.rnk%type ; ACC8_     accounts.acc%type  ; l_s250 rez_cr.s250%type; l_custtype customer.custtype%type; l_kv accounts.kv%type;
l_ost   accounts.ostc%type; l_s180    specparam.s080%type;

ost_       number  ; REZ_PORT_ number; l_restr   number; l_acc     number; l_lim     number; l_del  number; l_del_kv  number; l_kol  number;
l_commit   Integer := 0;

begin
   p_BLOCK_351(dat01_);
   z23.to_log_rez (user_id , 1 , dat01_ ,'Начало p_2401 + ОСББ');
   --update w4_acc  set s250=null, grp=null where s250 is not null;
   --update bpk_acc set s250=null, grp=null where s250 is not null;
   --update cc_deal set s250=null, grp=null where s250 is not null;
   --commit;
   REZ_PORT_ := nvl(F_Get_Params('REZ_PORTFEL', 0) ,0);
   z23.to_log_rez (user_id , 1 , dat01_ ,'start - delete from rnk_nd_port;');
   delete from rnk_nd_port;
   z23.to_log_rez (user_id , 1 , dat01_ ,'end   - delete from rnk_nd_port;');
   if sys_context('bars_context','user_mfo') = '324805' THEN 
      z23.to_log_rez (user_id , 1 , dat01_ ,'Окончание p_2401 + ОСББ (КРИМ - нет Группы)');
      return;
   end if;
   if REZ_PORT_=1 THEN
   for k in (select distinct b.nd,b.rnk,decode(b.tip_kart,42,'W4','BPK') tip, b.grp, 0 restr, 
                    0 sp_  --SP_bpk_50(b.nd, dat01_ ) sp_  COBUSUPABS-5466 - не рассматривается просрочка и ресруктуризация
             from   rez_w4_bpk b, accounts a
             where  s250=8 and b.acc = a.acc and a.nbs not in ('3550','3551','9129','3570','3578')
             union  all
             select d.nd,d.rnk,'CCK' tip, t.grp,0 restr, 0 sp_  -- SP_50(d.nd, dat01_ ) sp_  COBUSUPABS-5466 - не рассматривается просрочка и ресруктуризация
             from   cc_deal d, tmp_nbs_2401 t
             where  t.grp not in (4) and substr(d.prod,1,6) = t.nbs||t.ob22
             union  all
             select d.nd,d.rnk,'OSBB' tip,4 grp, 0 restr, 0 sp_
             from   cc_deal d, nd_open o, tmp_nbs_2401 t, CUSTOMER C
             where  d.nd = o.nd and o.fdat = dat01_ and substr(d.prod,1,6) = t.nbs||t.ob22 and t.grp = 4 and d.rnk = c.rnk and c.k050 in ('855', '320')
             union  all
             select a.acc nd,a.rnk,'DEB' tip,6 grp, 0 restr, 0 sp_ from accounts a, rez_deb r 
             where a.nbs=r.nbs and r.deb = 1 and a.nbs is not null and (a.dazs is null or a.dazs >= dat01_)
             and a.acc not in ( select accc from accounts where nbs is null and substr(nls,1,4)='3541' and accc is not null )
             and ost_korr(a.acc,dat31_,null,a.nbs) <0 
             order by rnk
            )
   LOOP
      begin
         if k.tip = 'CCK' THEN  l_restr := 0;
/*          COBUSUPABS-5466 - не рассматривается просрочка и ресруктуризация
            begin
               SELECT A.ACC INTO ACC8_  FROM ND_ACC N, ACCOUNTS A,specparam s
               WHERE  a.acc = s.acc(+) and ND=k.nd AND N.ACC=A.ACC AND A.TIP='LIM'
                      and rownum=1 and (a.dazs is null or a.dazs>=dat01_);
            EXCEPTION WHEN NO_DATA_FOUND THEN ACC8_ := null;
            end;
            if ACC8_ is not null THEN
               begin
                  select nvl(cck_app.Get_ND_TXT(k.nd,'REZ_P'),0) +
                         nvl(cck_app.Get_ND_TXT(k.nd,'REZ_R'),0) +
                         nvl(cck_app.Get_ND_TXT(k.nd,'REZ_Z'),0) into l_restr from dual;
               EXCEPTION WHEN NO_DATA_FOUND THEN l_restr := 0;
               end;
            else
               l_restr := 1;
            end if;
         --elsif k.tip in ('DEB') and f_days_past_due (dat01_, k.nd, 0) >= 90 THEN l_restr := 1;
*/
         elsif k.tip in ('OSBB')               THEN 
               if SP_30_OSBB(k.nd, dat01_ ) = 0 THEN  l_restr := 0;
               else                                   l_restr := 1;
               end if;
         elsif k.tip in ('DEB')                THEN
            begin
               select nvl(s180,'0') into l_s180 from specparam where acc = k.nd;
            EXCEPTION  WHEN NO_DATA_FOUND  THEN l_s180 := '0';
            end;
            if l_s180 in ('7','8','9','A','B','C','D','E','F','G','H') THEN l_restr := 1;
            else
               l_custtype := f_rnk_custtype(k.rnk);
               begin
                  SELECT kv, - ost_korr(a.acc,dat31_,null,a.nbs) INTO l_kv, l_ost  FROM ACCOUNTS A  WHERE  a.acc = k.nd;
               EXCEPTION WHEN NO_DATA_FOUND THEN l_kv  := null;
               end;
   
               if l_custtype = 2  THEN l_del := 50000;
               else                    l_del := 25000;
               end if;
      
               if l_kv = 980 THEN l_del_kv := l_del;
               else               l_del_kv := p_ncurval(l_kv,l_del,dat31_);
               end if;
               --logger.info('DEB_351 1 : acc = ' || k.nd || ' l_ost = ' || l_ost || ' l_del_kv = ' || l_del_kv ) ;
               if l_ost <= l_del_kv THEN l_kol := 0;
               else                      l_kol := f_days_past_due (dat01_, k.nd, l_del_kv);
               end if;
               --logger.info('DEB_351 2 : acc = ' || k.nd || ' l_kol = ' || l_kol  ) ;
               if l_kol >= 90 THEN l_restr := 1;  else l_restr := 0; end if;
            end if; 
         else
            l_restr := k.restr;
         end if;

         if l_restr = 0 THEN
            begin
               select rnk,sum(ost) into rnk_,ost_
               from (select r.rnk,sum(-p_icurval(a.kv,ost_korr(a.acc,dat31_,null,a.nbs),dat31_)) ost
                     from   rez_w4_bpk r, accounts a where r.acc = a.acc and r.rnk = k.rnk and a.nbs not in ('3578','3579','3570') group  by r.rnk
                     union all
                     select a.rnk,sum(-p_icurval(a.kv,ost_korr(a.acc,dat31_,null,a.nbs),dat31_))
                     from   accounts a, nd_acc n
                     where  n.acc=a.acc and a.tip   in ('SS ','SP ','SN ','SNA','SNO','SL ','SPN','CR9','SDI','SPI')
                            and  (dazs is null or dazs>=dat01_) and a.rnk=k.rnk group by a.rnk
                     union all
                     select rnk,sum(-p_icurval(kv,ost_korr(acc,dat31_,null,nbs),dat31_))
                     from accounts where nbs in (select nbs from rez_deb where grupa = 1 and deb=1 and ( d_close is null or d_close > dat01_ ) ) 
                                         and (dazs is null or dazs>=dat01_)  and rnk = k.rnk  --('3578','3579','3570')
                     group by rnk) f
               where  rnk=k.rnk group by rnk; --f.ost<5000000
            EXCEPTION WHEN NO_DATA_FOUND THEN rnk_ := null;
            end;
            if rnk_ is not null THEN
               if    k.tip = 'OSBB' THEN l_lim:=  25000000; --согласно заявке COBUSUPABS-5466
               elsif k.tip = 'DEB'  THEN l_lim:=   2000000; --согласно заявке COBUSUPABS-6377
               else                      l_lim:= 200000000; --согласно заявке COBUSUPABS-5466 ( был 5000000 = 50000.00)
               end if;
               if ost_ <= l_lim and ost_>0 THEN
                  if k.sp_ <> 5 or k.sp_ is null THEN
                     begin
                        insert into rnk_nd_port ( tip,rnk,nd,s250,grp ) values (k.tip, k.rnk, k.nd, 8,k.grp );
                     exception when others then
                     --ORA-00001: unique constraint (BARS.PK_NBU23REZ_ID) violated
                        if SQLCODE = -00001 then NULL;
                        else raise;
                        end if;
                     end;
                     l_commit := l_commit + 1; 
                     If l_commit >= 1000 then  commit;  l_commit:= 0 ; end if;

                     --if k.tip = 'BPK' THEN
                     --   update bpk_acc set s250='8', grp=k.grp where nd = k.nd;
                     --elsif k.tip = 'W4 ' THEN
                     --   update w4_acc  set s250='8', grp=k.grp where nd = k.nd;
                     --else
                     --   update cc_deal set s250='8', grp=k.grp where nd = k.nd;
                     --end if;
                     --commit;
                  end if;
               end if;
            end if;
         end if;
      end;
   END LOOP;
   z23.to_log_rez (user_id , 1 , dat01_ ,'Окончание p_2401 + VKR + ОСББ');
   begin
      for k in (select * from rez_w4_bpk where vkr is null and s250 = 8)
      LOOP
         FIN_ZP.SET_ND_VNCRR(k.nd, rnk_, 'ААА');
      end LOOP;
   end;

   z23.to_log_rez (user_id , 1 , dat01_ ,'Окончание p_2401 + ОСББ');
   else
      z23.to_log_rez (user_id , 1 , dat01_ ,'Окончание 2401 - не портфель');
   end if;
end;
/
show err;

PROMPT *** Create  grants  P_2401 ***
grant EXECUTE                                                                on P_2401          to BARSUPL;
grant EXECUTE                                                                on P_2401          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_2401          to RCC_DEAL;
grant EXECUTE                                                                on P_2401          to START1;
grant EXECUTE                                                                on P_2401          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_2401.sql =========*** End *** ==
PROMPT ===================================================================================== 
