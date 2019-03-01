prompt p_set_link_groups
create or replace procedure p_set_link_groups(p_errlog out clob)
is
-- version 2.4
-- COBUSUPABS-6160 - Процедура автоматичного заповнення параметрів "Код групи пов'язаності", "Назва групи пов'язаності"
g_trace varchar2(30):= 'P_SET_LINK_GROUPS: ';
l_errlog_full clob;
l_errlog clob;

procedure p_remove_link_groups_customers(p_removeerrlog out clob)
    is
begin
    delete from customerw t
    where t.tag in ('LINKG', 'LINKK');
    bars_audit.info(p_msg => g_trace || 'видалено пар доп. реквізитів: '||sql%rowcount/2);
exception
    when others then
       p_removeerrlog := 'Помилка видалення реквізитів: '||sqlerrm||chr(10);
       bars_audit.error(p_msg => g_trace || p_removeerrlog);
end;

procedure p_set_link_groups_customers(p_seterrlog out clob)
    is
    l_rnk number_list;
    l_cnt number := 0;
    l_exist_flag pls_integer;
begin
    for rec in (select * from d8_cust_link_groups)
        loop
            if rec.rnk is not null then
                for kf in (select * from mv_kf where kf = rec.mfo)
                    loop
                        begin
                            select 1 into l_exist_flag from customer where rnk = rec.rnk;
                            insert all
                            into customerw (rnk, tag, value, isp, kf) values (rec.rnk, 'LINKG', to_char(rec.link_group), 0, bars_sqnc.get_kf(substr(rec.rnk, -2, 2)))
                            into customerw (rnk, tag, value, isp, kf) values (rec.rnk, 'LINKK', rec.groupname, 0, bars_sqnc.get_kf(substr(rec.rnk, -2, 2)))
                            select 1 from dual;
                            l_cnt := l_cnt + 2;
                        exception
                            when no_data_found then p_seterrlog := p_seterrlog || 'Клієнт RNK='||rec.rnk||' відсутній'||chr(10);
                        end;
                end loop;
            else
                begin
                    select rnk bulk collect into l_rnk from customer where okpo = rec.okpo and date_off is null;
                exception
                    when no_data_found then null;
                end;
                insert into customerw (rnk, tag, value, isp, kf)
                select column_value, 'LINKG', to_char(rec.link_group), 0, bars_sqnc.get_kf(substr(column_value, -2, 2)) from table(l_rnk)
                union all
                select column_value, 'LINKK', rec.groupname, 0, bars_sqnc.get_kf(substr(column_value, -2, 2)) from table(l_rnk);

                l_cnt := l_cnt + sql%rowcount;
            end if;
        end loop;
        bars_audit.info(g_trace||'оновлено '||l_cnt/2||' пар реквізитів');
end;

begin
    if sys_context('bars_context', 'user_branch') != '/' then
        p_errlog := 'Ви знаходитесь не під "/", немає прав на простановку кодів';
        return;
    end if;
    p_remove_link_groups_customers(l_errlog);
    l_errlog_full := l_errlog_full || l_errlog;
    l_errlog := null;
    p_set_link_groups_customers(l_errlog);
    l_errlog_full := l_errlog_full || l_errlog;
    p_errlog := l_errlog_full;
end p_set_link_groups;
/
Show errors;

grant execute on bars.p_set_link_groups to bars_access_defrole;