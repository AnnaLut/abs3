

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/VIP_CHANGE_STATUS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure VIP_CHANGE_STATUS ***

  CREATE OR REPLACE PROCEDURE BARS.VIP_CHANGE_STATUS 
is
   a number:=0;
   y number:=0;
   n number:=0;
   flr_ customerw.value%type;
   l_cmflag number;
begin
  tuda;
  for k in(
  select v.*, case when trunc(sysdate) between v.datbeg and v.datend then 1 else 0 end fln  from vip_flags v
   where v.mfo=sys_context('bars_context','user_mfo'))
       loop
        begin
         select value flr into flr_ from customerw where rnk=k.rnk and tag='VIP_K';
         if k.fln<>flr_ then
           begin
               update customerw
               set value = k.fln
               where rnk =k.rnk
               and tag = 'VIP_K';

               if k.fln=1 then
               y:=y+1;
               end if;

               if k.fln=0 then
               n:=n+1;
               end if;
           end;
          end if;

         exception when no_data_found

          then
           begin
             insert into customerw
               (rnk, tag, value, isp)
             values
               (k.rnk, 'VIP_K', k.fln, 0);

               if k.fln=1 then
               y:=y+1;
               end if;

               if k.fln=0 then
               n:=n+1;
               end if;
           end;


        end;

        a:=a+1;

       end loop;
  logger.info('Sheduler(VIP клієнти), всього ='||a||', встановлено VIP для '||y||', знято статус VIPa для '||n);


  -- Way4: отправляем запрос в СМ
  for z in ( select f.rnk, f.datbeg, f.datend, nvl(f.cm_flag,0) cm_flag, max(o.nd) nd
               from w4_acc o, accounts a, vip_flags f
              where o.acc_pk = a.acc
                and a.dazs is null
                and a.rnk = f.rnk
                and vip is not null and instr(vip,'1') > 0
                and trunc(sysdate) >= f.datbeg
                and nvl(f.cm_flag,0) < 2
                and f.mfo = sys_context('bars_context','user_mfo')
              group by f.rnk, f.datbeg, f.datend, cm_flag )
  loop
     -- запрос на дату окончания действия признака VIP
     if trunc(sysdate) > z.datend and z.cm_flag < 2 then
        l_cmflag := 2;
     -- запрос на дату начала действия признака VIP
     elsif trunc(sysdate) between z.datbeg and z.datend and z.cm_flag = 0 then
        l_cmflag := 1;
     else
        l_cmflag := 0;
     end if;
     if l_cmflag <> 0 then
        begin
           bars_ow.add_deal_to_cmque(z.nd, 3);
        exception when others then
           l_cmflag := z.cm_flag;
        end;
        update vip_flags
           set cm_flag = l_cmflag,
               cm_try  = case when z.cm_flag <> l_cmflag then 1
                              else nvl(cm_try,0)+1
                         end
         where rnk = z.rnk;
     end if;
  end loop;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/VIP_CHANGE_STATUS.sql =========***
PROMPT ===================================================================================== 
