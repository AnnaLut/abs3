prompt procedure p_fm_checkrules
create or replace procedure p_fm_checkrules (p_dat1 date, p_dat2 date, p_rules varchar2)
is
/*
author: неизвестный гений
purpose: отбор документов по правилам ФМ
v. 2.0
*/
    l_trace varchar2(64):= 'p_fm_checkrules: ';
    i number;
    l_rules varchar2(254);
    partition_doesnt_exist exception;
    resource_busy exception;
    pragma exception_init(partition_doesnt_exist, -2149);
    pragma exception_init(resource_busy, -54);
begin
    bars_audit.trace(l_trace || 'start for rules: '||p_rules);
    begin
      execute immediate 'alter table bars.tmp_fm_checkrules truncate partition usr' || user_id;
      bars_audit.info('tmp_fm_checkrules truncated');
    exception
      when partition_doesnt_exist then
          execute immediate 'alter table bars.tmp_fm_checkrules add partition usr'|| user_id || ' values (' || user_id || ')';
      --when resource_busy then 
        --  raise_application_error(-20000, 'Запит від даного користувача вже виконується');
      when others then
          bars_audit.info('tmp_fm_checkrules : '||sqlerrm);
    end;

    for z in ( select ref, vdat
               from oper
              where vdat between p_dat1 and p_dat2
                and ( kv  = 980 and s >= 10000000
                   or kv <> 980 and gl.p_icurval (nvl(kv, 980), nvl(s, 0), vdat) >= 10000000 )
           )
    loop
     l_rules := null;

     for k in ( select * from fm_rules where ',' || p_rules || ',' like '%,' || id || ',%')
     loop
        begin
           execute immediate 'select unique ref from ' || k.v_name || ' where ref = :ref and vdat = :vdat'
           into i using z.ref, z.vdat;
           l_rules := l_rules || ', ' || k.id;
        exception 
            when no_data_found then null;
        end;
     end loop;

     if l_rules is not null then
        insert into tmp_fm_checkrules(id, ref, rules) values (user_id, z.ref, substr(l_rules,3));
     end if;
    end loop;
end;
/
show err;

PROMPT *** Create  grants  P_FM_CHECKRULES ***
grant EXECUTE                                                                on P_FM_CHECKRULES to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_CHECKRULES to FINMON01;
grant EXECUTE                                                                on P_FM_CHECKRULES to START1;
