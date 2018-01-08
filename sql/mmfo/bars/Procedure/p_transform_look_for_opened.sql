create or replace procedure p_transform_look_for_opened is
   l_trace   varchar2(50) := 'T2017.look_for_opened: ';
   l_new_nls varchar2(14);
   l_tries   number;
   l_count   number;
begin
    -- проверка на то, что спрогнозированный счет еще не открыли
    for c in (select kf from mv_kf) loop
        for k in (  select unique t.nls, t.new_nls, t.new_nbs
                      from bars.accounts a, bars.transform_2017_forecast t
                     where a.kf = c.kf 
                       and a.kf = t.kf 
                       and t.new_nls = a.nls
                 ) loop
                 bars_audit.info(l_trace||'спрогнозированный счет '||k.new_nls||' дл€ счета '||k.nls||' уже открыт в јЅ—');
                                  
                 l_new_nls := vkrzn( substr( c.kf, 1,5), k.new_nbs||'0' || trunc ( dbms_random.value ( 100000000, 999999999 ) )) ;
                 
                 bars_audit.info(l_trace||'новый счет '||l_new_nls);
                 
                 l_tries := 0;
                 
                 while l_tries < 100 loop                     
                     l_count := 0 ;
                     select count(*) into l_count from 
                     ( select 1  from accounts              where nls      = l_new_nls   and kf = c.kf
                       union all 
                       select 1 from TRANSFORM_2017_FORECAST     where new_nls  = l_new_nls   and kf = c.kf and nls <> k.nls
                     );
                    
                     -- если такой счет нашли или в счете или в зарезервированных
                     -- пытаемс€ еще раз подобрать
                     if l_count = 0 then              
                        -- выход, счет подобрали 
                        exit;   
                     end if;
                     l_tries := l_tries + 1;
                     l_new_nls := vkrzn( substr( c.kf, 1,5), k.new_nbs||'0' || trunc ( dbms_random.value ( 100000000, 999999999 ) )) ;
                     bars_audit.info(l_trace||'random --> l_new_nls='||l_new_nls||', tries='||l_tries);
             end loop;  
             
             if l_tries < 100 then
                update TRANSFORM_2017_FORECAST  set new_nls = l_new_nls,  insert_date = sysdate  where kf = c.kf and nls = k.nls;
                bars_audit.info(l_trace||'cчет подобран. kf='||c.kf||', acc='||k.nls||'->'||l_new_nls);
             else
                bars_audit.info(l_trace||'cчет не подобран. kf='||c.kf||', acc='||k.nls);
             end if;     
             commit;                 
        end loop; 
    end loop;
end;
/


show err


   