

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_TRANSFORM_FORECAST.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_TRANSFORM_FORECAST ***

  CREATE OR REPLACE PROCEDURE BARS.P_TRANSFORM_FORECAST (p_kf varchar2) is
   l_count     number:= 0;
   l_tries     number:= 0;
   l_new_nls accounts.nls%type;
   l_nbs       varchar2(100) := 'xxxx';
   l_acc_cnt   number :=0;
   l_trace     varchar2(100) := 'T2017.p_transform_forecast: ';
begin
   bars_audit.info(l_trace||'старт процедуры для kf='||p_kf);
   for c in (select a.kf, a.kv, a.acc, a.nbs, a.nls, a.ob22, t.r020_new new_nbs, t.ob_new new_ob22,
                     vkrzn( substr( a.kf, 1,5), r020_new||'0' || substr( a.nls, 6,9)) new_nls_tail
               from accounts a,  transfer_2017 t
              where a.dazs is null
                and a.nbs = t.r020_old
                and a.ob22 = t.ob_old
                and t.r020_old <> t.r020_new
                and a.kf = p_kf
                order by a.nbs
                )
   loop
               --bars_audit.info(l_trace||'обработка счета kf='||c.kf||', acc='||c.acc||', nls='||c.nls||' -> '||c.new_nls_tail);
               l_new_nls := c.new_nls_tail;
               l_tries := 0;

               while l_tries < 100 loop
                     l_count := 0 ;
                     select count(*) into l_count from
                     ( select 1  from accounts              where nls      = l_new_nls   and kf = c.kf
                       union all
                       select 1 from TRANSFORM_2017_FORECAST     where new_nls  = l_new_nls   and kf = c.kf
                     );

                     -- если такой счет нашли или в счете или в зарезервированных
                     -- пытаемся еще раз подобрать
                     if l_count = 0 then
                        -- выход, счет не нашли
                        --bars_audit.info(l_trace||'не нашли счет - выходим');
                        exit;
                     end if;
                     l_tries := l_tries + 1;

                     l_new_nls := vkrzn( substr( c.kf, 1,5), c.new_nbs||'0' || trunc ( dbms_random.value ( 100000000, 999999999 ) )) ;

             end loop;

             --bars_audit.info(l_trace||'нашли счет ='||l_new_nls||' попытка ='||l_tries);

             if l_tries < 100 then
		 insert into TRANSFORM_2017_FORECAST  values (c.kf, c.kv, c.acc, c.nbs, c.nls, c.ob22, c.new_nbs, c.new_ob22, l_new_nls, sysdate, null );
                l_acc_cnt := l_acc_cnt + 1;
             else
                bars_audit.info(l_trace||'cчет не подобран. kf='||c.kf||', acc='||c.acc||', nls='||c.nls);
             end if;

             if l_nbs <> c.nbs and l_nbs <> 'xxxx'  then
                commit;  -- коммит по балансовому счету
                bars_audit.info(l_trace||'выполнено по балансовому  kf='||c.kf||', nbs='||c.nbs||', всего счетов='||l_acc_cnt);
                l_acc_cnt := 0;
             end if;
             l_nbs := c.nbs;
   end loop;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_TRANSFORM_FORECAST.sql =========
PROMPT ===================================================================================== 
