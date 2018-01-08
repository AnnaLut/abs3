

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_TRANSFORM_FORECAST_ACC.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_TRANSFORM_FORECAST_ACC ***

  CREATE OR REPLACE PROCEDURE BARS.P_TRANSFORM_FORECAST_ACC (p_accrow accounts%rowtype) is
/*
обновлние + добавление прогноза по счету
*/
    l_new_nls  accounts.nls%type;
    l_new_nbs  accounts.nbs%type;
    l_new_ob22 accounts.ob22%type;
    l_tries    number := 0;
    l_count    number;
    l_trace    varchar2(500):= 'T2017.p_transform_forecast_acc: ';

begin
    bars_audit.info(l_trace||'прогнозируем счет для kf='||p_accrow.kf||', nls='||p_accrow.nls);

    begin
       select r020_new, ob_new  into l_new_nbs, l_new_ob22  from transfer_2017 where r020_old =  p_accrow.nbs and ob_new = p_accrow.ob22 and rownum = 1;
    exception when no_data_found then
       bars_audit.info(l_trace||'не найдена пара ('||p_accrow.nbs||','||p_accrow.ob22||') для трансформации');
       return;
    end;


    l_new_nls := vkrzn( substr( p_accrow.kf, 1,5),  l_new_nbs||'0' || substr( p_accrow.nls, 6,9));
    bars_audit.info(l_trace||'расчитан лицевой = '||l_new_nls);

    l_tries :=0;
    while l_tries < 100 loop
                l_count := 0 ;
                select count(*) into l_count from
                ( select 1  from accounts                   where nls      = l_new_nls   and kf = p_accrow.kf
                  union all
                  select 1 from TRANSFORM_2017_FORECAST     where new_nls  = l_new_nls   and kf = p_accrow.kf
                );

                -- если такой счет нашли или в счете или в зарезервированных
                -- пытаемся еще раз подобрать
                if l_count = 0 then
                   -- выход, счет подобрали
                   bars_audit.info(l_trace||'счет подобрали');
                   exit;
                end if;
                l_tries := l_tries + 1;
                l_new_nls := vkrzn( substr( p_accrow.kf, 1,5), l_new_nbs||'0' || trunc ( dbms_random.value ( 100000000, 999999999 ) )) ;
     end loop;

    bars_audit.info(l_trace||' tries = '||l_tries);

    if l_tries < 100 then
       begin
          insert into transform_2017_forecast(kf, kv, acc, nbs, nls, ob22, new_nbs, new_ob22, new_nls, insert_date)
          values(p_accrow.kf,p_accrow.kv,p_accrow.acc,p_accrow.nbs,p_accrow.nls,p_accrow.ob22, l_new_nbs, l_new_ob22, l_new_nls, sysdate );
       exception when dup_val_on_index then
          update transform_2017_forecast set ob22 = p_accrow.ob22,
                                             new_nbs  = l_new_nbs,
                                             new_ob22 = l_new_ob22,
                                             new_nls  = l_new_nls,
                                             insert_date = sysdate
           where acc = p_accrow.acc;
       end;
       bars_audit.info(l_trace||'cчет подобран. kf='||p_accrow.kf||', nls='||p_accrow.nls||'->'||l_new_nls);
    else
       bars_audit.info(l_trace||'cчет не подобран. kf='||p_accrow.kf||', nls='||p_accrow.nls);
    end if;
    commit;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_TRANSFORM_FORECAST_ACC.sql =====
PROMPT ===================================================================================== 
