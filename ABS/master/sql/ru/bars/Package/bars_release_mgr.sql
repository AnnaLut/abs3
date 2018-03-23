create or replace package bars_release_mgr
is

g_version varchar2(50) := '4.0.0';


type t_row is record(rec_id number, rec_date date, inst_type varchar2(10), inst_name varchar2(50), rec_message varchar2(250));
type t_err_results is table of t_row;

type t_ddl_row is record (rec_id number,
                          rec_date date,
                          rec_bdate date,
                          rec_uname varchar2(30),
                          rec_module varchar2(30),
                          obj_name varchar2(100),
                          obj_owner varchar2(100),
                          sql_text varchar2(4000),
                          machine varchar2(100),
                          operation_type varchar2(30));
type t_audit is table of t_ddl_row;


-----------------------------------------------------------------------------------------
-- сравнение версий
-- возвращает:
-- 1 если версия1 > версия2
-- 2 если версия1 < версия2
-- 0 если версия1 = версия2
-- -1 если ошибка
function compare_versions(p_vers1 varchar2, p_vers2 varchar2) return number;
----------------------------------------------------------------------------------------
-- лог начала установки обновления
procedure install_begin(p_version varchar2);
----------------------------------------------------------------------------------------
-- лог завершения установки обновления
procedure install_end(p_version varchar2);
----------------------------------------------------------------------------------------
-- Проверить, не нарушалась ли последовательность установки в промежутке
-- возвращает 1 если не нарушалась или не было записей, -1 если порядок нарушен
function check_order(start_date date, end_date date) return number;
----------------------------------------------------------------------------------------
-- возвращает данные о ddl-операциях схемы BARS, которые были мимо офиц. обновлений
-- test
function get_ddl_audit(start_date date, end_date date) return t_audit pipelined;
----------------------------------------------------------------------------------------
-- возвращает данные из таблицы логов
function get_data(start_date date, end_date date) return t_err_results pipelined;
----------------------------------------------------------------------------------------
-- возвращает мд5-сумму объектов (programs + tables, vies, mat.views) схемы Барс
function get_hash_schema_objects return varchar2;

----------------------------------------------------------------------------------------
-- возвращает мд5-сумму объекта (program / table / view / mat.view)
function get_hash_object(p_object_id all_objects.OBJECT_ID%type) return varchar2;

----------------------------------------------------------------------------------------
-- возвращает мд5-сумму объекта (program / table / view / mat.view)
function get_hash_object(p_owner all_objects.OWNER%type,
                         p_object_type all_objects.OBJECT_TYPE%type,
                         p_object_name all_objects.OBJECT_NAME%type)
    return varchar2;

----------------------------------------------------------------------------------------
-- возвращает мд5-сумму по объектам на состояние инсталляции (ид в brm_install_log)
function get_install_hash(p_install_id brm_objects_hash.install_id%type)
    return varchar2;
    
----------------------------------------------------------------------------------------
-- выдает отчет об изменениях по объектам между записями инсталляций
function diff_report(p_install_id_start in brm_objects_hash.install_id%type, 
                      p_install_id_end in brm_objects_hash.install_id%type) return clob;
    
end bars_release_mgr;
/
grant execute on bars_release_mgr to public;
/
create or replace public synonym brm for bars.bars_release_mgr;
/
create or replace package body bars_release_mgr
is

g_r_type varchar2(15) := 'release';
g_b_type varchar2(15) := 'bugfix';
g_h_type varchar2(15) := 'hotfix';
g_tech_email varchar2(50) := 'support@unity-bars.com';
g_tech_name varchar2(30) := 'UB_Install_Stats';

-- сравнение версий
-- возвращает:
-- 1 если версия1 > версия2
-- 2 если версия1 < версия2
-- 0 если версия1 = версия2
-- -1 если ошибка
function compare_versions(p_vers1 varchar2, p_vers2 varchar2) return number
  is
  l_vers1 varchar2(50) := trim('.' from regexp_substr(regexp_replace(p_vers1, '(\.)+', '.'), '(\d|\.)+'));
  l_vers2 varchar2(50) := trim('.' from regexp_substr(regexp_replace(p_vers2, '(\.)+', '.'), '(\d|\.)+'));
  l_result number := -1;
begin
  -- сон разума рождает чудовищ х_Х
  select case when nvl(to_number(vers1), -1) > nvl(to_number(vers2), -1) then 1 when nvl(to_number(vers1), -1) < nvl(to_number(vers2), -1) then 2 else 0 end into l_result
  from
  (
    select * from
    (
        select regexp_substr(l_vers1, '\d+', 1, cnt.rn) as vers1, cnt.rn as rn1
        from dual
        cross join
        (select rownum as rn from all_objects where rownum<=regexp_count(l_vers1, '\.')+1) cnt
    ) V1
    full outer join
    (
        select regexp_substr(l_vers2, '\d+', 1, cnt.rn) as vers2, cnt.rn as rn2
        from dual
        cross join
        (select rownum as rn from all_objects where rownum<=regexp_count(l_vers2, '\.')+1) cnt
    ) V2
    on v1.rn1 = v2.rn2
    order by greatest(rn1, rn2)
  )
  where nvl(vers1, -1) != nvl(vers2, -1) and rownum = 1;
  return l_result;
exception
  when no_data_found then return 0;
  when others then return -1;
end compare_versions;

procedure install_log(p_type varchar2, p_version varchar2, p_message varchar2)
    is
    pragma autonomous_transaction;
    l_dbname brm_install_log.dbname%type;
    l_install_id brm_install_log.rec_id%type;
begin
    select s_brm_install_log.nextval into l_install_id from dual;
    select v.name into l_dbname from v$database v;
        
    -- objects
    insert into brm_objects_hash (install_id,
                                  object_id,
                                  object_owner,
                                  object_type,
                                  object_name,
                                  object_ts,
                                  bars_hash)
    select l_install_id,
           ao.OBJECT_ID,
           ao.OWNER,
           ao.OBJECT_TYPE,
           ao.OBJECT_NAME,
           to_char(ao.TIMESTAMP),
           get_hash_object(ao.object_id)
    from all_objects ao
    where ao.OBJECT_TYPE in ('FUNCTION',
                             'PACKAGE',
                             'PACKAGE BODY',
                             'PROCEDURE',
                             'TRIGGER',
                             'TYPE',
                             'TYPE BODY',
                             'TABLE',
                             'VIEW',
                             'MATERIALIZED VIEW');
                             
    -- main log
    insert into brm_install_log (rec_id, 
                                 rec_date, 
                                 inst_type, 
                                 inst_name, 
                                 rec_message, 
                                 bars_hash,
                                 dbname,
                                 mfo,
                                 glbname,
                                 username,
                                 machine_name,
                                 machine_ip) 
    values (l_install_id, 
            sysdate, 
            p_type, 
            p_version, 
            p_message,
            get_install_hash(l_install_id),
            l_dbname,
            f_ourmfo_g,
            getglobaloption('GLB-NAME'),
            user_name,
            sys_context('userenv', 'terminal'),
            sys_context('userenv', 'ip_address'));
    
    commit;    
end;

-- отправка сообщения о результатах установки
procedure send_logs(p_install_name varchar2)
    is
    l_body clob;
    id_list number_list;
begin
    for rec in (select to_char(g.rec_id) || chr(9) 
                        || g.rec_date || chr(9) 
                        || g.inst_type || chr(9) 
                        || g.inst_name || chr(9) 
                        || g.rec_message || chr(9) 
                        || g.bars_hash || chr(9)
                        || g.dbname || chr(9)
                        || g.mfo || chr(9)
                        || g.glbname || chr(9)
                        || g.username || chr(9)
                        || g.machine_name || chr(9)
                        || g.machine_ip as line 
                from brm_install_log g
                where g.inst_name = p_install_name
                order by g.rec_id)
    loop
        l_body := l_body || rec.line || chr(10);
    end loop;
    begin
        select rec_id 
        bulk collect into id_list
        from
        (
            select rec_id
            from brm_install_log
            order by rec_id desc
        )
        where rownum<=3;    
            l_body := l_body || chr(10) || 'DIFF BEFORE' || chr(10) || diff_report(id_list(3), id_list(2)) || chr(10);
            
            l_body := l_body || chr(10) || 'DIFF AFTER' || chr(10) || diff_report(id_list(2), id_list(1)) || chr(10);
    exception
        when others then
            dbms_output.put_line('BRM: Ошибка построения отчета');
    end;
    
    begin
        bars_mail.to_mail(p_to_addr => g_tech_email,
                          p_to_name => g_tech_name,
                          p_subject => 'UB Install Stats: Installation '||p_install_name||' completed at '||to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'),
                          p_body    => l_body);
    exception
        when others then
            dbms_output.put_line('BRM: Не налаштовано поштовий сервіс, листа про завершення інсталляції не надіслано.');    
    end;
end send_logs;

-- лог начала установки обновления
procedure install_begin(p_version varchar2)
  is
  l_type varchar2(30) := lower(regexp_substr(p_version, '('||g_r_type||'|'||g_b_type||'|'||g_h_type||')', 1, 1, 'i'));
begin
    install_log(l_type, p_version, 'BEGIN');
end;

-- лог завершения установки обновления
procedure install_end(p_version varchar2)
  is
  l_type varchar2(30) := lower(regexp_substr(p_version, '('||g_r_type||'|'||g_b_type||'|'||g_h_type||')', 1, 1, 'i'));
begin
    install_log(l_type, p_version, 'END');
    send_logs(p_version);
end;

-- Проверить, не нарушалась ли последовательность установки в промежутке
-- возвращает 1 если не нарушалась или не было записей, -1 если порядок нарушен
function check_order(start_date date, end_date date) return number
  is
  l_res number;
begin
    select max(compare_result)
    into l_res
    from
    (
        select bars_release_mgr.compare_versions(b.inst_name, lag(b.inst_name) over(order by b.rec_id)) as compare_result
        from brm_install_log b
        where b.rec_date between start_date and end_date
    ) R;
  return case when l_res in (1, 0) then 1 when l_res = 2 then -1 end;
exception
    when no_data_found then return 1;
end;

-- Проверить, были ли ручные ddl-операции в промежутке
-- test
function get_ddl_audit(start_date date, end_date date) return t_audit
pipelined
  is
begin
  for rec in (select * from (
                                select * from sec_ddl_audit sd
                                where sd.rec_date between start_date and end_date
                                minus
                                select s.* from sec_ddl_audit s
                                join
                                (
                                select b1.rec_date rec_date_start, b2.rec_date rec_date_end
                                from    brm_install_log b1
                                join    brm_install_log b2 on b1.inst_name = b2.inst_name
                                                           and b1.rec_id = b2.rec_id - 1
                                                           and b1.rec_message = 'BEGIN'
                                                           and b2.rec_message = 'END'
                                ) brm_logs on s.rec_date between brm_logs.rec_date_start-0.001 and brm_logs.rec_date_end+0.001
                                where s.rec_date between start_date and end_date
                            )
                order by rec_id
            )
    loop
        pipe row (rec);
    end loop;
end get_ddl_audit;

-- возвращает данные из таблицы логов
function get_data(start_date date, end_date date) return t_err_results
pipelined
    is
begin
    for rec in (select rec_id,
                       rec_date,
                       inst_type,
                       inst_name,
                       rec_message
                from brm_install_log b
                where b.rec_date between start_date and end_date
                order by rec_id)
        loop
            pipe row (rec);
        end loop;
end get_data;

function get_hash_schema_objects
    return varchar2
    is
    l_md5_hash raw(32000);
begin
    for programs in (select s.TEXT 
                    from all_objects ao
                    join all_source s on ao.OBJECT_TYPE in ('FUNCTION',
                                                            'PACKAGE',
                                                            'PACKAGE BODY',
                                                            'PROCEDURE',
                                                            'TRIGGER',
                                                            'TYPE',
                                                            'TYPE BODY')
                                      and ao.owner = s.OWNER
                                      and ao.OBJECT_NAME = s.name
                                      and ao.OBJECT_TYPE = s.TYPE
                     where ao.owner = 'BARS'
                     order by ao.OBJECT_ID, s.line)
    loop
        l_md5_hash := dbms_crypto.Hash(l_md5_hash || dbms_crypto.Hash(utl_raw.cast_to_raw(programs.text), dbms_crypto.HASH_MD5), dbms_crypto.HASH_MD5);
    end loop;

    for tables in (select dbms_crypto.Hash(utl_raw.cast_to_raw(atc.COLUMN_NAME || atc.DATA_TYPE || atc.DATA_LENGTH), dbms_crypto.HASH_MD5) as md5hash 
                    from all_objects ao
                    join all_tab_columns atc on  ao.OBJECT_TYPE in ('TABLE', 'VIEW', 'MATERIALIZED VIEW') 
                                            and ao.owner = atc.owner 
                                            and ao.OBJECT_NAME = atc.TABLE_NAME
                    where ao.owner = 'BARS'
                    order by ao.object_id, atc.COLUMN_ID)
    loop
        l_md5_hash := dbms_crypto.Hash(l_md5_hash || tables.md5hash, dbms_crypto.HASH_MD5);
    end loop;
    
    return rawtohex(l_md5_hash);
end get_hash_schema_objects;

----------------------------------------------------------------------------------------
-- возвращает мд5-сумму объекта (program / table / view / mat.view)
function get_hash_object(p_object_id all_objects.OBJECT_ID%type)
    return varchar2
    is
    l_type all_objects.OBJECT_TYPE%type;
    l_md5_hash varchar2(32);
begin
    select t.OBJECT_TYPE
      into l_type
      from ALL_OBJECTS t
     where t.OBJECT_ID = p_object_id;
     
     if l_type in ('FUNCTION',
                   'PACKAGE',
                   'PACKAGE BODY',
                   'PROCEDURE',
                   'TRIGGER',
                   'TYPE',
                   'TYPE BODY')
     then
         for rec in (select s.TEXT 
                     from ALL_OBJECTS ao
                     join ALL_SOURCE s on ao.OWNER = s.OWNER 
                                       and ao.OBJECT_NAME = s.name 
                                       and ao.OBJECT_TYPE = s.TYPE 
                                       and ao.OBJECT_TYPE = l_type
                     where ao.OBJECT_ID = p_object_id
                     order by s.LINE
                    )
         loop
             l_md5_hash := dbms_crypto.Hash(l_md5_hash || dbms_crypto.Hash(utl_raw.cast_to_raw(rec.text), dbms_crypto.HASH_MD5), dbms_crypto.HASH_MD5);
         end loop;
     elsif l_type in ('TABLE', 'VIEW', 'MATERIALIZED VIEW') then
         for rec in (select dbms_crypto.Hash(utl_raw.cast_to_raw(atc.COLUMN_NAME || atc.DATA_TYPE || atc.DATA_LENGTH), dbms_crypto.HASH_MD5) as md5hash 
                    from ALL_OBJECTS ao
                    join ALL_TAB_COLUMNS atc on  ao.OBJECT_TYPE = l_type
                                            and ao.OWNER = atc.OWNER 
                                            and ao.OBJECT_NAME = atc.TABLE_NAME
                    where ao.OBJECT_ID = p_object_id
                    order by atc.COLUMN_ID)
         loop
             l_md5_hash := dbms_crypto.Hash(l_md5_hash || rec.md5hash, dbms_crypto.HASH_MD5);
         end loop;
     end if;
    return l_md5_hash;
end get_hash_object;

----------------------------------------------------------------------------------------
-- возвращает мд5-сумму объекта (program / table / view / mat.view)
function get_hash_object(p_owner all_objects.OWNER%type,
                         p_object_type all_objects.OBJECT_TYPE%type,
                         p_object_name all_objects.OBJECT_NAME%type
)
    return varchar2
is
    l_obj_id all_objects.OBJECT_ID%type;
begin
    begin
        select OBJECT_ID
          into l_obj_id
          from all_objects t
         where t.OWNER = p_owner
           and t.OBJECT_NAME = p_object_name
           and t.OBJECT_TYPE = p_object_type;
    exception
        when no_data_found then return null;
    end;
    
    return get_hash_object(p_object_id => l_obj_id);
end get_hash_object;

----------------------------------------------------------------------------------------
-- возвращает мд5-сумму по объектам на состояние инсталляции (ид в brm_install_log)
function get_install_hash(p_install_id brm_objects_hash.install_id%type)
    return varchar2
is
l_md5_hash varchar2(32);
begin
    for rec in (select bars_hash 
                from brm_objects_hash t 
                where t.install_id = p_install_id 
                order by t.object_id)
    loop
        l_md5_hash := dbms_crypto.Hash(l_md5_hash || rec.bars_hash, dbms_crypto.HASH_MD5);
    end loop;
    return l_md5_hash;
end get_install_hash;

----------------------------------------------------------------------------------------
-- выдает отчет об изменениях по объектам между записями инсталляций
function diff_report(p_install_id_start in brm_objects_hash.install_id%type, 
                      p_install_id_end in brm_objects_hash.install_id%type)
                      return clob
is
l_report clob;
tmp number;
begin
  begin
      select 1 into tmp from brm_objects_hash where install_id = p_install_id_start;
      select 1 into tmp from brm_objects_hash where install_id = p_install_id_end;
  exception
      when no_data_found then return l_report;
  end;
  -- нові об'єкти
  l_report := l_report || '==== NEW OBJECTS ====' || chr(10);
  for cur in (select *
                from (select oh.object_owner, oh.object_type, oh.object_name
                        from brm_objects_hash oh
                       where oh.install_id = p_install_id_end
                      minus
                      select oh.object_owner, oh.object_type, oh.object_name
                        from brm_objects_hash oh
                       where oh.install_id = p_install_id_start) t
               order by t.object_owner, t.object_type, t.object_name) loop
    l_report := l_report || 'owner - ' || cur.object_owner || ' object_type - ' ||
                         cur.object_type || ' object_name - ' ||
                         cur.object_name || chr(10);
  end loop;

  -- видалені об'єкти
  l_report := l_report || '==== DROPED OBJECTS ====' || chr(10);
  for cur in (select *
                from (select oh.object_owner, oh.object_type, oh.object_name
                        from brm_objects_hash oh
                       where oh.install_id = p_install_id_start
                      minus
                      select oh.object_owner, oh.object_type, oh.object_name
                        from brm_objects_hash oh
                       where oh.install_id = p_install_id_end) t
               order by t.object_owner, t.object_type, t.object_name) loop
    l_report := l_report || 'owner - ' || cur.object_owner || ' object_type - ' ||
                         cur.object_type || ' object_name - ' ||
                         cur.object_name || chr(10);
  end loop;

  -- змінені об'єкти
  l_report := l_report || '==== CHANGED OBJECTS ====' || chr(10);
  for cur in (select *
                from (select oh_s.object_owner,
                             oh_s.object_type,
                             oh_s.object_name,
                             oh_s.object_ts   as obj_ts_s,
                             oh_d.object_ts   as obj_ts_d,
                             oh_s.bars_hash   as obj_hash_s,
                             oh_d.bars_hash   as obj_hash_d
                        from brm_objects_hash oh_s,
                             brm_objects_hash oh_d
                       where oh_s.install_id = p_install_id_start
                         and oh_d.install_id = p_install_id_end
                         and oh_s.object_owner = oh_d.object_owner
                         and oh_s.object_type = oh_d.object_type
                         and oh_s.object_name = oh_d.object_name
                         and oh_s.bars_hash != oh_d.bars_hash) t
               order by t.object_owner, t.object_type, t.object_name) loop
    l_report := l_report || 'owner - ' || cur.object_owner || ' object_type - ' ||
                         cur.object_type || ' object_name - ' ||
                         cur.object_name || ' obj_ts_s - ' || cur.obj_ts_s ||
                         ' obj_ts_d - ' || cur.obj_ts_d ||
                         ' obj_hash_s - ' || cur.obj_hash_s ||
                         ' obj_hash_d - ' || cur.obj_hash_d || chr(10);
  end loop;
  return l_report;
end diff_report;

end bars_release_mgr;
/
show errors;