create or replace package bars_release_mgr
is

g_head_version varchar2(50) := '1.0.0';


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


end bars_release_mgr;
/
grant execute on bars_release_mgr to public;
/
create or replace public synonym brm for bars.bars_release_mgr;
/
create or replace package body bars_release_mgr
is

g_body_version varchar2(100) := '1.0.0';
g_r_type varchar2(15) := 'release';
g_b_type varchar2(15) := 'bugfix';
g_h_type varchar2(15) := 'hotfix';

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

-- лог начала установки обновления
procedure install_begin(p_version varchar2)
  is
  l_type varchar2(30) := lower(regexp_substr(p_version, '('||g_r_type||'|'||g_b_type||'|'||g_h_type||')', 1, 1, 'i'));
  pragma autonomous_transaction;
begin
    insert into brm_install_log (rec_id, rec_date, inst_type, inst_name, rec_message) values (s_brm_install_log.nextval, sysdate, l_type, p_version, 'BEGIN');
    commit;
end;

-- лог завершения установки обновления
procedure install_end(p_version varchar2)
  is
  l_type varchar2(30) := lower(regexp_substr(p_version, '('||g_r_type||'|'||g_b_type||'|'||g_h_type||')', 1, 1, 'i'));
  pragma autonomous_transaction;
begin
    insert into brm_install_log (rec_id, rec_date, inst_type, inst_name, rec_message) values (s_brm_install_log.nextval, sysdate, l_type, p_version, 'END');
    commit;
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

end bars_release_mgr;
/
show errors;