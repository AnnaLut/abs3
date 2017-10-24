

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_2401_OSBB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_2401_OSBB ***

  CREATE OR REPLACE PROCEDURE BARS.P_2401_OSBB (DAT01_ date ) IS

/* Версия 2.0 06-01-2017  20-12-2016

  2) 06-01-2017 LUDA  Уточнение ОСББ CUSTOMER.K050 = 855
  1) 20-12-2016 LUDA  Портфельный метод по ОСББ (Просрочка <30 дней, общая сумма задолженности <250 000.00 Грн
*/

dat31_    date := Dat_last_work (dat01_ -1 );  -- последний рабочий день месяца
rnk_      accounts.rnk%type;
ACC8_     accounts.acc%type;
ost_      number;
REZ_PORT_ number;
l_restr   number;
l_acc     number;

begin
logger.info('REZ_2401 1 : НАЧАЛО = ' ) ;
   z23.to_log_rez (user_id , 1 , dat01_ ,'Начало p_2401_OSBB');
   delete from rnk_nd_port;
--   update w4_acc  set s250=null, grp=null where s250 is not null;
--   update bpk_acc set s250=null, grp=null where s250 is not null;
--   update cc_deal set s250=null, grp=null where s250 is not null;
--   commit;
   REZ_PORT_ := nvl(F_Get_Params('REZ_PORTFEL', 0) ,0);
   if REZ_PORT_=1 THEN
      for k in (select 'CCK',a.nbs,a.ob22,d.rnk,d.nd,a.nls,a.kv,t.grp
                from   cc_deal d, accounts a, nd_acc n,tmp_nbs_2401 t,CUSTOMER C
                where  t.grp = 4 and d.nd = n.nd and n.acc = a.acc and a.tip = 'SS ' and a.rnk = c.rnk and c.k050=855 and
                       substr(d.prod,1,6) = t.nbs||t.ob22 and f_get_nd_val(d.nd, dat01_, 3, a.rnk) < 30 and
                       ost_korr(a.acc, dat31_,null,a.nbs) < 0 and a.nbs||a.ob22 =  t.nbs||t.ob22
                order by rnk
               )
      LOOP
         begin
            begin
               select rnk,sum(ost) into rnk_,ost_
               from (select a.rnk,sum(-p_icurval(a.kv,ost_korr(a.acc,dat31_,null,a.nbs),dat31_)) ost
                     from  (select acc_2207 ACC,nd from bpk_acc where acc_2207 is not null union all
                            select acc_2209    ,nd from bpk_acc where acc_2209 is not null union all
                            select acc_2208    ,nd from bpk_acc where acc_2208 is not null union all
                            select ACC_OVR     ,nd from bpk_acc where acc_OVR  is not null union all
                            select ACC_9129    ,nd from bpk_acc where acc_9129 is not null) b,accounts a
                     where  b.acc=a.acc  and ost_korr(a.acc,dat31_,null,a.nbs)<0
                     group  by a.rnk union all
                     select a.rnk,sum(-p_icurval(a.kv,ost_korr(a.acc,dat31_,null,a.nbs),dat31_))
                     from  (select acc_2207 ACC,nd from W4_acc where acc_2207 is not null union all
                            select acc_2209    ,nd from W4_acc where acc_2209 is not null union all
                            select acc_2208    ,nd from W4_acc where acc_2208 is not null union all
                            select ACC_OVR     ,nd from W4_acc where acc_OVR  is not null union all
                            select ACC_9129    ,nd from W4_acc where acc_9129 is not null) b,accounts a
                     where  b.acc=a.acc and ost_korr(a.acc,dat31_,null,a.nbs)<0
                     group  by a.rnk union all
                     select d.rnk,sum(-p_icurval(a.kv,ost_korr(a.acc,dat31_,null,a.nbs),dat31_))
                     from   cc_deal d, accounts a, nd_acc n
                     where  d.nd=n.nd and n.acc=a.acc and a.tip   in ('SS ','SP ','SN ','SNO','SL ','SPN','CR9','SDI','SPI')
                            and  (dazs is null or dazs>=dat01_)
                     group by d.rnk  union all
                     select rnk,sum(-p_icurval(kv,ost_korr(acc,dat31_,null,nbs),dat31_))
                     from accounts where nbs in ('2620','3578','3579')
                                         and (dazs is null or dazs>=dat01_)
                                         and ost_korr(acc,dat31_,null,nbs)<0
                     group by rnk) f
               where rnk=k.rnk group by rnk; --f.ost<5000000
            EXCEPTION WHEN NO_DATA_FOUND THEN rnk_ := null;
            end;
            if rnk_ is not null THEN
               if ost_ <= 25000000 and ost_>0 THEN
                  insert into rnk_nd_port (rnk,nd,s250) values (k.rnk,k.nd,8);
               end if;
            end if;
         end;
      END LOOP;
      z23.to_log_rez (user_id , 1 , dat01_ ,'Окончание p_2401_OSBB');
   else
      z23.to_log_rez (user_id , 1 , dat01_ ,'Окончание 2401_OSBB - не портфель');
   end if;
end;
/
show err;

PROMPT *** Create  grants  P_2401_OSBB ***
grant EXECUTE                                                                on P_2401_OSBB     to RCC_DEAL;
grant EXECUTE                                                                on P_2401_OSBB     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_2401_OSBB.sql =========*** End *
PROMPT ===================================================================================== 
