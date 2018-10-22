prompt ... =========================================
prompt ... === initialization v0.1 11.10.2018
prompt ... =========================================

set serveroutput on size 1000000
col cur_time new_value g_cur_time
select to_char(sysdate, 'yyyymmddhh24mi') as cur_time from dual;
spool log\010_initialization_&g_cur_time.log
set lines 3000
set time on
set timing on

prompt ... === saving of disabled objects into tmp_disabled_objects
begin
  execute immediate 'drop table tmp_disabled_objects';
  exception when others then
  if sqlcode = -00942 then null; else raise; end if;
end;
/

create table tmp_disabled_objects
as
select 'alter table '||t.TABLE_NAME||' modify constraint '||t.CONSTRAINT_NAME||' disable ' as stmt
       from all_constraints t
where t.OWNER = 'BARS'
and t.status = 'DISABLED'
and t.CONSTRAINT_TYPE in ('C', 'R')
order by t.TABLE_NAME, t.CONSTRAINT_NAME
;

insert into tmp_disabled_objects
select 'alter trigger '||t.TRIGGER_NAME||' disable' from all_triggers t
where t.OWNER = 'BARS'
and t.status = 'DISABLED'
order by t.TRIGGER_NAME
;
commit;
/


prompt ... === saving of disabled policeis into tmp_disabled_policeis
begin
  execute immediate 'drop table tmp_disabled_policies';
  exception when others then
  if sqlcode = -00942 then null; else raise; end if;
end;
/

create table tmp_disabled_policies
as
select distinct t.OBJECT_OWNER, t.OBJECT_NAME
  from all_policies t
 where t.OBJECT_OWNER = 'BARS'
   and t.ENABLE = 'NO'
 order by 1
;
commit;
/

prompt ... === saving of refs from bars.oper into bars.tmp_oper_cp_cim 
begin
  execute immediate 'drop table bars.tmp_oper_cp_cim';
  exception when others then
  if sqlcode = -00942 then null; else raise; end if;
end;
/

create table bars.tmp_oper_cp_cim
as
select t.*
  from bars.oper t
  join (
        select REF from bars.cp_deal  --REF (модуль ЦП)
         union
        select REF from bars.cim_payments_bound --REF (модуль ВК)
       ) tt
    on t.ref = tt.ref 
;
/

prompt ... === saving of refs from bars.opldok into bars.tmp_opldok_cp_cim 
begin
  execute immediate 'drop table bars.tmp_opldok_cp_cim';
  exception when others then
  if sqlcode = -00942 then null; else raise; end if;
end;
/

create 
--drop
table bars.tmp_opldok_cp_cim
as
select t.*
  from bars.opldok t
  join (
        select REF from bars.cp_deal  --REF (модуль ЦП)
         union
        select REF from bars.cim_payments_bound --REF (модуль ВК)
       ) tt
    on t.ref = tt.ref 
;
/

prompt ... === disable constraints and triggers start

declare
cursor cur is
    select upper(table_name) tab_name from all_tables
    where owner = 'BARS'
    /*and not lower(table_name) in
    ('cim_f36')*/;
    type t_cur_ut is table of user_tables.table_name%type index by pls_integer;
    l_cur_ut t_cur_ut;
    v_counter pls_integer := 0;
procedure disable_table_obj
  is
    begin
        for rec in cur loop
        v_counter := v_counter + 1;
        l_cur_ut(v_counter) := rec.tab_name;
           mgr_utl.p_constraints_chk_disable  (l_cur_ut(v_counter));
         mgr_utl.p_constraints_fk_disable   (l_cur_ut(v_counter));
         --mgr_utl.p_ref_constraints_en_novalid  (l_cur_ut(v_counter));
         mgr_utl.p_triggers_disable             (l_cur_ut(v_counter));
    end loop;
    exception when others then
        raise;
    mgr_utl.save_error();
end disable_table_obj;
begin
 disable_table_obj();
end;
/

prompt ... === disable constraints and triggers finished

prompt ... === create supporting objects start
create or replace function tmp_get_hv_date(p_hv_stmt in varchar2)
  return date is
  l_date date;
begin
  begin
    execute immediate 'select ' || p_hv_stmt || ' from dual'
      into l_date;
  exception
    when others then
      l_date := null;
  end;
  return l_date;
end tmp_get_hv_date;
/
create or replace procedure p_trunc_partitions(s_owner varchar2 default 'BARS', s_table varchar2, d_min_date date default trunc(sysdate, 'Q'))
is
d_high_value date;
v_owner varchar2(30) := upper(s_owner);
v_table varchar2(30) := upper(s_table);
begin
for rec in (

            select t.table_owner
                 , t.table_name
                 , t.partition_name
                 , t.high_value
              from dba_tab_partitions t
             where t.table_owner = v_owner
               and t.table_name = upper(v_table)
               and t.partition_name not like '%MAXVALUE'
            )

loop
  execute immediate 'select '||rec.high_value||' from dual' into d_high_value;
  if d_high_value <= d_min_date
     then
     begin
       execute immediate 'alter table '||rec.table_owner||'.'||rec.table_name||' truncate PARTITION '||rec.partition_name;
       dbms_output.put_line('alter table '||rec.table_owner||'.'||rec.table_name||' truncate PARTITION '||rec.partition_name);
     exception
     when others then dbms_output.put_line(sqlerrm);
     end;
  end if;
end loop;
end;
/

create or replace procedure p_drop_partitions(s_owner varchar2 default 'BARS', s_table varchar2, d_min_date date default trunc(sysdate, 'Q'))
is
d_high_value date;
v_owner varchar2(30) := upper(s_owner);
v_table varchar2(30) := upper(s_table);
begin
for rec in (  

            select t.table_owner
                 , t.table_name
                 , t.partition_name
                 , t.high_value
              from dba_tab_partitions t
             where t.table_owner = v_owner
               and t.table_name = upper(v_table)
               and t.partition_name not like '%MAXVALUE'
               and t.partition_position > 1
            )

loop
  execute immediate 'select '||rec.high_value||' from dual' into d_high_value;
  if d_high_value <= d_min_date
     then
     begin 
       execute immediate 'alter table '||rec.table_owner||'.'||rec.table_name||' drop PARTITION '||rec.partition_name;
       dbms_output.put_line('alter table '||rec.table_owner||'.'||rec.table_name||' drop PARTITION '||rec.partition_name);
     exception
     when others then dbms_output.put_line(sqlerrm);
     end;
  end if;
end loop;
end;
/

begin
  execute immediate 'drop table tmp_del_kf_list';
  exception when others then
  if sqlcode = -00942 then null; else raise; end if;
end;
/

    begin
        execute immediate 'create --drop
                                   table tmp_del_kf_list (  tab_name varchar2(30)
                                                          , partition_name varchar2(30)
                                                          , subpartition_name varchar2(30)
                                                          , kf_ varchar2(6) 
                                                          , count_del_rows integer 
                                                          , errm varchar2(2000) 
                                                          , sysdt date) tablespace BRSMDLD';
     exception when others then 
        if sqlcode = -955 then null; 
          else raise; 
        end if; 
    end;
/

@depersonalization.pck

prompt ... === create supporting objects finished


prompt ... === dbms_stats.gather_table_stats started

begin
  for rec in (select owner, table_name from all_tab_statistics t
               where t.OWNER = 'BARS'
                 and t.TABLE_NAME in (  'CUSTOMER', 'CUSTOMER_UPDATE', 'CUSTOMER_REL', 'CUSTOMER_REL_UPDATE', 'CUSTOMER_ADDRESS', 'CUSTOMER_ADDRESS_UPDATE'
                                      , 'PERSON', 'PERSON_UPDATE', 'CUSTOMERW', 'CUSTOMERW_UPDATE', 'ACCOUNTS', 'ACCOUNTS_UPDATE', 'ARC_RRP', 'OPER', 'OPLDOK', 'OPERW'
                                      , 'EAD_DOCS', 'CUSTOMER_IMAGES')
                 and t.PARTITION_NAME is null
                 --and nvl(t.STALE_STATS, 'YES') = 'YES'
             )
  loop
    --dbms_stats.gather_table_stats(ownname => rec.owner, tabname => rec.table_name, degree => 4, cascade => true, estimate_percent => 5);
    dbms_stats.set_table_prefs(ownname => rec.owner, tabname => rec.table_name, pname => 'STALE_PERCENT', pvalue => 100);
  end loop;
end;
/

begin
  for rec in (select owner, table_name from all_tab_statistics t
               where t.OWNER = 'BARS'
                 and t.TABLE_NAME in (  'CUSTOMER', 'CUSTOMER_UPDATE', 'CUSTOMER_REL', 'CUSTOMER_REL_UPDATE', 'CUSTOMER_ADDRESS', 'CUSTOMER_ADDRESS_UPDATE'
                                      , 'PERSON', 'PERSON_UPDATE', 'CUSTOMERW', 'CUSTOMERW_UPDATE', 'ACCOUNTS', 'ACCOUNTS_UPDATE', 'ARC_RRP', 'OPER', 'OPLDOK', 'OPERW'
                                      , 'EAD_DOCS', 'CUSTOMER_IMAGES')
                 and t.PARTITION_NAME is null
                 and nvl(t.STALE_STATS, 'YES') = 'YES'
             )
  loop
    dbms_stats.gather_table_stats(ownname => rec.owner, tabname => rec.table_name, degree => 4, cascade => true, estimate_percent => 5);
    --dbms_stats.set_table_prefs(ownname => rec.owner, tabname => rec.table_name, pname => 'STALE_PERCENT', pvalue => 100);
  end loop;
end;
/

prompt ... === dbms_stats.gather_table_stats finished

spool off
quit
