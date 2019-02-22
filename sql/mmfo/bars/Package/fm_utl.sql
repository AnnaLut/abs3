prompt PACKAGE FM_UTL

create or replace package fm_utl
is
/* created 26.12.2017
  Разрозненные процедуры модуля ФМ собраны в один пакет */
g_header_version constant varchar2(64) := 'version 1.4   21.11.2018';

-- возвращает версию заголовка пакета FM_UTL
function header_version return varchar2;

-- возвращает версию тела пакета FM_UTL
function body_version   return varchar2;

--
-- Перерахунок рівня ризику клієнтів
--
procedure recalc_risk(p_risk_id in fm_risk_criteria.id%type);

--  
-- Запустить процедуру в джобе, который по завершению отправит сообщение p_success_message запустившему пользователю и самоудалится
--
procedure run_deferred_task(p_procname        varchar2,
                            p_success_message varchar2);

--
-- Пакетное проставление параметров ФМ
-- проставляет один набор кодов операции, ОМ и ВМ на весь список операций
--
procedure set_fm_params_bulk(p_refs     in number_list,                  -- коллекция референсов
                             p_opr_vid1 in finmon_que.opr_vid1%type,     -- код вида операции
                             p_opr_vid2 in finmon_que.opr_vid2%type,     -- код ОМ
                             p_comm2    in finmon_que.comm_vid2%type,    -- комментарий к ОМ
                             p_opr_vid3 in finmon_que.opr_vid3%type,     -- код ВМ
                             p_comm3    in finmon_que.comm_vid3%type,    -- комментарий к ВМ
                             p_mode     in finmon_que.monitor_mode%type, -- режим мониторинга
                             p_vid2     in string_list,                  -- доп. коды ОМ (коллекция)
                             p_vid3     in string_list                   -- доп. коды ВМ (коллекция)
                             );

--
-- Проверка операций за период на соответствие правилам ФМ
-- наполняет таблицу tmp_fm_checkrules для вызвавшего пользователя
--
procedure check_fm_rules (p_dat1 date, p_dat2 date, p_rules varchar2);

--
-- Проверка операции (неблокирующая) на список террористов
-- возвращает 0 в случае отсутствия совпадения, -1 в случае ошибки или номер в справочнике террористов
--
function ref_check(p_ref oper.ref%type) return number;

--
-- Проверка (блокирующая) конкретной операции или всех операций в очереди
-- в случае совпадения отправляет в очередь для просмотра ФМ и блокирует визой ФМ
--
procedure ref_block(p_ref in oper.ref%type default null);

end fm_utl;
/
create or replace package body fm_utl
is
g_body_version constant varchar2(64)  := 'version 1.4   21.11.2018';
g_trace constant varchar2(16) := 'FM_UTL';

-------------------------------------------------------------------------------------------------
-- header_version - возвращает версию заголовка пакета FM_UTL
-------------------------------------------------------------------------------------------------
FUNCTION header_version
RETURN VARCHAR2
IS
BEGIN
   RETURN 'Package header '||g_trace|| ' ' || G_HEADER_VERSION;
END header_version;

-------------------------------------------------------------------------------------------------
-- body_version - возвращает версию тела пакета FM_UTL
-------------------------------------------------------------------------------------------------
FUNCTION body_version
   RETURN VARCHAR2
IS
BEGIN
   RETURN 'Package body '||g_trace|| ' ' || G_BODY_VERSION;
END body_version;

--
-- Перерахунок рівня ризику клієнтів
--
procedure recalc_risk(p_risk_id in fm_risk_criteria.id%type) is
    l_trace constant varchar2(24) := 'RECALC_RISK';
    l_value  varchar2(20);
    l_iddpl  date;
    l_rizik  number;
    l_iddpr2 date;
    l_rnk    customer.rnk%TYPE;
    CURSOR c1 is
        SELECT c.rnk
          FROM customer c
         inner join customer_risk r
            on r.rnk = c.rnk
         WHERE c.date_off is null
           and r.risk_id = p_risk_id
           and trunc(sysdate) between r.dat_begin and
               coalesce(r.dat_end, to_date('31.12.9999', 'dd.mm.yyyy'));
begin
    bars_audit.info(g_trace || '.' || l_trace || ': start p_risk_id=' ||
                    to_char(p_risk_id));

    OPEN c1;
    LOOP
        fetch c1
            into l_rnk;
    EXIT WHEN c1%NOTFOUND;
    
        select substr(f_get_cust_hlist(l_rnk,
                                       23,
                                       f_get_cust_fmdat(to_number(to_char(sysdate,
                                                                          'DDMMYYYY')))),
                      1,
                      20)
          into l_value
          from dual;
        begin
            update customerw
               set value = l_value
             where rnk = l_rnk
               and tag = 'RIZIK';
            if sql%rowcount = 0 then
                insert into customerw
                    (rnk, tag, value, isp)
                values
                    (l_rnk, 'RIZIK', l_value, 0);
            end if;
        end;
    
        begin
            begin
            
                select trim(to_date(c.value, 'dd/mm/yyyy'))
                  into l_iddpr2
                  from customerw c
                 where rnk = l_rnk
                   and tag = 'IDDPR';
            
                begin
                    select nvl(decode(l_value,
                                      'Неприйнятно високий',
                                      1,
                                      'Високий',
                                      1,
                                      'Середній',
                                      2,
                                      3),
                               3)
                      into l_rizik
                      from dual;
                exception
                    when no_data_found then
                        l_rizik := 3;
                end;
            
                select add_months(l_iddpr2,
                                  decode(l_rizik, 1, 12, 2, 24, 36))
                  into l_iddpl
                  from dual;
                if l_iddpl < add_months(bankdate, 1) then
                    l_iddpl := add_months(bankdate, 1);
                end if;
            
                update customerw c
                   set c.value = to_char(l_iddpl, 'dd/mm/yyyy')
                 where c.tag = 'IDDPL'
                   and c.rnk = l_rnk;
                if sql%rowcount = 0 then
                    insert into customerw
                        (rnk, tag, value, isp)
                    values
                        (l_rnk, 'IDDPL', to_char(l_iddpl, 'dd/mm/yyyy'), 0);
                end if;
            
            exception
                when others then
                    if sqlcode = -01861 then
                        select add_months(bankdate, 1)
                          into l_iddpl
                          from dual;
                        update customerw c
                           set c.value = to_char(l_iddpl, 'dd/mm/yyyy')
                         where c.tag = 'IDDPL'
                           and c.rnk = l_rnk;
                        if sql%rowcount = 0 then
                            insert into customerw
                                (rnk, tag, value, isp)
                            values
                                (l_rnk,
                                 'IDDPL',
                                 to_char(l_iddpl, 'dd/mm/yyyy'),
                                 0);
                        end if;
                    elsif sqlcode = -01858 then
                        select add_months(bankdate, 1)
                          into l_iddpl
                          from dual;
                        update customerw c
                           set c.value = to_char(l_iddpl, 'dd/mm/yyyy')
                         where c.tag = 'IDDPL'
                           and c.rnk = l_rnk;
                        if sql%rowcount = 0 then
                            insert into customerw
                                (rnk, tag, value, isp)
                            values
                                (l_rnk,
                                 'IDDPL',
                                 to_char(l_iddpl, 'dd/mm/yyyy'),
                                 0);
                        end if;
                    elsif sqlcode = -01843 then
                        select add_months(bankdate, 1)
                          into l_iddpl
                          from dual;
                        update customerw c
                           set c.value = to_char(l_iddpl, 'dd/mm/yyyy')
                         where c.tag = 'IDDPL'
                           and c.rnk = l_rnk;
                        if sql%rowcount = 0 then
                            insert into customerw
                                (rnk, tag, value, isp)
                            values
                                (l_rnk,
                                 'IDDPL',
                                 to_char(l_iddpl, 'dd/mm/yyyy'),
                                 0);
                        end if;
                    elsif sqlcode = -01830 then
                        select add_months(bankdate, 1)
                          into l_iddpl
                          from dual;
                        update customerw c
                           set c.value = to_char(l_iddpl, 'dd/mm/yyyy')
                         where c.tag = 'IDDPL'
                           and c.rnk = l_rnk;
                        if sql%rowcount = 0 then
                            insert into customerw
                                (rnk, tag, value, isp)
                            values
                                (l_rnk,
                                 'IDDPL',
                                 to_char(l_iddpl, 'dd/mm/yyyy'),
                                 0);
                        end if;
                    elsif sqlcode = -01841 then
                        select add_months(bankdate, 1)
                          into l_iddpl
                          from dual;
                        update customerw c
                           set c.value = to_char(l_iddpl, 'dd/mm/yyyy')
                         where c.tag = 'IDDPL'
                           and c.rnk = l_rnk;
                        if sql%rowcount = 0 then
                            insert into customerw
                                (rnk, tag, value, isp)
                            values
                                (l_rnk,
                                 'IDDPL',
                                 to_char(l_iddpl, 'dd/mm/yyyy'),
                                 0);
                        end if;
                    elsif sqlcode = -01847 then
                        select add_months(bankdate, 1)
                          into l_iddpl
                          from dual;
                        update customerw c
                           set c.value = to_char(l_iddpl, 'dd/mm/yyyy')
                         where c.tag = 'IDDPL'
                           and c.rnk = l_rnk;
                        if sql%rowcount = 0 then
                            insert into customerw
                                (rnk, tag, value, isp)
                            values
                                (l_rnk,
                                 'IDDPL',
                                 to_char(l_iddpl, 'dd/mm/yyyy'),
                                 0);
                        end if;
                    elsif sqlcode = -01840 then
                        select add_months(bankdate, 1)
                          into l_iddpl
                          from dual;
                        update customerw c
                           set c.value = to_char(l_iddpl, 'dd/mm/yyyy')
                         where c.tag = 'IDDPL'
                           and c.rnk = l_rnk;
                        if sql%rowcount = 0 then
                            insert into customerw
                                (rnk, tag, value, isp)
                            values
                                (l_rnk,
                                 'IDDPL',
                                 to_char(l_iddpl, 'dd/mm/yyyy'),
                                 0);
                        end if;
                    elsif sqlcode = -01839 then
                        select add_months(bankdate, 1)
                          into l_iddpl
                          from dual;
                        update customerw c
                           set c.value = to_char(l_iddpl, 'dd/mm/yyyy')
                         where c.tag = 'IDDPL'
                           and c.rnk = l_rnk;
                        if sql%rowcount = 0 then
                            insert into customerw
                                (rnk, tag, value, isp)
                            values
                                (l_rnk,
                                 'IDDPL',
                                 to_char(l_iddpl, 'dd/mm/yyyy'),
                                 0);
                        end if;
                    else
                        raise;
                    end if;
            end;
        
        exception
            when no_data_found then
                select add_months(bankdate, 1) into l_iddpl from dual;
                update customerw c
                   set c.value = to_char(l_iddpl, 'dd/mm/yyyy')
                 where c.tag = 'IDDPL'
                   and c.rnk = l_rnk;
                if sql%rowcount = 0 then
                    insert into customerw
                        (rnk, tag, value, isp)
                    values
                        (l_rnk, 'IDDPL', to_char(l_iddpl, 'dd/mm/yyyy'), 0);
                end if;
            
        end;
    
    END LOOP;
    CLOSE c1;

    bars_audit.info(g_trace || '.' || l_trace || ': finish');
end recalc_risk;

-------------------------------------------------------------------------------------------------
-- запустить процедуру в джобе, который по завершению отправит сообщение p_success_message запустившему пользователю и самоудалится
-------------------------------------------------------------------------------------------------
procedure run_deferred_task(p_procname        varchar2,
                            p_success_message varchar2)
is
l_jobname varchar2(64) := 'FM_'||substr(upper(p_procname), instr(p_procname, '.')+1)||'_'||f_ourmfo;
l_error_message varchar2(256) := 'Відкладена процедура виконалась з помилками. Зверніться до департаменту ІТ';
l_action varchar2(2000) :=
'begin
    bars_login.login_user(sys_guid, 1, null, null);
    bc.go('''||f_ourmfo||''');
    '||p_procname||';
    commit;
    bms.send_message(p_receiver_id     => '||user_id||',
     p_message_type_id => 1,
     p_message_text    => '''||p_success_message||''',
     p_delay           => 0,
     p_expiration      => 0);
 exception
     when others then
             bms.send_message(p_receiver_id     => '||user_id||',
             p_message_type_id => 1,
             p_message_text    => '''||l_error_message||''',
             p_delay           => 0,
             p_expiration      => 0);
 end;';
begin
    --bars_audit.info(g_trace||'.run_deferred_task '||l_jobname||': start p_procname='||p_procname||', p_success_message='||p_success_message);
    dbms_scheduler.create_job(job_name => l_jobname,
                              job_type => 'PLSQL_BLOCK',
                              job_action => l_action,
                              auto_drop => true,
                              enabled => true);
exception
    when others then
        -- в любом случае срубаем джоб
        dbms_scheduler.drop_job(l_jobname, force => true);
        raise;
end run_deferred_task;

--
-- Пакетное проставление параметров ФМ
-- проставляет один набор кодов операции, ОМ и ВМ на весь список операций
--
procedure set_fm_params_bulk(p_refs     in number_list,                  -- коллекция референсов
                             p_opr_vid1 in finmon_que.opr_vid1%type,     -- код вида операции
                             p_opr_vid2 in finmon_que.opr_vid2%type,     -- код ОМ
                             p_comm2    in finmon_que.comm_vid2%type,    -- комментарий к ОМ
                             p_opr_vid3 in finmon_que.opr_vid3%type,     -- код ВМ
                             p_comm3    in finmon_que.comm_vid3%type,    -- комментарий к ВМ
                             p_mode     in finmon_que.monitor_mode%type, -- режим мониторинга
                             p_vid2     in string_list,                  -- доп. коды ОМ (коллекция)
                             p_vid3     in string_list                   -- доп. коды ВМ (коллекция)
                             )
is
/*
created 12.05.2017
ММФО
*/
g_modcode constant varchar2(3) := 'FMN';
l_refs_to_audit varchar2(2000);
begin
    bars_audit.trace('%s: %s entry', g_modcode, $$PLSQL_UNIT);
    if p_refs.count <= 150 then
        select trim(substr(listagg(column_value, ', ') within group (order by 1), 1, 1500)) into l_refs_to_audit from table(p_refs);
    else l_refs_to_audit := '>150 refs, not shown';
    end if;
    bars_audit.trace('%s: %s merging, refs=>(%s)(1500 substr)', g_modcode, $$PLSQL_UNIT, l_refs_to_audit);

    merge into finmon_que f
    using (select p.column_value as CV
         from table(p_refs) p
         join oper o on p.column_value = o.ref) r
    on (f.ref = r.CV)
    when matched then update
                    set f.opr_vid1 = p_opr_vid1,
                        f.opr_vid2 = p_opr_vid2,
                        f.comm_vid2 = p_comm2,
                        f.opr_vid3 = p_opr_vid3,
                        f.comm_vid3 = p_comm3,
                        f.monitor_mode = p_mode,
                        f.rnk_a = (select c.rnk from customer c
                                   where c.rnk = coalesce(f.rnk_a, -- если уже заполнен
                                                         (select a.rnk
                                                          from oper o
                                                          join accounts a on o.nlsa = a.nls and o.kv = a.kv and o.mfoa = a.kf
                                                          where o.ref = r.CV), -- ищем по счету
                                                         (select max(co.rnk) -- ищем по окпо в документе - если такой клиент один
                                                          from customer co
                                                          join oper o on co.okpo = o.id_a
                                                          where o.ref = r.CV
                                                          group by co.okpo
                                                          having count(*)=1
                                                         ))
                                   ),
                        f.rnk_b = (select c.rnk from customer c
                                   where c.rnk = coalesce(f.rnk_b, -- если уже заполнен
                                                         (select a.rnk
                                                          from oper o
                                                          join accounts a on o.nlsb = a.nls and nvl(o.kv2, o.kv) = a.kv and o.mfob = a.kf
                                                          where o.ref = r.CV), -- ищем по счету
                                                         (select max(co.rnk) -- ищем по окпо в документе - если такой клиент один
                                                          from customer co
                                                          join oper o on co.okpo = o.id_b
                                                          where o.ref = r.CV
                                                          group by co.okpo
                                                          having count(*)=1
                                                         ))
                                   )
    when not matched then insert(ref, rec, status, opr_vid1, opr_vid2, comm_vid2, opr_vid3, comm_vid3, monitor_mode, agent_id, rnk_a, rnk_b)
    values (r.CV, null, 'I', p_opr_vid1, p_opr_vid2, p_comm2, p_opr_vid3, p_comm3, p_mode, user_id, coalesce((select a.rnk
                                                                                                                          from oper o
                                                                                                                          join accounts a on o.nlsa = a.nls and o.kv = a.kv and o.mfoa = a.kf
                                                                                                                          where o.ref = r.CV),
                                                                                                                         (select max(co.rnk)
                                                                                                                          from customer co
                                                                                                                          join oper o on co.okpo = o.id_a
                                                                                                                          where o.ref = r.CV
                                                                                                                          group by co.okpo
                                                                                                                          having count(*)=1
                                                                                                                         )),
                                                                                                  coalesce((select a.rnk
                                                                                                                          from oper o
                                                                                                                          join accounts a on o.nlsb = a.nls and nvl(o.kv2, o.kv) = a.kv and o.mfob = a.kf
                                                                                                                          where o.ref = r.CV),
                                                                                                                         (select max(co.rnk)
                                                                                                                          from customer co
                                                                                                                          join oper o on co.okpo = o.id_b
                                                                                                                          where o.ref = r.CV
                                                                                                                          group by co.okpo
                                                                                                                          having count(*)=1
                                                                                                                         ))
    );
    bars_audit.trace('%s: %s merged, refs=>(%s)', g_modcode, $$PLSQL_UNIT, l_refs_to_audit);
    -- если есть доп. коды ОМ
    -- удаляем существующие
    delete from finmon_que_vid2 where id in (select id from finmon_que where ref in (select * from table(p_refs)));
    if p_vid2 is not null and p_vid2.count > 0 then
        if p_vid2.first is not null then
            bars_audit.trace('%s: %s vids2 is not empty, processing', g_modcode, $$PLSQL_UNIT);
            -- проставляем новые
            forall idx in 1..p_vid2.count
                insert into finmon_que_vid2(id, vid)
                select id, p_vid2(idx)
                from finmon_que where ref in (select * from table(p_refs));
        end if;
    end if;
    -- если есть доп. коды ВМ
    -- удаляем существующие
    delete from finmon_que_vid3 where id in (select id from finmon_que where ref in (select * from table(p_refs)));
    if p_vid3 is not null and p_vid3.count > 0 then
        if p_vid3.first is not null then
            bars_audit.trace('%s: %s vids3 is not empty, processing', g_modcode, $$PLSQL_UNIT);
            -- проставляем новые
            forall idx in 1..p_vid3.count
                insert into finmon_que_vid3(id, vid)
                select id, p_vid3(idx)
                from finmon_que where ref in (select * from table(p_refs));
        end if;
    end if;

    bars_audit.trace('%s: %s done', g_modcode, $$PLSQL_UNIT);
end set_fm_params_bulk;

--
-- Проверка операций за период на соответствие правилам ФМ;
-- наполняет таблицу tmp_fm_checkrules для вызвавшего пользователя
--
procedure check_fm_rules (p_dat1 date, p_dat2 date, p_rules varchar2)
is
l_trace constant varchar2(128):= g_trace || '.check_fm_rules';
l_tmp   pls_integer;
l_rules varchar2(254);
partition_doesnt_exist exception;
resource_busy exception;
pragma exception_init(partition_doesnt_exist, -2149);
pragma exception_init(resource_busy, -54);
begin
    bars_audit.trace(l_trace || ' start for rules: '||p_rules);
    begin
        execute immediate 'alter table bars.tmp_fm_checkrules truncate partition usr' || user_id;
        bars_audit.trace('tmp_fm_checkrules truncated');
    exception
        when partition_doesnt_exist then
            execute immediate 'alter table bars.tmp_fm_checkrules add partition usr'|| user_id || ' values (' || user_id || ')';
        when resource_busy then
            raise_application_error(-20000, 'Запит від даного користувача вже виконується');
        when others then
            bars_audit.error('tmp_fm_checkrules : '||sqlerrm);
            raise;
    end;
/*
TODO: owner="oleksandr.lypskykh" category="Optimize" priority="2 - Medium" created="20.12.2017"
text="На текущий момент верхний цикл делает несколько тысяч итераций.
      Есть смысл попытаться переписать на работу с множествами - либо sql, либо pl/sql коллекции.
      Не критично, но желательно."
*/
    for z in (select ref, vdat
                from oper
               where vdat between p_dat1 and p_dat2
                 and
                 (kv = 980 and s >= 10000000
                  or
                  kv <> 980 and gl.p_icurval (nvl(kv, 980), nvl(s, 0), vdat) >= 10000000)
             )
    loop
        l_rules := null;

        for k in ( select * from fm_rules where ',' || p_rules || ',' like '%,' || id || ',%')
        loop
            begin
                execute immediate 'select 1 from ' || k.v_name || ' where ref = :ref and vdat = :vdat'
                into l_tmp using z.ref, z.vdat;
                l_rules := l_rules || ', ' || k.id;
            exception
                when no_data_found then null;
            end;
        end loop;

        if l_rules is not null then
            insert into tmp_fm_checkrules(id, ref, rules) values (user_id, z.ref, substr(l_rules, 3));
        end if;
    end loop;
    bars_audit.trace(l_trace || ' finish.');
end check_fm_rules;

--
-- Проверка операции (неблокирующая) на список террористов
-- возвращает 0 в случае отсутствия совпадения, -1 в случае ошибки или номер в справочнике террористов
--
function ref_check(p_ref oper.ref%type) return number
is
l_trace constant varchar2(150) := g_trace||'.'||'ref_check';
l_datr           date;
l_nazn           oper.nazn%type;
l_nama           oper.nam_a%type;
l_namb           oper.nam_b%type;
l_id_a  oper.id_a%type;
l_id_b  oper.id_b%type;
l_tt             oper.tt%type;
l_flag           number;
l_otm            fm_ref_que.otm%type := 0;
resource_busy    exception;
pragma exception_init (resource_busy, -54);
begin
    bars_audit.trace(l_trace || ': start. Получаем данные операции '||p_ref);
    begin
        select o.tt, o.nazn, o.nam_a, o.nam_b
          into l_tt, l_nazn, l_nama, l_namb
          from oper o
         where o.ref = p_ref
        for update of o.sos nowait;
    exception
        when no_data_found then return -1;
        when resource_busy then return -1;
    end;
    bars_audit.trace(l_trace || ': сверяем флаг "не проверять на террористов"');
    -- не проверять операции с флагом "Не сверять со списком террористов"
    l_flag := operations.GET_FLAG(tt_id => l_tt, flag_id => 30);
    if l_flag = 1 then
        return 0;
    end if;
    -- проверка на совпадение со списком террористов
    -- наименование отправителя
    bars_audit.trace(l_trace || ': проверяем наименование отправителя');
    l_otm := fm_terrorist_utl.get_terrorist_code(l_nama);
    -- наименование получателя
    if l_otm = 0 then
        bars_audit.trace(l_trace || ': проверяем наименование получателя');
        l_otm := fm_terrorist_utl.get_terrorist_code(l_namb);
    end if;
    -- назначение платежа
    if l_otm = 0 then
        bars_audit.trace(l_trace || ': проверяем назначение платежа');
        l_otm := fm_terrorist_utl.get_terrorist_code(l_nazn);
    end if;

    if l_otm = 0 then
        bars_audit.trace(l_trace || ': проверяем допреквизиты');
        for d in ( select value, tag
                     from operw
                    where ref = p_ref
                      and tag in ('FIO', 'FIO2', 'OTRIM') )
        loop
            bars_audit.trace(l_trace || ': проверяем допреквизиты: '||d.tag);
            l_otm := fm_terrorist_utl.get_terrorist_code(d.value);
            if l_otm > 0 then
                exit;
            end if;
        end loop;
    end if;

    /*
      COBUSUPABS-9160
    */
    -------------------------------
    -- Якщо в l_id_a , l_id_b є ОКПО в терористах
    if l_otm = 0 then
       begin
            select fin_r.c1 into l_otm
              from bars.FINMON_REFT fin_r
             where fin_r.c25 is not null
               and regexp_like(fin_r.c25, '^([[:digit:]]{8}|[[:digit:]]{10})$')
               and fin_r.c25 in (l_id_a , l_id_b)
               and rownum = 1;
       exception
         when no_data_found then l_otm := 0;
       end;
    end if;
    -- Якщо в l_nazn є ОКПО в терористах
    if l_otm = 0 then
       begin 
        with tab_okpo as
         (SELECT regexp_replace(res_okpo, '[^0-9]') res_okpo
            FROM (SELECT REGEXP_SUBSTR(str, '[^ ]+', 1, LEVEL) AS res_okpo
                    FROM (SELECT l_nazn AS str
                            FROM DUAL)
                  CONNECT BY LEVEL <= LENGTH(REGEXP_REPLACE(str, '[^ ]+')) + 1)
           WHERE REGEXP_LIKE(res_okpo, '(^|\D)(\d{8}|\d{10})(\D|$)'))
        select fin_r.c1 into l_otm
          from bars.FINMON_REFT fin_r, tab_okpo
         where fin_r.c25 = tab_okpo.res_okpo
           and fin_r.c25 is not null
           and regexp_like(fin_r.c25, '^([[:digit:]]{8}|[[:digit:]]{10})$')
           and rownum = 1;
           exception
         when no_data_found then l_otm := 0;
       end;
    end if;
    -- Якщо в TAG =>FIO э слова ч/3 або через то треба перевірити стандартним методом
    if l_otm = 0 then
       begin
        for check_str in ( 
                           select level as element,
                                  regexp_substr(str, '(.*?)( (через)|(ч/з)|$)', 1, level, null, 1) as element_value
                             from (select value str
                                     from operw
                                    where ref = p_ref
                                      and tag = 'FIO'
                                      and rownum =1 
                                  ) 
                             where regexp_like(str,'ч/з|через') 
                             connect by level <= regexp_count(str, 'через') + regexp_count(str, 'ч/з')+ 1
                          )
        loop
           l_otm := f_istr (check_str.element_value);
           if l_otm > 0 then
              exit;
           end if;
        end loop;
       exception
         when no_data_found then l_otm := 0;  
       end;
    end if;
    ------------------------------
    
    /*COBUSUPABS-5202
    По операціям з кодами CVO, IBO, CVS додатково перевіряти на наявність терористів у Переліку додатковий реквізит операції "59" «SWT.59 Beneficiare Customer»
    (%TERROR%, де TERROR - найменування юрособи або ПІБ особи з переліку осіб).
    В даному тезі присутня інформація, відмінна від ПІБ учасника.*/
    if l_otm = 0 and l_tt in ('CVO', 'IBO', 'CVS') then
        begin
            bars_audit.trace(l_trace || ': проверяем допреквизит 59');
            with o59 as
            (select f_translate_kmu(o.value) as t59 from bars.operw o where ref = p_ref and tag = '59')
            select c1 into l_otm
            from bars.v_finmon_reft r, o59
            where regexp_like(o59.t59, '[^A-Za-zА-Яа-я]'||REGEXP_REPLACE ( f_translate_kmu(c6 || ' ' || c7 || ' ' || c8 || ' ' || c9), '([()\:"])', '\\\1', 1, 0)||'[^A-Za-zА-Яа-я]')
            and rownum = 1;
        exception
            when no_data_found then l_otm := 0;
        end;
    end if;
    /*COBUSUPABS-5202 end*/

    -- доп проверка ) виключення з правил. Загальне правило, якщо є збіг по ПІБ - операція блокується.
    -- Але якщо ми можемо перевірити дату народження особи в Переліку і в операції, і якщо вони не рівні, то тільки тоді операція не блокується.
    if l_otm >= 10000 then
        bars_audit.trace(l_trace||': Исключение: l_otm>= 10000 = '||l_otm);
        begin
            select to_date(c13,'dd.mm.yyyy')
              into l_datr
              from finmon_reft
             where c1 = l_otm;
            bars_audit.trace(l_trace||': Дата рождения из finmon_reft = '||to_char(l_datr,'dd.mm.yyyy'));
        exception when value_error
                  then l_datr := null;
                       bars_audit.trace(l_trace||': Дата рождения из finmon_reft не найдена или не в видe dd.mm.yyyy');
        end;

        if l_datr is not null
        then
            begin
                for dats in ( select to_date(value,'dd/mm/yyyy') value
                             from operw
                            where ref = p_ref
                              and tag in ('DATN', 'DRDAY', 'DT_R') )
                loop
                    if dats.value = l_datr
                    then
                        bars_audit.trace(l_trace||': Дата рождения из operw = '||to_char(dats.value,'dd.mm.yyyy'));
                        exit;
                    else
                        l_otm := 0;
                        bars_audit.trace(l_trace||': Дата рождения из operw = '||to_char(dats.value,'dd.mm.yyyy')|| ' не равна дате рождения в списке. Сбрасываем признак.');
                    end if;
                end loop;
            exception when value_error
                then bars_audit.trace(l_trace||': Дата рождения из operw не найдена или не в видe dd.mm.yyyy');
            end;
        end if;
    end if;
    return l_otm;
end ref_check;

--
-- Проверка (блокирующая) конкретной операции или всех операций в очереди
-- в случае совпадения отправляет в очередь для просмотра ФМ и блокирует визой ФМ
--
procedure ref_block(p_ref in oper.ref%type default null)
is
-- код группы визирования "Заблокировано Фин.Мониторингом"
c_grp   constant number := getglobaloption ('FM_GRP1');
l_otm            fm_ref_que.otm%type := 0;
l_trace constant varchar2(150) := g_trace||'.'||'ref_block';
l_doc_lock_limit constant number := 100;
begin
    bars_audit.trace(l_trace||': Старт'||case when p_ref is not null then ' для ref='||p_ref else '' end);
    if p_ref is not null then
        /* проверка одного документа */
        for r in (select ref from ref_que where fmcheck = 0 and ref = p_ref )
        loop
            bars_audit.trace(l_trace||': loop: ref = '||p_ref);
            l_otm := ref_check(r.ref);
            if l_otm = -1 then
                continue; /* если проверка вернула ошибку - переходим к следующей операции */
            end if;
            bars_audit.trace(l_trace||': ставим признак "проверено": '||r.ref);
            update ref_que
            set fmcheck = 1
            where ref = p_ref;
            if l_otm > 0 then
                begin
                    bars_audit.trace(l_trace||': вставляем в очередь ФМ');
                    insert into fm_ref_que (ref, otm)
                    values (p_ref, l_otm);
                exception
                    when dup_val_on_index then null;
                end;

                if c_grp is not null then
                    bars_audit.trace(l_trace||': блокируем визой ФМ');
                    insert into oper_visa (ref, dat, userid, groupid, status)
                    values (p_ref, sysdate, user_id, c_grp, 1);
                end if;
            end if;
        end loop;
    else
        /* проверка всех документов в очереди */
        for r in (select rownum rn, ref from ref_que where fmcheck = 0 )
        loop
            bars_audit.trace(l_trace||': loop: ref = '||r.ref);
            l_otm := ref_check(r.ref);
            if l_otm = -1 then
                continue; /* если проверка вернула ошибку - переходим к следующей операции */
            end if;
            bars_audit.trace(l_trace||': ставим признак "проверено": '||r.ref);
            update ref_que
            set fmcheck = 1
            where ref = r.ref;
            if l_otm > 0 then
                begin
                    bars_audit.trace(l_trace||': вставляем в очередь ФМ');
                    insert into fm_ref_que (ref, otm)
                    values (r.ref, l_otm);
                exception
                    when dup_val_on_index then null;
                end;

                if c_grp is not null then
                    bars_audit.trace(l_trace||': блокируем визой ФМ');
                    insert into oper_visa (ref, dat, userid, groupid, status)
                    values (r.ref, sysdate, user_id, c_grp, 1);
                end if;
            end if;
           -- коммитим (отпуская oper for update) каждые N проверенных документов
           if mod(r.rn, l_doc_lock_limit) = 0 then
               commit;
           end if;
        end loop;
    end if;

exception when others then
    -- этот блок нужен, чтобы не оставаться в чужом бранче
    -- возвращаемся к себе
    bc.set_context;
    -- обязательно выбрасываем ошибку дальше
    raise_application_error(-20000,
          dbms_utility.format_error_stack() || chr(10) ||
          dbms_utility.format_error_backtrace());
end ref_block;

end fm_utl;
/
show errors;
grant execute on bars.fm_utl to bars_access_defrole;