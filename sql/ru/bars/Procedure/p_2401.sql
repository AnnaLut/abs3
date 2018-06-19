PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_2401.sql =========*** Run *** ==
PROMPT ===================================================================================== 
PROMPT *** Create  procedure P_2401 ***

  CREATE OR REPLACE PROCEDURE BARS.P_2401 (DAT01_ date ) IS

/* Версия 2.1  05-09-2017  06-03-2017  29-01-2017
   Визначення Портфельного метода + ОСББ
   -------------------------------------
  5) 05-09-2017 - По ОСББ добавлен k050 = 320
  4) 06-03-2017 - Индекс rez_w4_bpk по РНК + убрала счет (2620 ? ? зачем был не понятно)
  3) 15-02-2017 - 2000000.00 для портфельного метода (согласно заявке COBUSUPABS-5466 ( был 5000000 = 50000.00))
  2) 15-02-2017 - Поправила GRANT
  1) 29-01-2017 - Портфельный метод записывается в таблицу RNK_ND_PORT
*/

dat31_  date := Dat_last_work (dat01_ - 1 );  -- последний рабочий день месяца

rnk_    accounts.rnk%type; ACC8_     accounts.acc%type; l_s250 rez_cr.s250%type;

ost_    number; REZ_PORT_ number; l_restr   number; l_acc     number; l_lim     number;

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
   if REZ_PORT_=1 THEN
   for k in (select distinct b.nd,b.rnk,decode(b.tip_kart,42,'W4','BPK') tip, b.grp, nvl(b.restr,0) restr, SP_bpk_50(b.nd, dat01_ ) sp_
             from   rez_w4_bpk b, accounts a
             where  s250=8 and b.acc = a.acc and a.nbs not in ('3550','3551','9129','3570','3578')
             union  all
             select d.nd,d.rnk,'CCK' tip, t.grp,0 restr, SP_50(d.nd, dat01_ ) sp_
             from   cc_deal d, tmp_nbs_2401 t
             where  t.grp not in (4) and substr(d.prod,1,6) = t.nbs||t.ob22
             union  all
             select d.nd,d.rnk,'OSBB' tip,4 grp, 0 restr, 0 sp_
             from   cc_deal d, accounts a, nd_acc n,tmp_nbs_2401 t,CUSTOMER C
             where  t.grp = 4 and d.nd = n.nd and n.acc = a.acc and a.tip = 'SS ' and a.rnk = c.rnk and c.k050 in (855, 320) and
                    substr(d.prod,1,6) = t.nbs||t.ob22 and f_get_nd_val(d.nd, dat01_, 3, a.rnk) < 30 and
                    ost_korr(a.acc, dat31_,null,a.nbs) < 0 and a.nbs||a.ob22 =  t.nbs||t.ob22
             order by rnk
            )
   LOOP
      begin
         if k.tip = 'CCK' THEN
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
         elsif k.tip = 'OSBB' THEN l_restr := 0;
         else
            l_restr := k.restr;
         end if;

         if l_restr = 0 THEN
            begin
               select sum(ost) into ost_
               from (select r.rnk,sum(-p_icurval(a.kv,ost_korr(a.acc,dat31_,null,a.nbs),dat31_)) ost
                     from   rez_w4_bpk r, accounts a where r.acc = a.acc and r.rnk = k.rnk and a.nbs not in ('3578','3579','3570') group  by r.rnk
                     union all
                     select d.rnk,sum(-p_icurval(a.kv,ost_korr(a.acc,dat31_,null,a.nbs),dat31_))
                     from   cc_deal d   , accounts a, nd_acc n
                     where  d.nd=n.nd and n.acc=a.acc and a.tip   in ('SS ','SP ','SN ','SNA','SNO','SL ','SPN','CR9','SDI','SPI')
                            and  (dazs is null or dazs>=dat01_) and a.rnk=k.rnk group by d.rnk
                     union all
                     select rnk,sum(-p_icurval(kv,ost_korr(acc,dat31_,null,nbs),dat31_))
                     from accounts where nbs in ('3578','3579','3570') and (dazs is null or dazs>=dat01_)  and rnk = k.rnk
                     group by rnk) f ; 
               RNK_ := k.rnk;
            EXCEPTION WHEN NO_DATA_FOUND THEN rnk_ := null;
            end;
            if rnk_ is not null THEN
               if k.tip = 'OSBB' THEN l_lim:=  25000000;
               else                   l_lim:= 200000000; --согласно заявке COBUSUPABS-5466 ( был 5000000 = 50000.00)
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
