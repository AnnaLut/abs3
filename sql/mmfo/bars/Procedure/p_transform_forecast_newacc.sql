

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_TRANSFORM_FORECAST_NEWACC.sql ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_TRANSFORM_FORECAST_NEWACC ***

  CREATE OR REPLACE PROCEDURE BARS.P_TRANSFORM_FORECAST_NEWACC is
    l_new_nls accounts.nls%type;
    l_new_nbs accounts.nbs%type;
    l_tries   number := 0;
    l_count   number;
    l_trace   varchar2(500):= 'T2017.look_for_notmaped: ';

begin
    for c in (
            select kf, nls, nbs, max(new_nls) max_new_nls
            from
               (select *  from transform_2017_forecast
                                   where (kf, nls) in (select  kf,  nls
                                                         from transform_2017_forecast
                                                        where new_nls is null)
             )
            group by kf, nbs, nls
            order by nbs
         ) loop

         bars_audit.info(l_trace||'подбираем счет для kf='||c.kf||', nls='||c.nls||', макс='||c.max_new_nls);
         select r020_new into l_new_nbs from transfer_2017 where r020_old =  c.nbs and rownum = 1;

         if c.max_new_nls is null then
            l_new_nls :=  vkrzn( substr( c.kf, 1,5), l_new_nbs||'0' || substr( c.nls, 6,9));
         else
            l_new_nls := c.max_new_nls;
         end if;

         bars_audit.info(l_trace||'--> l_new_nls='||l_new_nls);
         l_tries :=0;
         while l_tries < 100 loop
                     l_count := 0 ;
                     select count(*) into l_count from
                     ( select 1  from accounts                   where nls      = l_new_nls   and kf = c.kf
                       union all
                       select 1 from TRANSFORM_2017_FORECAST     where new_nls  = l_new_nls   and kf = c.kf  and  nls <> c.nls
                     );

                     -- если такой счет нашли или в счете или в зарезервированных
                     -- пытаемся еще раз подобрать
                     if l_count = 0 then
                        -- выход, счет подобрали
                        exit;
                     end if;
                     l_tries := l_tries + 1;

                     l_new_nls := vkrzn( substr( c.kf, 1,5), l_new_nbs||'0' || trunc ( dbms_random.value ( 100000000, 999999999 ) )) ;

                     bars_audit.info(l_trace||'random --> l_new_nls='||l_new_nls||', tries='||l_tries);
             end loop;



             if l_tries < 100 then
                update TRANSFORM_2017_FORECAST set new_nbs = l_new_nbs, new_nls = l_new_nls, insert_date = sysdate where kf = c.kf and nls = c.nls;
                bars_audit.info(l_trace||'cчет подобран. kf='||c.kf||', nls='||c.nls||'->'||l_new_nls);
             else
                bars_audit.info(l_trace||'cчет не подобран. kf='||c.kf||', nls='||c.nls);
             end if;
             commit;
end loop;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_TRANSFORM_FORECAST_NEWACC.sql ==
PROMPT ===================================================================================== 
